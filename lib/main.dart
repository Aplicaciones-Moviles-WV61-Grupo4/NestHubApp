import 'package:flutter/material.dart';
import 'package:nesthub/property_display_screen.dart';
//import 'package:nesthub/login_screen.dart';
//import 'package:nesthub/registration_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PropertyDisplayScreen(),
      //LoginScreen()
      //RegistrationScreen(),
    );
  }
}
