import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:hirocare/models/poliklinik.dart';

class PoliklinikService {
  final String _baseUrl = "https://65e1813da8583365b3169018.mockapi.io/rumahsakit/api/poliklinik";

  Future<List<Poliklinik>> fetchPoliklinik() async {
    final response = await http.get(Uri.parse(_baseUrl));
    try {
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Poliklinik.fromJson(e)).toList();
      } else {
        throw Exception(
            'Gagal untuk memproses data Poliklinik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }
}
