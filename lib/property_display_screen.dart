import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyDisplayScreen extends StatefulWidget {
  const PropertyDisplayScreen({super.key});

  @override
  _PropertyDisplayScreenState createState() => _PropertyDisplayScreenState();
}

class _PropertyDisplayScreenState extends State<PropertyDisplayScreen> {
  late GoogleMapController mapController;

  final LatLng _center =
      const LatLng(-12.1416, -77.0219); // Barranco, Lima coordinates

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Propiedad'), // Título de la pantalla
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Icono de flecha hacia atrás
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Imagen (si es necesario)
              // Image.network(
              //   'https://example.com/loft-image.jpg',
              //   height: 250,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              const Text(
                'Loft en Barranco - Casa Urbana',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Vivienda rentada entero en Lima, Perú'),
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
              const Text(
                  'Apartamento de 1 dormitorio con aire acondicionado con vista parcial al mar, una ubicación fantástica, situado en el corazón de Barranco. El apartamento tiene una puerta bohemia y tradicional.'),
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
                  onMapCreated: _onMapCreated,
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
                  const Text('\$35 / noche',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      // Handle reservation
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

  Widget _buildFeature(IconData icon, String title, String description) {
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

  Widget _buildAmenity(IconData icon, String name) {
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

  Widget _buildReview(String name, String comment) {
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
