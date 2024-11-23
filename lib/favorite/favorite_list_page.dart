import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesthub/favorite/favorite_cubit.dart';
import 'package:nesthub/favorite/favorite_dao.dart';
import 'package:nesthub/favorite/favorite_list_item.dart';
import 'package:nesthub/favorite/favorite_model.dart';
import 'package:nesthub/favorite/local_state.dart';

class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Favoritos')),
        body: BlocBuilder<FavoriteCubit, Tuple2<LocalState, FavoriteState>>(
          builder: (context, state) {
            return FutureBuilder<List<FavoriteModel>>(
              future: FavoriteDao().fetchAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar favoritos'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay favoritos aún.'));
                }

                final favorites = snapshot.data!;
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];
                    return FavoriteListItem(
                      favorite: favorite,
                      onDelete: () {
                        FavoriteDao().delete(favorite.userId);
                        BlocProvider.of<FavoriteCubit>(context)
                            .loadLocalData(favorite.toLocal());
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
