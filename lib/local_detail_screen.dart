import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/favorite/app_database.dart';
import 'package:nesthub/features/local/domain/local.dart';
import 'package:nesthub/features/review/data/remote/review_dto.dart';
import 'package:nesthub/features/review/domain/review.dart';

class LocalDetailScreen extends StatefulWidget {
  const LocalDetailScreen({super.key, required this.localModel});
  final Local localModel;

  @override
  _LocalDetailScreenState createState() => _LocalDetailScreenState();
}

class _LocalDetailScreenState extends State<LocalDetailScreen> {
  bool isFavorite = false;
  LatLng? _location;
  List<Review> reviews = [];
  bool isLoading = true;

  final LatLng _defaultCenter = const LatLng(-12.1416, -77.0219);

  @override
  void initState() {
    super.initState();
    _getLocationFromAddress(widget.localModel.street);
    _fetchReviews();
  }

  Future<void> _checkIfFavorite() async {
    try {
      final db = await AppDatabase().openDb();
      final result = await db.query(
        'favorites',
        where: 'userId = ?',
        whereArgs: [widget.localModel.userId],
      );

      setState(() {
        isFavorite = result.isNotEmpty;
      });
    } catch (e) {
      print('Error al verificar favoritos: $e');
    }
  }

  Future<void> _getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          _location =
              LatLng(locations.first.latitude, locations.first.longitude);
        });
      }
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      setState(() {
        _location = _defaultCenter;
      });
    }
  }

  Future<void> _fetchReviews() async {
    final String url = AppConstants.baseUrl +
        AppConstants.reviewFromLocalEndpoint(widget.localModel.id);

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
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Propiedad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildHeader(height),
              const SizedBox(height: 16),
              Text(
                widget.localModel.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(widget.localModel.city,
                  style: const TextStyle(fontSize: 16)),
              const Text('4 huéspedes · 1 habitación · 2 camas · 1 baño'),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  Text(
                    '${averageRating.toStringAsFixed(2)} · ${reviews.length} ${reviews.length == 1 ? 'reseña' : 'reseñas'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Anfitrión: Lucas',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('1 año anfitrionando'),
              const SizedBox(height: 16),
              _buildFeature(Icons.vpn_key, 'Llegada autónoma',
                  'Realiza la llegada fácilmente mediante la cerradura con teclado.'),
              _buildFeature(Icons.location_on, 'Ubicación fantástica',
                  'Gracias a las reseñas, podemos estar seguros que es un buen lugar'),
              const SizedBox(height: 16),
              const Text('Descripción',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(widget.localModel.descriptionMessage,
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 16),
              const Text('Qué servicios ofrece',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildAmenity(Icons.kitchen, 'Cocina'),
              _buildAmenity(Icons.wifi, 'Wifi'),
              _buildAmenity(Icons.laptop, 'Zona de trabajo'),
              _buildAmenity(Icons.local_parking,
                  'Estacionamiento gratuito en las instalaciones'),
              _buildAmenity(Icons.pool, 'Piscina al aire libre compartida'),
              const SizedBox(height: 16),
              const Text('A dónde irás',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(widget.localModel.street,
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              if (_location != null)
                SizedBox(
                  height: 200,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {},
                    initialCameraPosition: CameraPosition(
                      target: _location!,
                      zoom: 15.0,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              const Text('Reseñas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ..._buildReviews(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('S/ ${widget.localModel.price} / noche',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      // Manejar la reserva
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01698C),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Reservar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double height) {
    return Stack(
      children: [
        Image.network(
          widget.localModel.photoUrl,
          height: height * 0.25,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () async {
                setState(() {
                  isFavorite = !isFavorite;
                });
                final db = await AppDatabase().openDb();
                if (isFavorite) {
                  await db.insert('favorites', {
                    'userId': widget.localModel.userId,
                    'district': widget.localModel.district,
                    'street': widget.localModel.street,
                    'title': widget.localModel.title,
                    'city': widget.localModel.city,
                    'price': widget.localModel.price,
                    'photoUrl': widget.localModel.photoUrl,
                    'descriptionMessage': widget.localModel.descriptionMessage,
                    'localCategoryId': widget.localModel.localCategoryId,
                  });
                } else {
                  await db.delete('favorites',
                      where: 'userId = ?',
                      whereArgs: [widget.localModel.userId]);
                }
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.yellow.shade800,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildFeature(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildAmenity(IconData icon, String amenity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(amenity),
        ],
      ),
    );
  }

  List<Widget> _buildReviews() {
    if (reviews.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No hay reseñas aún',
              style: TextStyle(fontStyle: FontStyle.italic)),
        ),
      ];
    }

    return reviews.map((review) {
      return _buildReview(review.rating, review.comment);
    }).toList();
  }

  Widget _buildReview(int rating, String comment) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Row(
        children: List.generate(5, (index) {
          return Icon(
            Icons.star,
            color: index < rating ? Colors.orange : Colors.grey,
          );
        }),
      ),
      subtitle: Text(comment),
    );
  }
}
