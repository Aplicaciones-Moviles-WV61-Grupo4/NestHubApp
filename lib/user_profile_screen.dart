import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEAEAEA),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              onPressed: () {},
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
                        const Text(
                          'Cesar Salas',
                          style: TextStyle(
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
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Publica tu espacio aquí\nPublicar un anuncio y empieza a tener ingresos, es muy sencillo.',
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
                const SizedBox(height: 30),
                const Text(
                  'Configuración',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildMenuButton(
                    'assets/profile_icons/informacion_personal.png',
                    'Información personal',
                    () {}),
                _buildMenuButton('assets/profile_icons/pagos_cobros.png',
                    'Pagos y cobros', () {}),
                _buildMenuButton('assets/profile_icons/seguridad.png',
                    'Inicio de sesión y seguridad', () {}),
                _buildMenuButton('assets/profile_icons/accesibilidad.png',
                    'Accesibilidad', () {}),
                _buildMenuButton('assets/profile_icons/notificacion.png',
                    'Notificaciones', () {}),
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
                  onPressed: () {},
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/profile_icons/explora.png'),
                width: 24,
                height: 24,
              ),
              label: 'Explora',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/profile_icons/favoritos.png'),
                width: 24,
                height: 24,
              ),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/profile_icons/mensajes.png'),
                width: 24,
                height: 24,
              ),
              label: 'Mensajes',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/profile_icons/profile.png'),
                width: 24,
                height: 24,
              ),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(dynamic icon, String title, VoidCallback onPressed) {
    return ListTile(
      leading: icon is IconData
          ? Icon(icon)
          : icon is String
              ? Image.asset(
                  icon,
                  width: 24,
                  height: 24,
                )
              : null,
      title: Text(title),
      onTap: onPressed,
    );
  }
}