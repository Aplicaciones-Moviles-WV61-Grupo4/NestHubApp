import 'package:nesthub/features/local/domain/local.dart';

class LocalDto {
  final int id;
  final String streetAddress;
  final String cityPlace;
  final int nightPrice;
  final String photoUrl;
  final String title;
  final String descriptionMessage;
  final int localCategoryId;
  final String localCategoryName;

  LocalDto({
    required this.id,
    required this.streetAddress,
    required this.cityPlace,
    required this.nightPrice,
    required this.photoUrl,
    required this.title,
    required this.descriptionMessage,
    required this.localCategoryId,
    required this.localCategoryName,
  });

  factory LocalDto.fromJson(Map<String, dynamic> json) {
    return LocalDto(
      id: json['local']['id'] ?? 0,
      streetAddress: json['local']['streetAddress'] ?? '',
      cityPlace: json['local']['cityPlace'] ?? '',
      nightPrice: json['local']['nightPrice'] ?? 0,
      photoUrl: json['local']['photoUrl'] ?? '',
      title: json['local']['title'] ?? '',
      descriptionMessage: json['local']['descriptionMessage'] ?? '',
      localCategoryId: json['local']['localCategory']['id'] ?? 0,
      localCategoryName: json['local']['localCategory']['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'local': {
        'streetAddress': streetAddress,
        'cityPlace': cityPlace,
        'nightPrice': nightPrice,
        'photoUrl': photoUrl,
        'title': title,
        'descriptionMessage': descriptionMessage,
        'localCategory': {
          'id': localCategoryId,
          'name': localCategoryName,
        },
        'userId': 1
      }
    };
  }

  Local toLocal() {
    return Local(
        id: id,
        district: '',
        street: streetAddress,
        title: title,
        city: cityPlace,
        price: nightPrice,
        photoUrl: photoUrl,
        descriptionMessage: descriptionMessage,
        localCategoryId: localCategoryId,
        userId: 1,
        isFavorite: false);
  }
}
