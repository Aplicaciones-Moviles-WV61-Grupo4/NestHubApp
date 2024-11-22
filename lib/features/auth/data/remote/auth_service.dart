import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/auth/data/remote/user_dto.dart';
import 'package:nesthub/features/auth/data/remote/user_request.dart';

class AuthService {
  final String baseUrl = '${AppConstants.baseUrl}${AppConstants.loginEndpoint}';

  Future<UserDto> signIn(UserRequest userRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return UserDto.fromMap(json.decode(response.body));
    } else {
      throw Exception('Error al iniciar sesión: ${response.reasonPhrase}');
    }
  }

  Future<String> signUp(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sign-up'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Error al registrarse: ${response.reasonPhrase}');
    }
  }
}
