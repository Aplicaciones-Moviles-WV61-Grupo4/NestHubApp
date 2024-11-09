import 'dart:convert';
import 'dart:io';

import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/local/data/remote/local_data.dart';
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

  Future<void> pushLocal(LocalData local) async {
    final url = Uri.parse(AppConstants.baseUrl);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(local.toJson()),
    );

    if (response.statusCode == 201) {
      print('Local añadido correctamente');
    } else {
      print('Error al añadir local: ${response.statusCode} ${response.body}');
      throw Exception('Error al añadir local: ${response.reasonPhrase}');
    }
  }
}
