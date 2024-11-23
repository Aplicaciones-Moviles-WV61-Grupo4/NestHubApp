import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<String> favoriteItems;

  const FavoritePage({super.key, required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteItems[index]),
          );
        },
      ),
    );
  }
}