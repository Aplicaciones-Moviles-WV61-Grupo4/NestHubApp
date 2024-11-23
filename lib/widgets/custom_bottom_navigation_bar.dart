import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[200],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
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
      onTap: onTap,
    );
  }
}
