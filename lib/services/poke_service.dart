import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokeService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<PokemonModel>> fetchPokemons({int limit = 40, int offset = 0}) async {
    final url = Uri.parse('$baseUrl?limit=$limit&offset=$offset');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List results = data['results'] ?? [];
      List<PokemonModel> pokemonList = [];

      for (var item in results) {
        final detailUrl = item['url'];
        final detailResponse = await http.get(Uri.parse(detailUrl));

        if (detailResponse.statusCode == 200) {
          final detailData = jsonDecode(detailResponse.body);
          final pokemon = PokemonModel.fromJson(detailData);
          pokemonList.add(pokemon);
        }
      }

      return pokemonList;
    } else {
      throw Exception('Falha ao buscar Pokémons');
    }
  }
}