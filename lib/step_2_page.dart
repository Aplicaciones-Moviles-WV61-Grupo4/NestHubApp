import 'package:flutter/material.dart';
import 'package:nesthub/publishing_page.dart';
//import 'package:nesthub/step_3_page.dart';

class Step2Page extends StatelessWidget {
  const Step2Page({super.key});

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
                  'assets/steps_icons/step2.png', // Ruta de la imagen
                  height: 250,
                  fit: BoxFit.contain, // Ajusta la altura de la imagen según sea necesario
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Paso 2',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Haz que tu espacio destaque',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'En este paso, debéras agregar algunas fotos de tu espacio. Luego, debeás crear un título y una descripción.',
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
                        MaterialPageRoute(builder: (context) => const PublishingPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Color del botón Atrás
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                      // Navigator.push(
                      //   context, 
                      //   MaterialPageRoute(builder: (context) => const Step3Page()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF018648), // Color del botón Siguiente
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
              const SizedBox(height: 20), // Añadir algo de espacio después de los botones
            ],
          ),
        ),
      ),
    );
  }
}