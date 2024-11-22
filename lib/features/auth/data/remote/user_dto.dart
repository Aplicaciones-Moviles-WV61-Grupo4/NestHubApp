class UserDto {
  final int id;
  final String username;
  final String token;

  UserDto({required this.id, required this.username, required this.token});

  factory UserDto.fromMap(Map<String, dynamic> data) => UserDto(
        id: data['id'] ?? 0,
        username: data['username'] ?? '',
        token: data['token'] ?? '',
      );
}
