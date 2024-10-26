import 'package:flutter/material.dart';
import 'package:nesthub/home_screen.dart';
import 'package:nesthub/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            // Centrar el contenido
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centrar verticalmente
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Iniciar sesión o registrarse',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Iniciar sesión',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Ingresar su correo',
                          labelStyle: const TextStyle(color: Colors.black),
                          hintText: 'correo electrónico',
                          hintStyle: TextStyle(color: Colors.grey[200]),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(height: 1, color: Colors.black),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Ingresar su contraseña',
                          labelStyle: const TextStyle(color: Colors.black),
                          hintText: 'contraseña',
                          hintStyle: TextStyle(color: Colors.grey[200]),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: InputBorder.none,
                        ),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: const Text(
                      'Continuar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Otras formas de inicio de sesión',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 15),
                _buildSocialButton(
                  asset: 'assets/login_icons/icon_mail.png',
                  text: 'Continuar con correo',
                  color: Colors.grey[200]!,
                  borderColor: Colors.black,
                ),
                const SizedBox(height: 15),
                _buildSocialButton(
                  asset: 'assets/login_icons/icon_google.png',
                  text: 'Continuar con Google',
                  color: Colors.grey[200]!,
                  borderColor: Colors.black,
                ),
                const SizedBox(height: 15),
                _buildSocialButton(
                  asset: 'assets/login_icons/icon_facebook.png',
                  text: 'Continuar con Facebo1ok',
                  color: Colors.grey[200]!,
                  borderColor: Colors.black,
                ),
                const SizedBox(height: 15),
                _buildSocialButton(
                  asset: 'assets/login_icons/icon_person_add.png',
                  text: 'Registrarse',
                  color: Colors.grey[200]!,
                  borderColor: Colors.black,
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
    );
  }

  Widget _buildSocialButton({
    required String asset,
    required String text,
    required Color color,
    required Color borderColor,
    void Function()? onPressed, // Agregar callback onPressed
  }) {
    return SizedBox(
      width: 290,
      height: 50, // Aumentar la altura del botón
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed ??
            () {
              // Handle social login or registration
            },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Alinear al inicio
          children: [
            Image.asset(
              asset,
              width: 24, // Aumentar el tamaño del ícono
              height: 24, // Aumentar el tamaño del ícono
            ),
            const SizedBox(width: 15), // Espacio entre ícono y texto
            Text(text,
                style: const TextStyle(
                    fontSize: 16, color: Colors.black)), // Texto negro
          ],
        ),
      ),
    );
  }
}
