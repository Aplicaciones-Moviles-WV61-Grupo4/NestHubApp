import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nesthub/features/local/domain/local.dart';

class LocalDetailScreen extends StatelessWidget {
  const LocalDetailScreen({super.key, required this.localModel});
  final Local localModel;

  final LatLng _center = const LatLng(-12.1416, -77.0219);

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
              Image.network(
                localModel.photoUrl,
                height: height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                localModel.street, // Cambiado para usar streetAddress
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(localModel.city, // Cambiado para usar cityPlace
                  style: const TextStyle(fontSize: 16)),
              const Text('4 huéspedes · 1 habitación · 2 camas · 1 baño'),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Text('4.92 · 10 reseñas',
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
              Text(
                  localModel
                      .descriptionMessage, // Cambiado para usar descriptionMessage
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
              const Text('Barranco, Lima, Perú'),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {},
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  SizedBox(width: 4),
                  Text('4.92 · 10 reseñas',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              _buildReview('Franco Perez',
                  'Excelente alojamiento, todo igual a las fotos y en un muy buen estado.'),
              _buildReview('Javier Castro',
                  'Excelente ubicación, cerca de tiendas y restaurantes.'),
              _buildReview('Miguel Pino',
                  'El anfitrión fue muy receptivo, que incluye el estacionamiento es un plus.'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${localModel.price} / noche', // Cambiado para usar nightPrice
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

  static Widget _buildAmenity(IconData icon, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(name),
        ],
      ),
    );
  }

  static Widget _buildReview(String name, String comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(comment),
        ],
      ),
    );
  }
}
