import 'package:flutter/material.dart';

class SpaceTypeSelectionScreen extends StatelessWidget {
  const SpaceTypeSelectionScreen({super.key});

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
                '¿Cuál de estas opciones describe mejor tu espacio?',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildSpaceTypeButton(
                      context,
                      imagePath: 'assets/space_type_icons/image_casa_playa.png',
                      label: 'Casa de playa',
                      onPressed: () {},
                    ),
                    _buildSpaceTypeButton(
                      context,
                      imagePath:
                          'assets/space_type_icons/image_casa_urbana.png',
                      label: 'Casa urbana',
                      onPressed: () {},
                    ),
                    _buildSpaceTypeButton(
                      context,
                      imagePath:
                          'assets/space_type_icons/image_salon_elegante.png',
                      label: 'Salones elegantes',
                      onPressed: () {},
                    ),
                    _buildSpaceTypeButton(
                      context,
                      imagePath: 'assets/space_type_icons/image_casa_campo.png',
                      label: 'Casa de campo',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Acción para Atrás
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE4AC44)),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Atrás'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para Siguiente
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

  Widget _buildSpaceTypeButton(BuildContext context,
      {required String imagePath,
      required String label,
      required VoidCallback onPressed}) {
    return Container(
      height: 120, // Aumenta la altura del contenedor
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE4AC44)),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath,
                height: 100), // Aumenta la altura de la imagen
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
