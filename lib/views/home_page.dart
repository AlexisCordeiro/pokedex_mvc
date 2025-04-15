import 'package:flutter/material.dart';
import '../controllers/poke_controller.dart';
import '../components/pokemon_card.dart';
import '../models/pokemon_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokeController _controller = PokeController();
  final TextEditingController _searchController = TextEditingController();
  String selectedType = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _controller.loadPokemons(limit: 50); 
    setState(() {});
  }

  void _onSearchChanged(String text) {
    setState(() {
      _controller.filterByName(text);
    });
  }

  void _onTypeSelected(String type) {
    setState(() {
      selectedType = type;
      _controller.filterByType(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_controller.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Pokémon TCG-like")),
        body: Center(
          child: Text(_controller.errorMessage!),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Cartas"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                labelText: "Pesquisar por nome",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: selectedType.isEmpty ? null : selectedType,
              hint: const Text("Filtrar por tipo:"),
              items: const [
                DropdownMenuItem(value: "", child: Text("Todos")),
                DropdownMenuItem(value: "grass", child: Text("Planta")),
                DropdownMenuItem(value: "fire", child: Text("Fogo")),
                DropdownMenuItem(value: "water", child: Text("Água")),
                DropdownMenuItem(value: "bug", child: Text("Inseto")),
                DropdownMenuItem(value: "poison", child: Text("Venenoso")),
              ],
              onChanged: (val) {
                if (val != null) {
                  _onTypeSelected(val);
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _controller.filteredPokemons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final PokemonModel pokemon = _controller.filteredPokemons[index];
                return PokemonCard(pokemon: pokemon);
              },
            ),
          ),
        ],
      ),
    );
  }
}