import 'package:flutter/material.dart';
import 'package:nesthub/message_screen.dart';
import 'package:nesthub/user_profile_screen.dart';
import 'package:nesthub/widgets/custom_bottom_navigation_bar.dart';
import 'package:nesthub/property_display_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Lima',
                          suffixText: '15 sept.',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Property type buttons with images
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPropertyTypeButton(
                    'Destacados',
                    'assets/home_images/image_destacado.png',
                    context,
                  ),
                  _buildPropertyTypeButton(
                    'Salones',
                    'assets/home_images/image_salon_elegante.png',
                    context,
                  ),
                  _buildPropertyTypeButton(
                    'Casa de playa',
                    'assets/home_images/image_casa_playa.png',
                    context,
                  ),
                  _buildPropertyTypeButton(
                    'Casas urbanas',
                    'assets/home_images/image_casa_urbana.png',
                    context,
                  ),
                  _buildPropertyTypeButton(
                    'Casas de campo',
                    'assets/home_images/image_casa_campo.png',
                    context,
                  ),
                ],
              ),
            ),
            // Property listings
            Expanded(
              child: ListView(
                children: [
                  _buildPropertyListing(
                    'Loft en Barranco',
                    'Departamento Estreno en Barranco',
                    'S/. 254 /noche',
                    'assets/home_images/barranco.png',
                    context,
                  ),
                  _buildPropertyListing(
                    'Magdalena del Mar, Lima',
                    'Salón elegante',
                    'S/. 89 /hora',
                    'assets/home_images/magdalena.png',
                    context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
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

  Widget _buildPropertyTypeButton(
      String label, String imageUrl, BuildContext context) {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
          ),
          onPressed: () {},
          child: Column(
            children: [
              Image.asset(imageUrl, width: 50, height: 50),
              const SizedBox(height: 4),
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyListing(String title, String subtitle, String price,
      String imageUrl, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PropertyDisplayScreen(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageUrl,
                height: 200, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle),
                  Text(price,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
