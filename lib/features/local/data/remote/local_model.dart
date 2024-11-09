class LocalModel {
  final int id;
  final String streetAddress;
  final String cityPlace;
  final int nightPrice;
  final String photoUrl;
  final String title;
  final String descriptionMessage;
  final int localCategoryId;
  final String localCategoryName;

  LocalModel({
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

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
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
        'userId': 1 // Aquí asigna el ID del usuario correspondiente
      }
    };
  }
}
