import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Mensajes',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF01698C), // Color de "Todos"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text(
                      'Todos',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFD9D9D9), // Color de "Asistencia"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text(
                      'Asistencia',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/profile_icons/message.png', // Ruta de la imagen local
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: const Text(
                      'Ana, casa Urbana',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        const Text('La casa sí cuenta con mesa de pingpong'),
                    trailing: const Text('25/08',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
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
    );
  }
}
