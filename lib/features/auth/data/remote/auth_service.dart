import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/auth/data/remote/user_dto.dart';
import 'package:nesthub/features/auth/data/remote/user_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = '${AppConstants.baseUrl}${AppConstants.loginEndpoint}';

  Future<UserDto> signIn(UserRequest userRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userRequest.toJson()),
    );

    if (response.statusCode == 200) {
      UserDto userDto = UserDto.fromMap(json.decode(response.body));

      await _saveSession(userDto.token, userDto.id.toString());
      await _saveUserName(userDto.username);

      return userDto;
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
      String message = json.decode(response.body)['message'];

      if (json.decode(response.body)['username'] != null) {
        String userName = json.decode(response.body)['username'];
        await _saveUserName(userName);
      }

      return message;
    } else {
      throw Exception('Error al registrarse: ${response.reasonPhrase}');
    }
  }

  Future<void> _saveSession(String token, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', id);
  }

  Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', name);
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('user_name');
    return name ?? 'Invitado';
  }
}
