import 'package:flutter/material.dart';
import 'package:nesthub/price_setting_screen.dart';
import 'package:nesthub/publishing_page.dart';

class Step3Page extends StatelessWidget {
  final String district;
  final String city;
  final String street;
  final int localCategoryId;
  final String photoUrl;
  final String title;
  final String description;

  const Step3Page({
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Color gris claro
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50), // Espacio antes de la imagen
              Center(
                child: Image.asset(
                  'assets/steps_icons/step3.png', // Ruta de la imagen
                  height: 300,
                  fit: BoxFit
                      .contain, // Ajusta la altura de la imagen según sea necesario
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Paso 3',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Terminar y publicar',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Por último, vas a elegir el precio y publicar tu espacio.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const Spacer(), // Espacio flexible para empujar los botones hacia abajo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PublishingPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Color del botón Atrás
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Atrás',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PriceSettingScreen(
                            district: district,
                            city: city,
                            street: street,
                            localCategoryId: localCategoryId,
                            photoUrl: photoUrl,
                            title: title,
                            description: description,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF01698C), // Color del botón Siguiente
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height: 20), // Añadir algo de espacio después de los botones
            ],
          ),
        ),
      ),
    );
  }
}
