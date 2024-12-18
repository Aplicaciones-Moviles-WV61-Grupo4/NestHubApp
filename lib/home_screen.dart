import 'package:flutter/material.dart';
import 'package:nesthub/favorite/presentation/favorite_list_page.dart';
import 'package:nesthub/features/local/data/remote/local_service.dart';
import 'package:nesthub/features/local/data/repository/local_repository.dart';
import 'package:nesthub/features/local/domain/local.dart';
import 'package:nesthub/message_screen.dart';
import 'package:nesthub/user_profile_screen.dart';
import 'package:nesthub/widgets/custom_bottom_navigation_bar.dart';
import 'package:nesthub/local_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Local> _locals = [];
  List<Local> _filteredModels = [];

  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryId = 0;

  Future<void> _loadData() async {
    List<Local> locals =
        await LocalRepository(localService: LocalService()).getLocals();
    setState(() {
      _locals = locals;
      _filteredModels = locals;
    });
  }

  void _filterModels(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredModels = _locals.where((model) {
          return _selectedCategoryId == 0 ||
              model.localCategoryId == _selectedCategoryId;
        }).toList();
      } else {
        _filteredModels = _locals.where((model) {
          return (model.title.toLowerCase().contains(query.toLowerCase()) &&
              (_selectedCategoryId == 0 ||
                  model.localCategoryId == _selectedCategoryId));
        }).toList();
      }
    });
  }

  void _filterByCategory(int categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _filteredModels = _locals.where((model) {
        return categoryId == 0 || model.localCategoryId == _selectedCategoryId;
      }).toList();
    });
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
                          hintText: 'Buscar...',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPropertyTypeButton(
                        'assets/home_images/image_destacado.png', context,
                        categoryId: 0),
                    _buildPropertyTypeButton(
                        'assets/home_images/image_salon_elegante.png', context,
                        categoryId: 3),
                    _buildPropertyTypeButton(
                        'assets/home_images/image_casa_playa.png', context,
                        categoryId: 1),
                    _buildPropertyTypeButton(
                        'assets/home_images/image_casa_urbana.png', context,
                        categoryId: 2),
                    _buildPropertyTypeButton(
                        'assets/home_images/image_casa_campo.png', context,
                        categoryId: 4),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredModels.length,
                itemBuilder: (context, index) {
                  final model = _filteredModels[index];
                  return _buildPropertyListing(model, context);
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteListPage()),
              );
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

  Widget _buildPropertyTypeButton(String imageUrl, BuildContext context,
      {required int categoryId}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              _filterByCategory(categoryId);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(height: 2),
                // Elimina el texto de los botones, solo mostrar el icono
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyListing(Local model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocalDetailScreen(localModel: model),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              model.photoUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    model.descriptionMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text('S/. ${model.price} /noche',
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
