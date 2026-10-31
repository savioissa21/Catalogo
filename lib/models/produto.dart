import 'package:flutter/material.dart';

enum Categoria {
  eletronicos('Eletrônicos', Icons.devices_rounded, Color(0xFF536DFE)),
  roupas('Roupas', Icons.checkroom_rounded, Color(0xFFE879A9)),
  casa('Casa', Icons.chair_alt_rounded, Color(0xFF26A69A)),
  alimentos('Alimentos', Icons.restaurant_rounded, Color(0xFFFF9F43)),
  esportes('Esportes', Icons.sports_soccer_rounded, Color(0xFF42A5F5)),
  livros('Livros', Icons.menu_book_rounded, Color(0xFF66BB6A)),
  outros('Outros', Icons.category_rounded, Color(0xFF8C6EE8));

  const Categoria(this.nome, this.icone, this.cor);

  final String nome;
  final IconData icone;
  final Color cor;
}

class Produto {
  const Produto({
    required this.nome,
    required this.preco,
    required this.categoria,
  });

  final String nome;
  final double preco;
  final Categoria categoria;
}
