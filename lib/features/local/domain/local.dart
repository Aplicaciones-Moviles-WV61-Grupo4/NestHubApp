class Local {
  final int id;
  final String district;
  final String street;
  final String title;
  final String city;
  final int price;
  final String photoUrl;
  final String descriptionMessage;
  final int localCategoryId;
  final int userId;
  final bool isFavorite;

  Local({
    this.id = 0,
    required this.district,
    required this.street,
    required this.title,
    required this.city,
    required this.price,
    required this.photoUrl,
    required this.descriptionMessage,
    required this.localCategoryId,
    required this.userId,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'district': district,
      'street': street,
      'title': title,
      'city': city,
      'price': price,
      'photoUrl': photoUrl,
      'descriptionMessage': descriptionMessage,
      'localCategoryId': localCategoryId,
      'userId': userId,
    };
  }
}
