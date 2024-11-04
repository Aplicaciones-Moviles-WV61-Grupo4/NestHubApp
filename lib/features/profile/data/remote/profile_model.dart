class ProfileModel {
  final int id;
  final String fullName;
  final String phone;
  final String documentNumber;
  final String dateOfBirth;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.documentNumber,
    required this.dateOfBirth,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['profile']['id'] ?? 0,
      fullName: json['profile']['fullName'] ?? '',
      phone: json['profile']['phone'] ?? '',
      documentNumber: json['profile']['documentNumber'] ?? '',
      dateOfBirth: json['profile']['dateOfBirth'] ?? '',
    );
  }
}
