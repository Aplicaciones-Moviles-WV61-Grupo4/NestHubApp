import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nesthub/features/local/domain/local.dart';
import 'package:nesthub/core/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:nesthub/features/review/data/remote/review_dto.dart';
import 'package:nesthub/features/review/domain/review.dart';
import 'package:nesthub/home_screen.dart';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class ReservationPage extends StatefulWidget {
  final Local local;

  const ReservationPage({super.key, required this.local});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime? startDate;
  DateTime? endDate;
  String couponCode = '';
  double discount = 0.0;
  bool isCouponValid = false;
  List<Review> reviews = [];
  bool isLoading = true;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    // Configurar el plugin para notificaciones locales
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Acciones opcionales cuando el usuario interactúa con la notificación
      print('Notificación seleccionada: ${response.payload}');
    },
  );

    _fetchReviews();
  }
  Future<void> _requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

  Future<void> _showNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'reservation_channel', // ID único del canal
    'Reservas', // Nombre del canal
    channelDescription: 'Notificaciones para confirmación de reservas',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    playSound: true, // Asegúrate de habilitar el sonido
    enableVibration: true, // Habilita vibraciones
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // ID único para la notificación
    'Reserva confirmada', // Título
    'Tu reserva ha sido confirmada exitosamente.', // Mensaje
    notificationDetails,
    payload: 'Reserva realizada', // Opcional, útil para manejar interacciones
  );
}



  Future<void> _fetchReviews() async {
    final String url = AppConstants.baseUrl +
        AppConstants.reviewFromLocalEndpoint(widget.local.id);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          reviews = data
              .map((json) => Review.fromDto(ReviewDto.fromJson(json)))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  double get averageRating {
    if (reviews.isEmpty) return 0;
    int totalRating = reviews.fold(0, (sum, review) => sum + review.rating);
    return totalRating / reviews.length;
  }
  @override
  Widget build(BuildContext context) {
    // Calcular el número de noches
    int totalNights = startDate != null && endDate != null
        ? endDate!.difference(startDate!).inDays
        : 0;

    // Calcular costos
    double basePrice = totalNights * widget.local.price.toDouble();
    double cleaningFee = basePrice * 0.15;
    double totalPrice = basePrice + cleaningFee - discount;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirma y paga'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildPropertyHeader(),
              const SizedBox(height: 16),
              _buildSectionTitle('Tu viaje'),
              const SizedBox(height: 8),
              _buildEditableDates('Fechas', startDate, endDate),
              const SizedBox(height: 16),
              _buildSectionTitle('Información del precio'),
              const SizedBox(height: 8),
              _buildPriceInfo(basePrice, cleaningFee, discount, totalPrice, totalNights),
              const SizedBox(height: 16),
              _buildSectionTitle('Cupones'),
              const SizedBox(height: 8),
              _buildCouponSection(),
              const SizedBox(height: 16),
              _buildSectionTitle('Política de cancelación'),
              const SizedBox(height: 8),
              const Text(
                'Si cancelas la reserva antes de la fecha reservada, recibirás un reembolso completo.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
  onPressed: totalNights > 0
      ? () async {
        // Solicitar permisos para notificaciones
          await _requestNotificationPermission();
           // Mostrar notificación
          await _showNotification();
          // Confirmar la reserva
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reserva confirmada. ¡Gracias!'),
              backgroundColor: Colors.green,
            ),
          );

         

          // Navegar a home_screen.dart
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      : null,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: const Text(
    'Confirma y paga',
    style: TextStyle(color: Colors.white, fontSize: 16),
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.local.photoUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.local.district,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                widget.local.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
  children: [
    const Icon(Icons.star, color: Colors.orange, size: 16),
    const SizedBox(width: 4),
    Text(
      '${averageRating.toStringAsFixed(2)} · ${reviews.length} ${reviews.length == 1 ? 'reseña' : 'reseñas'}',
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ],
),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditableDates(String title, DateTime? start, DateTime? end) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        GestureDetector(
          onTap: () async {
            final pickedDates = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1),
            );
            if (pickedDates != null) {
              setState(() {
                startDate = pickedDates.start;
                endDate = pickedDates.end;
              });
            }
          },
          child: Text(
            start != null && end != null
                ? '${DateFormat('dd/MM/yyyy').format(start)} - ${DateFormat('dd/MM/yyyy').format(end)}'
                : 'Seleccionar fechas',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInfo(double basePrice, double cleaningFee, double discount,
      double totalPrice, int totalNights) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceRow('${widget.local.price} x $totalNights noches', basePrice),
        _buildPriceRow('Tarifa de limpieza', cleaningFee),
        _buildPriceRow('Descuento', -discount),
        const Divider(),
        _buildPriceRow('Total', totalPrice, isBold: true),
      ],
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text('S/ ${amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Tienes un cupón?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            _showCouponDialog();
          },
          child: const Text('Ingresar cupón'),
        ),
      ],
    );
  }

  Future<void> _showCouponDialog() async {
  String inputCoupon = '';
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Ingresa tu cupón'),
        content: TextField(
          decoration: const InputDecoration(hintText: 'Código de cupón'),
          onChanged: (value) {
            inputCoupon = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (inputCoupon == 'PROFMAYTA20') {
                  double basePrice = startDate != null && endDate != null
                      ? endDate!.difference(startDate!).inDays * widget.local.price.toDouble()
                      : 0.0;
                  discount = basePrice * 0.15; // Aplica el 15% de descuento
                  isCouponValid = true;
                } else {
                  discount = 0.0;
                  isCouponValid = false;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Aplicar'),
          ),
        ],
      );
    },
  );

  if (!isCouponValid) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cupón inválido', style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
