import 'package:flutter/material.dart';
import 'package:nesthub/steps_pages/step_2_page.dart';

class AddressConfirmationScreen extends StatelessWidget {
  final String street; // Añade el campo para la calle
  final int localCategoryId; // Añade el campo para el localCategoryId

  const AddressConfirmationScreen({
    super.key,
    required this.street,
    required this.localCategoryId, // Asegúrate de requerirlo en el constructor
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _districtController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final TextEditingController _streetController = TextEditingController();

    _streetController.text = street;

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
                      _buildTextField('Dirección', street, _streetController),
                      _buildTextField(
                          'Distrito', 'Chorrillos', _districtController),
                      _buildTextField('Código postal', 'LIMA 09',
                          TextEditingController()), // Campo sin efecto en API
                      _buildTextField('Departamento/estado/provincia/región',
                          'Provincia de Lima', _cityController),
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
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE4AC44)),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical:8, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Atrás'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Step2Page(
                            district: _districtController.text,
                            city: _cityController.text,
                            street: _streetController.text,
                            localCategoryId: localCategoryId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE7A436),
                      foregroundColor: Colors.grey[200],
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

  Widget _buildTextField(
      String label, String initialValue, TextEditingController controller) {
    controller.text = initialValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
