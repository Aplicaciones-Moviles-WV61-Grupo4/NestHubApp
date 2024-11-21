import 'package:flutter/material.dart';
import 'package:nesthub/favorite/favorite_dao.dart';
import 'package:nesthub/favorite/favorite_list_item.dart';
import 'package:nesthub/favorite/favorite_model.dart';

class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({Key? key}) : super(key: key);

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  List<FavoriteModel> _favorites = [];

  Future<void> _loadData() async {
    List<FavoriteModel> favorites = await FavoriteDao().fetchAll();
    setState(() {
      _favorites = favorites;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) => FavoriteListItem(
          favorite: _favorites[index],
          onDelete: () {
            FavoriteDao().delete(_favorites[index].userId);
            _loadData();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Eliminado de favoritos'),
              ),
            );
          },
        ),
      ),
    );
  }
}