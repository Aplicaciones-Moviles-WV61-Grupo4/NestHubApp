import 'package:nesthub/features/local/domain/local.dart';

class FavoriteModel {
  final int id; // Nuevo campo
  final int userId;
  final String district;
  final String street;
  final String title;
  final String city;
  final int price;
  final String photoUrl;
  final String descriptionMessage;
  final int localCategoryId;

  FavoriteModel({
    this.id = 0, // Valor por defecto 0 para indicar que aún no tiene id
    required this.userId,
    required this.district,
    required this.street,
    required this.title,
    required this.city,
    required this.price,
    required this.photoUrl,
    required this.descriptionMessage,
    required this.localCategoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Incluyendo el campo id
      'userId': userId,
      'district': district,
      'street': street,
      'title': title,
      'city': city,
      'price': price,
      'photoUrl': photoUrl,
      'descriptionMessage': descriptionMessage,
      'localCategoryId': localCategoryId,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] ?? 0, // Asignamos el id desde la base de datos
      userId: map['userId'] ?? 0,
      district: map['district'] ?? '',
      street: map['street'] ?? '',
      title: map['title'] ?? '',
      city: map['city'] ?? '',
      price: map['price'] ?? 0,
      photoUrl: map['photoUrl'] ?? '',
      descriptionMessage: map['descriptionMessage'] ?? '',
      localCategoryId: map['localCategoryId'] ?? 0,
    );
  }

  Local toLocal() {
    return Local(
      userId: userId,
      district: district,
      street: street,
      title: title,
      city: city,
      price: price,
      photoUrl: photoUrl,
      descriptionMessage: descriptionMessage,
      localCategoryId: localCategoryId,
      isFavorite: false,
    );
  }
}
