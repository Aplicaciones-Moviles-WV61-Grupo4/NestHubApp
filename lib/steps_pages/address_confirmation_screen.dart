import 'package:flutter/material.dart';
import 'package:nesthub/steps_pages/step_2_page.dart';

class AddressConfirmationScreen extends StatelessWidget {
  final String street;
  final int localCategoryId;

  const AddressConfirmationScreen({
    super.key,
    required this.street,
    required this.localCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _districtController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final TextEditingController _streetController =
        TextEditingController(text: street);

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
                      _buildTextField('Dirección', _streetController),
                      _buildTextField('Distrito', _districtController),
                      _buildTextField('Código postal',
                          TextEditingController(text: 'LIMA 09')),
                      _buildTextField('Departamento/estado/provincia/región',
                          _cityController),
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
                          vertical: 8, horizontal: 24),
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

  Widget _buildTextField(String label, TextEditingController controller) {
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
