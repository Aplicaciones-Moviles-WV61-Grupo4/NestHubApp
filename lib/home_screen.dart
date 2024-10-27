import 'package:flutter/material.dart';
import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/local/data/remote/local_model.dart';
import 'package:nesthub/features/local/data/remote/local_service.dart';
import 'package:nesthub/message_screen.dart';
import 'package:nesthub/user_profile_screen.dart';
import 'package:nesthub/widgets/custom_bottom_navigation_bar.dart';
import 'package:nesthub/property_display_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LocalModel> _models = [];
  List<LocalModel> _filteredModels = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> _loadData() async {
    try {
      print(
          'Cargando datos desde: ${AppConstants.baseUrl}${AppConstants.localsEndpoint}');
      List<LocalModel> models = await LocalService().getLocals();
      setState(() {
        _models = models;
        _filteredModels = models;
      });
    } catch (e) {
      print('Error al cargar datos: $e');
    }
  }

  void _filterModels(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredModels = _models;
      });
    } else {
      setState(() {
        _filteredModels = _models.where((model) {
          return model.streetAddress
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(() {
      _filterModels(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
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
              child: ListView.builder(
                itemCount: _filteredModels.length,
                itemBuilder: (context, index) {
                  final model = _filteredModels[index];
                  return _buildPropertyListing(
                    model,
                    context,
                  );
                },
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

  Widget _buildPropertyListing(LocalModel model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDisplayScreen(localModel: model),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(model.photoUrl,
                height: 200, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.streetAddress,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(model.descriptionMessage),
                  Text('S/. ${model.nightPrice} /noche',
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
