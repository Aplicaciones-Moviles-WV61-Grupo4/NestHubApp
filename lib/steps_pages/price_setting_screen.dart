import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nesthub/features/local/domain/local.dart';
import 'package:nesthub/features/local/data/remote/local_service.dart';
import 'package:nesthub/steps_pages/publish_screen.dart';

class PriceSettingScreen extends StatefulWidget {
  final String district;
  final String city;
  final String street;
  final int localCategoryId;
  final String photoUrl;
  final String title;
  final String description;

  const PriceSettingScreen({
    super.key,
    required this.district,
    required this.city,
    required this.street,
    required this.localCategoryId,
    required this.photoUrl,
    required this.title,
    required this.description,
  });

  @override
  _PriceSettingScreenState createState() => _PriceSettingScreenState();
}

class _PriceSettingScreenState extends State<PriceSettingScreen> {
  final TextEditingController _priceController = TextEditingController();
  final LocalService _localService = LocalService();

  Future<void> _submitData() async {
    final String price = _priceController.text;

    final localData = Local(
      district: widget.district,
      street: widget.street,
      title: widget.title,
      city: widget.city,
      price: int.parse(price),
      photoUrl: widget.photoUrl,
      descriptionMessage: widget.description,
      localCategoryId: widget.localCategoryId,
      userId: 1,
    );

    try {
      await _localService.pushLocal(localData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublishScreen(localData: localData),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el local: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Establece el precio',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Puedes cambiarlo cuando quieras',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Ingresa el precio',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Precio para el huésped (no incluye los impuestos), con impuestos sería S/. 120',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Regresar a la página anterior
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF01698C)),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Atrás'),
                  ),
                  ElevatedButton(
                    onPressed:
                        _submitData, // Llamar a la función para enviar datos
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01698C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Siguiente'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
