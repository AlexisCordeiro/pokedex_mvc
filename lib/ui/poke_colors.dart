import 'package:flutter/material.dart';

class PokeColors {
  static const Color grass = Color(0xFF78C850);
  static const Color fire = Color(0xFFF08030);
  static const Color water = Color(0xFF6890F0);
  static const Color bug = Color(0xFFA8B820);
  static const Color poison = Color(0xFFA040A0);
  static const Color normal = Color(0xFFA8A878);
  static const Color electric = Color(0xFFF8D030);

  static Color fromType(String type) {
    switch (type.toLowerCase()) {
      case 'grass':
        return grass;
      case 'fire':
        return fire;
      case 'water':
        return water;
      case 'bug':
        return bug;
      case 'poison':
        return poison;
      case 'electric':
        return electric;
      default:
        return Colors.grey;
    }
  }

  
  static LinearGradient cardGradient(String type) {
    Color base = fromType(type);
    return LinearGradient(
      colors: [
        base.withOpacity(0.2),
        Colors.white,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}