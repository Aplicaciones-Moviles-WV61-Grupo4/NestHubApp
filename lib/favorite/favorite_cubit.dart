import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesthub/favorite/favorite_dao.dart';
import 'package:nesthub/favorite/favorite_model.dart';
import 'package:nesthub/favorite/local_state.dart';

class FavoriteCubit extends Cubit<Tuple2<LocalState, FavoriteState>> {
  FavoriteCubit()
      : super(
          Tuple2(
            LocalState(
              district: '',
              street: '',
              title: '',
              city: '',
              price: 0,
              photoUrl: '',
              descriptionMessage: '',
              localCategoryId: 0,
              userId: 0,
            ),
            FavoriteState(isFavorite: false),
          ),
        );

  void loadFavoriteData(FavoriteModel favorite) async {
    bool isFavorite = await FavoriteDao().isFavorite(favorite.userId);
    emit(
      Tuple2(
        LocalState(
          district: favorite.district,
          street: favorite.street,
          title: favorite.title,
          city: favorite.city,
          price: favorite.price,
          photoUrl: favorite.photoUrl,
          descriptionMessage: favorite.descriptionMessage,
          localCategoryId: favorite.localCategoryId,
          userId: favorite.userId,
        ),
        FavoriteState(isFavorite: isFavorite),
      ),
    );
  }

  void toggleFavorite() async {
    bool newFavoriteStatus = !state.value2.isFavorite;
    if (newFavoriteStatus) {
      await FavoriteDao().insert(FavoriteModel(
        userId: state.value1.userId,
        district: state.value1.district,
        street: state.value1.street,
        title: state.value1.title,
        city: state.value1.city,
        price: state.value1.price,
        photoUrl: state.value1.photoUrl,
        descriptionMessage: state.value1.descriptionMessage,
        localCategoryId: state.value1.localCategoryId,
      ));
    } else {
      await FavoriteDao().delete(state.value1.userId);
    }
    emit(
      Tuple2(
        state.value1,
        FavoriteState(isFavorite: newFavoriteStatus),
      ),
    );
  }
}
