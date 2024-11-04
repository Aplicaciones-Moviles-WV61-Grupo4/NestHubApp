import 'dart:convert';
import 'dart:io';

import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/profile/data/remote/profile_model.dart';
import 'package:http/http.dart' as http;

class LocalService {
  Future<List<ProfileModel>> getProfiles() async {
    final response = await http.get(Uri.parse(AppConstants.baseUrl+AppConstants.profilesEndpoint));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((model) => ProfileModel.fromJson(model)).toList();
    } else {
      throw Exception('Error al cargar perfiles');
    }
  }
}
