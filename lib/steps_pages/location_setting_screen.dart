import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:nesthub/steps_pages/address_confirmation_screen.dart';
import 'package:nesthub/steps_pages/step_1_page.dart';

class LocationSettingScreen extends StatefulWidget {
  final int localCategoryId;

  const LocationSettingScreen({super.key, required this.localCategoryId});

  @override
  _LocationSettingScreenState createState() => _LocationSettingScreenState();
}

class _LocationSettingScreenState extends State<LocationSettingScreen> {
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  loc.Location location = loc.Location();
  bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;
  loc.LocationData? _locationData;

  final TextEditingController _streetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          _showErrorDialog('Los servicios de ubicación están desactivados');
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == loc.PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != loc.PermissionStatus.granted) {
          _showErrorDialog(
              'Se requiere permiso de ubicación para esta funcionalidad');
          return;
        }
      }

      _locationData = await location.getLocation();
      setState(() {
        _currentPosition =
            LatLng(_locationData!.latitude!, _locationData!.longitude!);
      });

      mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      _showErrorDialog(
          'No se pudo obtener la ubicación. Por favor, inténtalo de nuevo.');
    }
  }

  Future<void> _updateMapLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        LatLng newPosition =
            LatLng(locations.first.latitude, locations.first.longitude);

        setState(() {
          _currentPosition = newPosition;
        });

        mapController
            .animateCamera(CameraUpdate.newLatLngZoom(newPosition, 15.0));
      } else {
        _showErrorDialog('No se encontró la ubicación ingresada.');
      }
    } catch (e) {
      print('Error al actualizar la ubicación en el mapa: $e');
      _showErrorDialog('Hubo un problema al encontrar la ubicación.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Solo compartiremos tu dirección con los huéspedes que hayan hecho una reservación',
                style: TextStyle(
                  fontSize: 8,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Ingresa la calle',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) => _updateMapLocation(value),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition ?? const LatLng(-12, 23),
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
                          vertical: 8, horizontal: 24),
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
                            localCategoryId: widget.localCategoryId,
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
