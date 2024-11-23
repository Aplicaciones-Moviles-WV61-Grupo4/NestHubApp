import 'package:flutter/material.dart';
import 'package:nesthub/accessibility_page.dart';
import 'package:nesthub/features/auth/presentation/login_screen.dart';
import 'package:nesthub/home_screen.dart';
import 'package:nesthub/message_screen.dart';
import 'package:nesthub/notificacion_screen.dart';
import 'package:nesthub/paymet_page.dart';
import 'package:nesthub/personal_information_page.dart';
import 'package:nesthub/steps_pages/publishing_page.dart';
import 'package:nesthub/widgets/custom_bottom_navigation_bar.dart';
import 'package:nesthub/features/auth/data/remote/auth_service.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _userName = 'Invitado';
  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  _loadUserName() async {
    final authService = AuthService();
    String name = await authService.getUserName();
    setState(() {
      _userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFEAEAEA),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.orange),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificacionScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, $_userName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Mostrar perfil'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PublishingPage()));
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Publica tu espacio aquí.\nPublicar un anuncio y empieza a tener ingresos, es muy sencillo.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Image.asset(
                        'assets/steps_icons/icon_profile.png',
                        width: 70,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuButton('assets/profile_icons/informacion_personal.png',
                  'Información personal', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersonalInformationPage(),
                  ),
                );
              }),
              _buildMenuButton(
                  'assets/profile_icons/pagos_cobros.png', 'Pagos y cobros',
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentsPage(),
                  ),
                );
              }),
              _buildMenuButton('assets/profile_icons/seguridad.png',
                  'Inicio de sesión y seguridad', () {}),
              _buildMenuButton(
                  'assets/profile_icons/accesibilidad.png', 'Accesibilidad',
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccessibilityPage(),
                  ),
                );
              }),
              _buildMenuButton(
                'assets/profile_icons/notificacion.png',
                'Notificaciones',
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificacionScreen()));
                },
              ),
              _buildMenuButton('assets/profile_icons/datos_personales.png',
                  'Configuración de datos personales', () {}),
              const SizedBox(height: 30),
              // Hospedar
              const Text(
                'Hospedar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuButton('assets/profile_icons/publica_estado.png',
                  'Publica tu espacio', () {}),
              _buildMenuButton(
                  'assets/profile_icons/guias.png', 'Tus guías', () {}),
              const SizedBox(height: 30),
              // Asistencia
              const Text(
                'Asistencia',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuButton('assets/profile_icons/como_funciona.png',
                  'Cómo funciona NestHub', () {}),
              _buildMenuButton('assets/profile_icons/problemas_seguridad.png',
                  'Problemas de seguridad', () {}),
              _buildMenuButton('assets/profile_icons/denunciar_problema.png',
                  'Denunciar problema', () {}),
              _buildMenuButton('assets/profile_icons/centro_ayuda.png',
                  'Centro de ayuda', () {}),
              _buildMenuButton('assets/profile_icons/comentarios.png',
                  'Envíanos tus comentarios', () {}),
              const SizedBox(height: 30),
              // Legal
              const Text(
                'Legal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuButton('assets/profile_icons/legal.png',
                  'Términos de servicio', () {}),
              _buildMenuButton('assets/profile_icons/legal.png',
                  'Política de privacidad', () {}),
              _buildMenuButton('assets/profile_icons/legal.png',
                  'Licencias de código abierto', () {}),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Cerrar sesión'),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text('Versión 1.0.1'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessageScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildMenuButton(
      String imagePath, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 24),
            const SizedBox(width: 16),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
