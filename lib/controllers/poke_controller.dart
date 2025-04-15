import '../models/pokemon_model.dart';
import '../services/poke_service.dart';

class PokeController {
  final PokeService _pokeService = PokeService();

  List<PokemonModel> allPokemons = [];
  List<PokemonModel> filteredPokemons = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> loadPokemons({int limit = 20, int offset = 0}) async {
    try {
      isLoading = true;
      errorMessage = null;

      final result = await _pokeService.fetchPokemons(limit: limit, offset: offset);
      allPokemons = result;
      filteredPokemons = allPokemons; // inicia sem filtro
    } catch (e) {
      errorMessage = 'Erro ao carregar Pokémons: $e';
    } finally {
      isLoading = false;
    }
  }

  void filterByName(String query) {
    filteredPokemons = allPokemons.where((p) {
      return p.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void filterByType(String type) {
    if (type.isEmpty) {
      filteredPokemons = allPokemons;
    } else {
      filteredPokemons = allPokemons.where((p) {
        return p.types.contains(type.toLowerCase());
      }).toList();
    }
  }
}