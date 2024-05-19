import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final characterProvider = FutureProvider<List<Character>>((ref) async {
  return CharacterApiProvider.fetchCharacters();
});

class Character {
  final String id;
  final String name;
  final String imageUrl;

  Character({required this.id, required this.name, required this.imageUrl});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}

class CharacterApiProvider {
  static Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('https://yourapi.com/character'));

    if (response.statusCode == 200) {
      List<dynamic> characterJson = json.decode(response.body);
      return characterJson.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
