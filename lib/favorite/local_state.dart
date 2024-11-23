class LocalState {
  final String district;
  final String street;
  final String title;
  final String city;
  final int price;
  final String photoUrl;
  final String descriptionMessage;
  final int localCategoryId;
  final int userId;

  LocalState({
    required this.district,
    required this.street,
    required this.title,
    required this.city,
    required this.price,
    required this.photoUrl,
    required this.descriptionMessage,
    required this.localCategoryId,
    required this.userId,
  });
}

class FavoriteState {
  final bool isFavorite;

  FavoriteState({required this.isFavorite});
}
