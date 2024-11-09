import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nesthub/home_screen.dart'; // Asegúrate de importar correctamente tu HomeScreen

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Se asegura de que Flutter esté completamente inicializado antes de que el código se ejecute.
  await Firebase
      .initializeApp(); // Inicializa Firebase antes de que la app se ejecute
  runApp(
      const MainApp()); // Ejecuta la aplicación después de inicializar Firebase
}

class MainApp extends StatelessWidget {
  const MainApp({super.key}); // Constructor sin estado, que inicializa la app.

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // Desactiva la bandera de modo de depuración
      home: HomeScreen(), // Aquí se establece la pantalla de inicio
    );
  }
}
