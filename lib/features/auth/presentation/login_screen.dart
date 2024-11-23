import 'package:flutter/material.dart';
import 'package:nesthub/features/auth/data/remote/auth_service.dart';
import 'package:nesthub/features/auth/data/remote/user_request.dart';
import 'package:nesthub/home_screen.dart';
import 'package:nesthub/features/auth/presentation/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final userRequest = UserRequest(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final userDto = await _authService.signIn(userRequest);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Bienvenido, ${userDto.username}!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Iniciar sesión o registrarse',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Iniciar sesión',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Ingresar su nombre de usuario',
                              labelStyle: const TextStyle(color: Colors.black),
                              hintText: 'nombre de usuario',
                              hintStyle: TextStyle(color: Colors.grey[200]),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su nombre de usuario';
                              }
                              return null; // No hay errores
                            },
                          ),
                          const Divider(height: 1, color: Colors.black),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Ingresar su contraseña',
                              labelStyle: const TextStyle(color: Colors.black),
                              hintText: 'contraseña',
                              hintStyle: TextStyle(color: Colors.grey[200]),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su contraseña';
                              }
                              return null; // No hay errores
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _signIn,
                        child: const Text(
                          'Continuar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Otras formas de inicio de sesión',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    _buildSocialButton(
                      asset: 'assets/login_icons/icon_mail.png',
                      text: 'Continuar con correo',
                      color: Colors.grey[200]!,
                      borderColor: Colors.black,
                      screenWidth: screenWidth,
                    ),
                    const SizedBox(height: 15),
                    _buildSocialButton(
                      asset: 'assets/login_icons/icon_google.png',
                      text: 'Continuar con Google',
                      color: Colors.grey[200]!,
                      borderColor: Colors.black,
                      screenWidth: screenWidth,
                    ),
                    const SizedBox(height: 15),
                    _buildSocialButton(
                      asset: 'assets/login_icons/icon_facebook.png',
                      text: 'Continuar con Facebook',
                      color: Colors.grey[200]!,
                      borderColor: Colors.black,
                      screenWidth: screenWidth,
                    ),
                    const SizedBox(height: 15),
                    _buildSocialButton(
                      asset: 'assets/login_icons/icon_person_add.png',
                      text: 'Registrarse',
                      color: Colors.grey[200]!,
                      borderColor: Colors.black,
                      screenWidth: screenWidth,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String asset,
    required String text,
    required Color color,
    required Color borderColor,
    required double screenWidth,
    void Function()? onPressed,
  }) {
    return SizedBox(
      width:
          screenWidth * 0.8, // Ajuste el ancho al 80% del ancho de la pantalla
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              asset,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
