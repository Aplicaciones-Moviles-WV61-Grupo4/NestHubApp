import 'dart:convert';
import 'dart:io';

import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/local/domain/local.dart';
import 'package:nesthub/features/local/data/remote/local_dto.dart';
import 'package:http/http.dart' as http;

class LocalService {
  Future<List<LocalDto>> getLocals() async {
    /*final response = await http
        .get(Uri.parse(AppConstants.baseUrl + AppConstants.localsEndpoint));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((model) => LocalDto.fromJson(model)).toList();
    } else {
      throw Exception('Error al cargar locales');
    }*/
    String url = '${AppConstants.baseUrl}${AppConstants.localsEndpoint}';
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((model) => LocalDto.fromJson(model)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> pushLocal(Local local) async {
    final url = Uri.parse(AppConstants.baseUrl + AppConstants.localsEndpoint);
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
