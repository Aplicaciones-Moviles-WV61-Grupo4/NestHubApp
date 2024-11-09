import 'package:flutter/material.dart';
import 'package:nesthub/location_setting_screen.dart';

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
                      localCategoryId: 1,
                    ),
                    _buildSpaceTypeButton(
                      context,
                      imagePath:
                          'assets/space_type_icons/image_casa_urbana.png',
                      label: 'Casa urbana',
                      localCategoryId: 2,
                    ),
                    _buildSpaceTypeButton(
                      context,
                      imagePath:
                          'assets/space_type_icons/image_salon_elegante.png',
                      label: 'Salones elegantes',
                      localCategoryId: 3,
                    ),
                    _buildSpaceTypeButton(
                      context,
                      imagePath: 'assets/space_type_icons/image_casa_campo.png',
                      label: 'Casa de campo',
                      localCategoryId: 4,
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
                      Navigator.pop(context); // Regresar a la página anterior
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpaceTypeButton(
    BuildContext context, {
    required String imagePath,
    required String label,
    required int localCategoryId,
  }) {
    return SizedBox(
      height: 120,
      child: OutlinedButton(
        onPressed: () {
          // Navegar a LocationSettingScreen con el localCategoryId seleccionado
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LocationSettingScreen(localCategoryId: localCategoryId),
            ),
          );
        },
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
            Image.asset(imagePath, height: 100),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
