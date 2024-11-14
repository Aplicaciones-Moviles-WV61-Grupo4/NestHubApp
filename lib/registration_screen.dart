import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nesthub/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Registrarse'),
        ),
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre completo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText:
                                'Nombre que aparece en su documento de identidad',
                            labelStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight
                                    .w200), // Tamaño más pequeño para labelText
                            hintText:
                                'Nombre que aparece en su documento de identidad',
                            hintStyle: TextStyle(
                                fontSize:
                                    15), // Tamaño más grande para hintText
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                          style: const TextStyle(fontSize: 15),
                        ),
                        const Divider(height: 1, thickness: 1),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText:
                                'Apellidos que aparece en su documento de identidad',
                            labelStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w200),
                            hintText:
                                'Apellidos que aparece en su documento de identidad',
                            hintStyle: TextStyle(fontSize: 15),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Fecha de nacimiento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: _birthDateController,
                      decoration: const InputDecoration(
                        hintText: 'Fecha de nacimiento',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('d MMM. yyyy').format(pickedDate);
                          setState(() {
                            _birthDateController.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Para registrarte, debes tener al menos 18 años. No se estará compartiendo la fecha de nacimiento con otros usuarios.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Correo electrónico',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Correo electrónico',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      style: const TextStyle(fontSize: 15),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Se te enviará las confirmaciones/información de viaje y los recibos por correo electrónico.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox(
                        value: _termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _termsAccepted = value!;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'Al seleccionar "Aceptar y continuar", confirmo que estoy de acuerdo con los Términos de Servicio, los Términos de pago del servicio y la Política de privacidad.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _termsAccepted
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF01698C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Aceptar y continuar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationButton({
    required String asset,
    required String text,
    required Color color,
    required Color borderColor,
  }) {
    return SizedBox(
      width: 290,
      height: 35,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {
          // Handle social login or registration
        },
        child: Row(
          children: [
            Image.asset(
              asset,
              width: 20,
              height: 18,
            ),
            const SizedBox(width: 20),
            Text(text),
          ],
        ),
      ),
    );
  }
}
