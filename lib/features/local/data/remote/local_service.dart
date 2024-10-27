import 'dart:convert';
import 'dart:io';

import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/local/data/remote/local_model.dart';
import 'package:http/http.dart' as http;

class LocalService {
  Future<List<LocalModel>> getLocals() async {
    final response = await http.get(Uri.parse(AppConstants.baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((model) => LocalModel.fromJson(model)).toList();
    } else {
      throw Exception('Error al cargar locales');
    }
  }
}
