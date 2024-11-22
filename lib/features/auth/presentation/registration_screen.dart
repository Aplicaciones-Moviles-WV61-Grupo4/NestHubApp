import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nesthub/features/auth/data/repository/auth_repository.dart';
import 'package:nesthub/features/auth/domain/user.dart';
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
  bool _isPasswordVisible = false;

  final AuthRepository _authRepository = AuthRepository();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final user = User(
      username: _usernameController.text,
      password: _passwordController.text,
      name: _nameController.text,
      fatherName: _fatherNameController.text,
      motherName: _motherNameController.text,
      dateOfBirth: DateTime.parse(_birthDateController.text),
      documentNumber: _documentNumberController.text,
      phone: _phoneController.text,
    );

    try {
      await _authRepository.register(user.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.pushReplacement(
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Nombre',
                  hint: 'Nombre completo',
                  validator: (value) =>
                      value!.isEmpty ? 'El nombre es obligatorio' : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _fatherNameController,
                  label: 'Apellido paterno',
                  hint: 'Apellido paterno',
                  validator: (value) => value!.isEmpty
                      ? 'El apellido paterno es obligatorio'
                      : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _motherNameController,
                  label: 'Apellido materno',
                  hint: 'Apellido materno',
                  validator: (value) => value!.isEmpty
                      ? 'El apellido materno es obligatorio'
                      : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _usernameController,
                  label: 'Nombre de usuario',
                  hint: 'Ingresa un nombre de usuario',
                  validator: (value) => value!.isEmpty
                      ? 'El nombre de usuario es obligatorio'
                      : null,
                ),
                const SizedBox(height: 16),
                _buildPasswordField(),
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
                    validator: (value) => value!.isEmpty
                        ? 'La fecha de nacimiento es obligatoria'
                        : null,
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
                  validator: (value) => value!.isEmpty
                      ? 'El número de documento es obligatorio'
                      : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Teléfono',
                  hint: 'Ingresa tu número de teléfono',
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? 'El teléfono es obligatorio' : null,
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contraseña',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Ingresa una contraseña',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) => value!.length < 6
              ? 'La contraseña debe tener al menos 6 caracteres'
              : null,
        ),
      ],
    );
  }
}
