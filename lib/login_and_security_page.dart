import 'package:flutter/material.dart';

class LoginAndSecurityPage extends StatefulWidget {
  const LoginAndSecurityPage({Key? key}) : super(key: key);

  @override
  _LoginAndSecurityPageState createState() => _LoginAndSecurityPageState();
}

class _LoginAndSecurityPageState extends State<LoginAndSecurityPage> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Inicio de sesión y seguridad',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Inicio de sesión',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (!_isEditing) ...[
                _buildPasswordInfo(),
              ] else ...[
                _buildPasswordForm(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordInfo() {
    return ListTile(
      title: const Text('Contraseña', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: const Text('Última actualización -', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
      trailing: TextButton(
        child: const Text('Modificar', style: TextStyle(color: Color(0xFF719C7A))),
        onPressed: () {
          setState(() {
            _isEditing = true;
          });
        },
      ),
    );
  }

  Widget _buildPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _currentPasswordController,
            decoration: const InputDecoration(
              labelText: 'Contraseña actual',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su contraseña actual';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _newPasswordController,
            decoration: const InputDecoration(
              labelText: 'Nueva contraseña',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una nueva contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirma la contraseña',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor confirme su nueva contraseña';
              }
              if (value != _newPasswordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('Cancelar', style: TextStyle(color: Colors.black87),),
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Actualiza la contraseña',
                  style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF719C7A),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement password update logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Contraseña actualizada')),
                    );
                    setState(() {
                      _isEditing = false;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}