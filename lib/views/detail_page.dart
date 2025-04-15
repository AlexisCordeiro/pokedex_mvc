import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import '../ui/poke_colors.dart';

class DetailPage extends StatelessWidget {
  final PokemonModel pokemon;
  const DetailPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainType = pokemon.types.isNotEmpty ? pokemon.types.first : '';
    final bgColor = PokeColors.fromType(mainType).withOpacity(0.15);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: PokeColors.fromType(mainType),
        title: Text(pokemon.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                Hero(
                  tag: pokemon.name,
                  child: Image.network(
                    pokemon.imageUrl,
                    height: 300, 
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error_outline, size: 150);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "HP ${pokemon.hp}",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      "Tipo(s): ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...pokemon.types.map(
                      (type) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: PokeColors.fromType(type),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          type.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
               
                _buildInfoTable(),
                const SizedBox(height: 16),
  
                _buildMoveSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Inf. da Carta",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1.5),
          },
          children: [
            TableRow(
              children: [
                _cell("Nível"),
                _cell("1"), 
              ],
            ),
            TableRow(
              children: [
                _cell("Fraqueza"),
                _cell("+20 Fogo"), 
              ],
            ),
            TableRow(
              children: [
                _cell("Recuo"),
                _cell("2"),
              ],
            ),
            TableRow(
              children: [
                _cell("Series"),
                _cell("A"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMoveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Movimento",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              children: [
                const Icon(Icons.flash_on, size: 18, color: Colors.orange),
                const SizedBox(width: 6),
                Text(
                  pokemon.mainMoveName.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(
              "${pokemon.mainMovePower} dmg",
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        const Text(
          "Descrição: (Fictício)",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _cell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}