class User {
  final String username;
  final String password;
  final String name;
  final String fatherName;
  final String motherName;
  final DateTime dateOfBirth;
  final String documentNumber;
  final String phone;

  User({
    required this.username,
    required this.password,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.dateOfBirth,
    required this.documentNumber,
    required this.phone,
  });

  Map<String, String> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'fatherName': fatherName,
      'motherName': motherName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'documentNumber': documentNumber,
      'phone': phone,
    };
  }
}
