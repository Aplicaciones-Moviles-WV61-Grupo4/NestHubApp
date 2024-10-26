import 'package:flutter/material.dart';
import 'package:nesthub/step_1_page.dart'; // Asegúrate de que la ruta sea correcta

class AddressConfirmationScreen extends StatelessWidget {
  const AddressConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Confirma tu dirección',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTextField('Dirección', 'calle'),
                      _buildTextField(
                          'Departamento, piso, etc (si corresponde)',
                          'departamento'),
                      _buildTextField('Distrito', 'Chorrillos'),
                      _buildTextField('Código postal', 'LIMA 09'),
                      _buildTextField('Departamento/estado/provincia/región',
                          'Provincia de Lima'),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Acción para ir atrás
                      Navigator.pop(context);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Step1Page(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE7A436), // Cambiado aquí
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

  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        controller: TextEditingController(text: initialValue),
      ),
    );
  }
}
