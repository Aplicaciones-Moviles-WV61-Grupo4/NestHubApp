import 'package:flutter/material.dart';
import 'package:nesthub/favorite/favorite_model.dart';

class FavoriteListItem extends StatelessWidget {
  const FavoriteListItem(
      {Key? key, required this.favorite, required this.onDelete})
      : super(key: key);
  final FavoriteModel favorite;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            favorite.photoUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          favorite.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10, // Tamaño de fuente reducido
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              favorite.descriptionMessage,
              maxLines: 2,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9, // Tamaño de fuente reducido
              ),
            ),
            Text(
              'S/. ${favorite.price} /noche',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 7, // Tamaño de fuente reducido
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
