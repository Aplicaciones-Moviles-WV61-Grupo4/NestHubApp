import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nesthub/core/app_constants.dart';

class AuthService {
  final String baseUrl = '${AppConstants.baseUrl}${AppConstants.loginEndpoint}';

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
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
