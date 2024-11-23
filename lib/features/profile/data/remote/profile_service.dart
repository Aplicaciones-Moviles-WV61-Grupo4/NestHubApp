import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nesthub/core/app_constants.dart';

class ProfileService {
  Future<String> getFullName(String userId) async {
    final response = await http.get(
      Uri.parse(
          '${AppConstants.baseUrl}${AppConstants.profilesEndpoint}/$userId'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['fullName'];
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
