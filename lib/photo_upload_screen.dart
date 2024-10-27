import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:nesthub/title_description_screen.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      await _openGallery();
    } else {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _images.add(File(pickedFile.path));
        });
      }
    }
  }

    Future<void> _openGallery() async {
    final permitted = await PhotoManager.requestPermissionExtend();
    if (!permitted.isAuth) return;

    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(onlyAll: true);
    if (albums.isEmpty) return;

    final List<AssetEntity> assets = await albums[0].getAssetListPaged(page: 0, size: 80);
    final List<File?> files = await Future.wait(assets.map((asset) => asset.file));

    setState(() {
      _images.addAll(files.whereType<File>());
    });
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
                'Para empezar, necesitarás cuatro fotos. Después podrás agregar más o hacer cambios',
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
                  onPressed: () { _pickImage(ImageSource.gallery); },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: _buildPhotoButton(
                  context,
                  imagePath: 'assets/photo_upload_icons/foto_nueva.png',
                  label: 'Toma fotos nuevas',
                  onPressed: () { _pickImage(ImageSource.camera); },
                ),
              ),
              const Spacer(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TitleDescriptionScreen()),
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
