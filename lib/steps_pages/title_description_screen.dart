import 'package:flutter/material.dart';
import 'package:nesthub/steps_pages/step_3_page.dart';

class TitleDescriptionScreen extends StatefulWidget {
  final String district;
  final String city;
  final String street;
  final int localCategoryId;
  final String photoUrl;

  const TitleDescriptionScreen({
    super.key,
    required this.district,
    required this.city,
    required this.street,
    required this.localCategoryId,
    required this.photoUrl,
  });

  @override
  State<TitleDescriptionScreen> createState() => _TitleDescriptionScreenState();
}

class _TitleDescriptionScreenState extends State<TitleDescriptionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ponle título a tu espacio',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Los títulos cortos funcionan mejor. No te preocupes, puedes modificarlo más adelante.',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Escribe tu descripción',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Comparte lo que hace que tu espacio sea especial.',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Regresar a la pantalla anterior
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF7BA884)),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Atrás'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Obtén el título y la descripción ingresados
                        String title = _titleController.text;
                        String description = _descriptionController.text;

                        // Navegar a la siguiente pantalla (Step3Page)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Step3Page(
                              district: widget.district,
                              city: widget.city,
                              street: widget.street,
                              localCategoryId: widget.localCategoryId,
                              photoUrl: widget.photoUrl,
                              title: title, // Pasa el título
                              description: description, // Pasa la descripción
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7BA884),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 8),
                      ),
                      child: const Text('Siguiente'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
