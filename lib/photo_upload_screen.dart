import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart'; // Importa Firebase Storage
import 'package:nesthub/title_description_screen.dart'; // Importa la pantalla siguiente

class PhotoUploadScreen extends StatefulWidget {
  final String district;
  final String city;
  final String street;
  final int localCategoryId;

  const PhotoUploadScreen({
    super.key,
    required this.district,
    required this.city,
    required this.street,
    required this.localCategoryId,
  });

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = []; // Lista para guardar las imágenes seleccionadas
  String _imageUrl = ''; // Variable para almacenar la URL de Firebase Storage

  // Asignación de imagen por defecto
  final String defaultPhotoUrl =
      'https://a0.muscache.com/im/pictures/e1e59d29-9c6a-4f81-9a73-7b805470ad84.jpg?im_w=720';

  // Método para seleccionar una imagen desde la galería o la cámara
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: source); // Abrimos la cámara o galería

    if (pickedFile != null) {
      setState(() {
        _images.add(File(
            pickedFile.path)); // Añadimos la imagen seleccionada a la lista
      });

      // Subir la imagen a Firebase Storage
      await _uploadImage(File(pickedFile.path));
    }
  }

  // Subir imagen a Firebase Storage
  Future<void> _uploadImage(File imageFile) async {
    try {
      // Crear una referencia única para la imagen en Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName.jpg');

      // Subir la imagen a Firebase Storage
      UploadTask uploadTask = storageRef.putFile(imageFile);

      // Esperar que la subida se complete
      await uploadTask;

      // Obtener la URL de descarga de la imagen subida
      String downloadUrl = await storageRef.getDownloadURL();

      print('Imagen subida con éxito! URL: $downloadUrl');

      // Aquí puedes usar el downloadUrl para hacer lo que necesites
      setState(() {
        // Almacena la URL de descarga de la imagen
        _imageUrl = downloadUrl; // Guarda la URL de Firebase
      });
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Agrega algunas fotos de tu espacio',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Para empezar, necesitarás cuatro fotos. Después podrás agregar más o hacer cambios.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: _buildPhotoButton(
                  context,
                  imagePath: 'assets/photo_upload_icons/agregar_fotos.png',
                  label: 'Agrega fotos',
                  onPressed: () {
                    _pickImage(ImageSource.gallery); // Llamamos a la galería
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: _buildPhotoButton(
                  context,
                  imagePath: 'assets/photo_upload_icons/foto_nueva.png',
                  label: 'Toma fotos nuevas',
                  onPressed: () {
                    _pickImage(ImageSource.camera); // Llamamos a la cámara
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Mostramos las imágenes seleccionadas en un GridView
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Image.file(_images[index], fit: BoxFit.cover);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Regresar a la página anterior
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF018648)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Atrás'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Enviar la URL de la imagen y otros datos a la siguiente pantalla
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TitleDescriptionScreen(
                            photoUrl: _images.isEmpty
                                ? defaultPhotoUrl
                                : _imageUrl, // Usamos la URL de Firebase Storage
                            district: widget.district,
                            city: widget.city,
                            street: widget.street,
                            localCategoryId: widget.localCategoryId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF018648),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Siguiente'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método auxiliar para crear los botones de agregar fotos
  Widget _buildPhotoButton(BuildContext context,
      {required String imagePath,
      required String label,
      required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFF018648),
          width: 1,
        ),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(double.infinity, 70),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
