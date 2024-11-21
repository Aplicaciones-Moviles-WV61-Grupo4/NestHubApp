import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nesthub/features/auth/remote/auth_service.dart';
import 'package:nesthub/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _documentNumberController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _termsAccepted = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final registrationData = {
      "username": _usernameController.text,
      "password": _passwordController.text,
      "name": _nameController.text,
      "fatherName": _fatherNameController.text,
      "motherName": _motherNameController.text,
      "dateOfBirth": _birthDateController.text,
      "documentNumber": _documentNumberController.text,
      "phone": _phoneController.text,
    };

    try {
      final authService = AuthService();
      await authService.signUp(registrationData);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrarse: $e')),
      );
    }
  }

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
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nombre',
                    hint: 'Nombre completo',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _fatherNameController,
                    label: 'Apellido paterno',
                    hint: 'Apellido paterno',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _motherNameController,
                    label: 'Apellido materno',
                    hint: 'Apellido materno',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Nombre de usuario',
                    hint: 'Ingresa un nombre de usuario',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Contraseña',
                    hint: 'Ingresa una contraseña',
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
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
                        hintText: 'Selecciona tu fecha de nacimiento',
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
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _birthDateController.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _documentNumberController,
                    label: 'Número de documento',
                    hint: 'Ingresa tu número de documento',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Teléfono',
                    hint: 'Ingresa tu número de teléfono',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
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
                      onPressed: _termsAccepted ? _register : null,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}
