import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesthub/favorite/favorite_dao.dart';
import 'package:nesthub/favorite/favorite_model.dart';
import 'package:nesthub/features/local/domain/local.dart';

class FavoriteCubit extends Cubit<Local> {
  FavoriteCubit(super.local) {
    FavoriteDao().isFavorite(state.userId).then((value) {
      emit(Local(
        district: state.district,
        street: state.street,
        title: state.title,
        city: state.city,
        price: state.price,
        photoUrl: state.photoUrl,
        descriptionMessage: state.descriptionMessage,
        localCategoryId: state.localCategoryId,
        userId: state.userId,
        //reviews: state.reviews,
        isFavorite: value,
      ));
    });
  }

  void toggleFavorite() {
    bool isFavorite = !state.isFavorite;
    if (isFavorite) {
      FavoriteDao().insert(FavoriteModel(
        userId: state.userId,
        district: state.district,
        street: state.street,
        title: state.title,
        city: state.city,
        price: state.price,
        photoUrl: state.photoUrl,
        descriptionMessage: state.descriptionMessage,
        localCategoryId: state.localCategoryId,
      ));
    } else {
      FavoriteDao().delete(state.userId);
    }
    emit(
      Local(
        district: state.district,
        street: state.street,
        title: state.title,
        city: state.city,
        price: state.price,
        photoUrl: state.photoUrl,
        descriptionMessage: state.descriptionMessage,
        localCategoryId: state.localCategoryId,
        userId: state.userId,
        //reviews: state.reviews,
        isFavorite: isFavorite,
      ),
    );
  }
}
