import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nesthub/title_description_screen.dart';

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
  List<File> _images = [];

  final String defaultPhotoUrl =
      'https://a0.muscache.com/im/pictures/e1e59d29-9c6a-4f81-9a73-7b805470ad84.jpg?im_w=720';

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  Future<String> _uploadImageToImgur(File image) async {
    final uri = Uri.parse('https://api.imgur.com/3/image');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    request.headers['Authorization'] = 'Client-ID 01a0548502c0baf';

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseData);
      return jsonResponse['data']['link'];
    } else {
      print('Error al subir la imagen');
      return '';
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
                    _pickImage(ImageSource.gallery);
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
                    _pickImage(ImageSource.camera);
                  },
                ),
              ),
              const SizedBox(height: 24),
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
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF7BA884)),
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
                    onPressed: () async {
                      if (_images.isNotEmpty) {
                        String imageUrl = await _uploadImageToImgur(_images[0]);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TitleDescriptionScreen(
                              photoUrl:
                                  imageUrl.isEmpty ? defaultPhotoUrl : imageUrl,
                              district: widget.district,
                              city: widget.city,
                              street: widget.street,
                              localCategoryId: widget.localCategoryId,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TitleDescriptionScreen(
                              photoUrl: defaultPhotoUrl,
                              district: widget.district,
                              city: widget.city,
                              street: widget.street,
                              localCategoryId: widget.localCategoryId,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7BA884),
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

  Widget _buildPhotoButton(BuildContext context,
      {required String imagePath,
      required String label,
      required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFF7BA884),
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
