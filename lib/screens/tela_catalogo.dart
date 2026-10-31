import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/produto_card.dart';
import 'tela_cadastro_produto.dart';

class TelaCatalogo extends StatefulWidget {
  const TelaCatalogo({super.key});

  @override
  State<TelaCatalogo> createState() => _TelaCatalogoState();
}

class _TelaCatalogoState extends State<TelaCatalogo> {
  final List<Produto> _produtos = [
    const Produto(
      nome: 'Fone Bluetooth Premium',
      preco: 189.90,
      categoria: Categoria.eletronicos,
    ),
    const Produto(
      nome: 'Cafeteira Italiana',
      preco: 129.00,
      categoria: Categoria.casa,
    ),
    const Produto(
      nome: 'Camiseta Básica',
      preco: 59.90,
      categoria: Categoria.roupas,
    ),
    const Produto(
      nome: 'Whey Protein 1kg',
      preco: 149.90,
      categoria: Categoria.alimentos,
    ),
    const Produto(
      nome: 'Bola de Futsal',
      preco: 79.90,
      categoria: Categoria.esportes,
    ),
    const Produto(
      nome: 'Clean Code',
      preco: 89.90,
      categoria: Categoria.livros,
    ),
  ];

  Future<void> _cadastrarProduto() async {
    final produto = await Navigator.of(context).push<Produto>(
      MaterialPageRoute(builder: (_) => const TelaCadastroProduto()),
    );

    if (produto != null && mounted) {
      setState(() => _produtos.add(produto));
      // Confirmação visual ao adicionar produto
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '"${produto.nome}" adicionado ao catálogo!',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF26A69A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }

  void _adicionarAoCarrinho(Produto produto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.shopping_cart_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '"${produto.nome}" foi adicionado ao carrinho.',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF536DFE),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          action: SnackBarAction(
            label: 'Ver carrinho',
            textColor: Colors.white70,
            onPressed: () {},
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FF),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Catálogo',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'Encontre seu próximo favorito',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey.shade400,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF536DFE).withValues(alpha: 0.12),
              radius: 20,
              child: const Icon(
                Icons.person_rounded,
                color: Color(0xFF536DFE),
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner de destaque
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF536DFE), Color(0xFF7C4DFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF536DFE).withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.storefront_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Produtos para você',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_produtos.length} ${_produtos.length == 1 ? 'produto disponível' : 'produtos disponíveis'}',
                          style: const TextStyle(
                            color: Color(0xFFCDD2FF),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.local_offer_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Título da seção
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              'Todos os produtos',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ),

          // Lista de produtos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];
                return ProdutoCard(
                  produto: produto,
                  onTap: () => _adicionarAoCarrinho(produto),
                  onComprar: () => _adicionarAoCarrinho(produto),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _cadastrarProduto,
        backgroundColor: const Color(0xFF536DFE),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Novo produto',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
