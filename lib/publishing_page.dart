import 'package:flutter/material.dart';

class PublishingPage extends StatelessWidget {
  const PublishingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Empieza a publicar tu espacio en NestHub',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 70),
              _buildStep(
                title: 'Describe tu espacio',
                description:
                    'Comparte algunos datos básicos, como la ubicación y cuántos huéspedes pueden quedarse.',
                iconAsset: 'assets/steps_icons/step1.png',
                iconHeight: 80,
                iconWidth: 90,
              ),
              const SizedBox(height: 40),
              _buildStep(
                title: 'Destaca tu espacio',
                description:
                    'Agrega al menos 5 fotos, un título y una descripción.',
                iconAsset: 'assets/steps_icons/step2.png',
              ),
              const SizedBox(height: 40),
              _buildStep(
                title: 'Terminar y publicar',
                description:
                    'Elige un precio inicial, verifica algunos detalles y publica tu anuncio.',
                iconAsset: 'assets/steps_icons/step3.png',
                iconHeight: 80,
                iconWidth: 80,
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB44101),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Comencemos',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required String title,
    required String description,
    required String iconAsset,
    double iconHeight = 70,
    double iconWidth = 70,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
        Image.asset(iconAsset, height: iconHeight, width: iconWidth), // Ajuste del tamaño del ícono
        const SizedBox(width: 20),
      ],
    );
  }
}