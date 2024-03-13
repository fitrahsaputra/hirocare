import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:hirocare/models/character.dart';

class CharacterService {
  final String _baseUrl = "https://rickandmortyapi.com/api/character/";

  Future<List<Character>> fetchCharacters({String? search}) async {
    // Jika ada searchTerm, tambahkan query parameter untuk melakukan pencarian
    String url = _baseUrl;
    if (search != null && search.isNotEmpty) {
      url += '?name=$search';
    }

    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];
        final List<Character> characters = results.map((characterJson) {
          final originJson = characterJson['origin'];
          final locationJson = characterJson['location'];
          final origin = CharacterLocation.fromJson(originJson);
          final location = CharacterLocation.fromJson(locationJson);
          final character = Character.fromJson(characterJson);
          character.origin = origin;
          character.location = location;
          return character;
        }).toList();
        return characters;
      } else {
        throw Exception(
            'Gagal untuk memproses data Character: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }
}
