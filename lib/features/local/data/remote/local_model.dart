class LocalModel {
  final int id;
  final String streetAddress;
  final String localType;
  final String cityPlace;
  final int nightPrice;
  final String photoUrl;
  final String descriptionMessage;
  final int localCategoryId; // Agregar este campo

  LocalModel({
    required this.id,
    required this.streetAddress,
    required this.localType,
    required this.cityPlace,
    required this.nightPrice,
    required this.photoUrl,
    required this.descriptionMessage,
    required this.localCategoryId, // Incluir en el constructor
  });

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
      id: json['local']['id'] ?? 0,
      streetAddress: json['local']['streetAddress'] ?? '',
      cityPlace: json['local']['cityPlace'] ?? '',
      localType: json['local']['localType'] ?? '',
      nightPrice: json['local']['nightPrice'] ?? 0,
      photoUrl: json['local']['photoUrl'] ?? '',
      descriptionMessage: json['local']['descriptionMessage'] ?? '',
      localCategoryId: json['local']['localCategory']['id'] ??
          0, // Obtener el ID de la categoría
    );
  }
}
