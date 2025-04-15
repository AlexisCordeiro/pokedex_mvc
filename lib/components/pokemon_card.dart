import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import '../ui/poke_colors.dart';
import '../views/detail_page.dart';

class PokemonCard extends StatefulWidget {
  final PokemonModel pokemon;

  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Pegando o tipo principal para gerar gradiente/cor
    final String mainType = widget.pokemon.types.isNotEmpty ? widget.pokemon.types.first : '';
    final cardGradient = PokeColors.cardGradient(mainType);

    return GestureDetector(
      onTap: () => _onTap(context),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Fundo gradiente, baseado no tipo do Pokémon
            Container(
              decoration: BoxDecoration(
                gradient: cardGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    offset: const Offset(2, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            // Conteúdo do card
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  // Nome do Pokémon (top left)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Text(
                      widget.pokemon.name.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // HP do Pokémon (top right)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Text(
                      "HP ${widget.pokemon.hp}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // Ícone de "favoritar" (top left, logo abaixo do nome)
                  Positioned(
                    top: 20,
                    left: 0,
                    child: IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.star : Icons.star_border,
                        color: _isFavorite ? Colors.yellow[700] : Colors.grey,
                      ),
                      onPressed: _toggleFavorite,
                      splashRadius: 20,
                    ),
                  ),
                  // Imagem do Pokémon (centralizada)
                  Positioned.fill(
                    child: Center(
                      child: Hero(
                        tag: widget.pokemon.name,
                        child: Image.network(
                          widget.pokemon.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error_outline, size: 60);
                          },
                        ),
                      ),
                    ),
                  ),
                  // Move e dano (abaixo, na parte de baixo do card)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Move
                        Row(
                          children: [
                            const Icon(Icons.flash_on, size: 16, color: Colors.orange),
                            const SizedBox(width: 6),
                            Text(
                              widget.pokemon.mainMoveName.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        // Dano
                        Text(
                          "${widget.pokemon.mainMovePower} DMG",
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => DetailPage(pokemon: widget.pokemon),
        transitionsBuilder: (_, animation, __, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }
}