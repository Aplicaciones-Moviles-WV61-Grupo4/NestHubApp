import 'package:flutter/material.dart';
import 'package:nesthub/user_profile_screen.dart';

class NotificacionScreen extends StatefulWidget {
  const NotificacionScreen({super.key});

  @override
  _NotificacionScreenState createState() => _NotificacionScreenState();
}

class _NotificacionScreenState extends State<NotificacionScreen> {
  bool _isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                color: const Color(0xFFEAEAEA),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/profile_icons/logo_nesthub.png',
                      height: 90,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '¿Quieres activar las notificaciones?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No te pierdas información importante como los detalles del proceso de llegada o la actividad de tu cuenta.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Obtén ofertas de espacios, recomendaciones personalizadas y mucho más',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Switch(
                            value: _isSwitched,
                            onChanged: (bool value) {
                              setState(() {
                                _isSwitched = value;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfileScreen())
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB44101),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sí, quiero recibir notificaciones',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfileScreen())
                            );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFB44101),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Omitir',
                          style: TextStyle(color: Color(0xFFB44101)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
