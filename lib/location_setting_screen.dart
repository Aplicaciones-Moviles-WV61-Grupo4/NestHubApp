import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nesthub/address_confirmation_screen.dart';
import 'package:nesthub/step_1_page.dart';

class LocationSettingScreen extends StatefulWidget {
  final int localCategoryId; // Añade este parámetro

  const LocationSettingScreen(
      {super.key, required this.localCategoryId}); // Modifica el constructor

  @override
  _LocationSettingScreenState createState() => _LocationSettingScreenState();
}

class _LocationSettingScreenState extends State<LocationSettingScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(-12.1416, -77.0219);

  // Controlador para el campo de street
  final TextEditingController _streetController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    _streetController.dispose();
    super.dispose();
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
                '¿Dónde se encuentra tu espacio?',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Solo compartiremos tu dirección con los huéspedes que hayan hecho una reservación',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              ),
              const SizedBox(height: 24),
              // Campo de texto para street
              TextField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Ingresa la calle',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Google Map
              SizedBox(
                height: 200,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 15.0,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Step1Page()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE4AC44)),
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
                    onPressed: () {
                      String street = _streetController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressConfirmationScreen(
                            street: street,
                            localCategoryId: widget
                                .localCategoryId, // Pasa el localCategoryId aquí
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE4AC44),
                      foregroundColor: Colors.white,
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
