import 'package:flutter/material.dart';
import '../models/produto.dart';

class TelaCadastroProduto extends StatefulWidget {
  const TelaCadastroProduto({super.key});

  @override
  State<TelaCadastroProduto> createState() => _TelaCadastroProdutoState();
}

class _TelaCadastroProdutoState extends State<TelaCadastroProduto> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  Categoria? _categoriaSelecionada;

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _salvarProduto() {
    if (!_formKey.currentState!.validate()) return;

    final preco = double.parse(
      _precoController.text.trim().replaceAll(',', '.'),
    );

    Navigator.of(context).pop(
      Produto(
        nome: _nomeController.text.trim(),
        preco: preco,
        categoria: _categoriaSelecionada!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FF),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 4,
        title: const Text(
          'Cadastrar Produto',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.3),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Cabeçalho informativo
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF536DFE).withValues(alpha: 0.1),
                      const Color(0xFF7C4DFF).withValues(alpha: 0.06),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF536DFE).withValues(alpha: 0.15),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Color(0xFF536DFE),
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Preencha os dados abaixo para adicionar um novo produto ao catálogo.',
                        style: TextStyle(
                          height: 1.45,
                          color: Color(0xFF3D5AFE),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Campo: Nome
              _buildLabel('Nome do produto', Icons.label_rounded),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.sentences,
                decoration: _inputDecoration(
                  hint: 'Ex.: Fone Bluetooth',
                  prefixIcon: Icons.label_outline_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do produto.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22),

              // Campo: Preço
              _buildLabel('Preço', Icons.payments_rounded),
              const SizedBox(height: 8),
              TextFormField(
                controller: _precoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _inputDecoration(
                  hint: '0,00',
                  prefixText: 'R\$ ',
                  prefixIcon: Icons.payments_outlined,
                ),
                validator: (value) {
                  final preco = double.tryParse(
                    (value ?? '').trim().replaceAll(',', '.'),
                  );
                  if (preco == null || !preco.isFinite || preco <= 0) {
                    return 'Informe um preço válido maior que zero.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22),

              // Campo: Categoria
              _buildLabel('Categoria', Icons.category_rounded),
              const SizedBox(height: 8),
              DropdownButtonFormField<Categoria>(
                value: _categoriaSelecionada,
                decoration: _inputDecoration(
                  hint: '',
                  prefixIcon: Icons.category_outlined,
                ),
                hint: const Text('Selecione uma categoria'),
                isExpanded: true,
                items: Categoria.values.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Row(
                      children: [
                        Icon(categoria.icone, color: categoria.cor, size: 20),
                        const SizedBox(width: 10),
                        Text(categoria.nome),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (categoria) {
                  setState(() => _categoriaSelecionada = categoria);
                },
                validator: (categoria) =>
                    categoria == null ? 'Selecione uma categoria.' : null,
              ),

              // Preview da categoria selecionada
              if (_categoriaSelecionada != null) ...[
                const SizedBox(height: 14),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _categoriaSelecionada!.cor.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _categoriaSelecionada!.cor.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _categoriaSelecionada!.icone,
                        color: _categoriaSelecionada!.cor,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Ícone: ${_categoriaSelecionada!.nome}',
                        style: TextStyle(
                          color: _categoriaSelecionada!.cor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 36),

              // Botão de confirmação
              FilledButton.icon(
                onPressed: _salvarProduto,
                icon: const Icon(Icons.check_rounded),
                label: const Text(
                  'Adicionar produto',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF536DFE),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF536DFE)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
    String? prefixText,
  }) {
    return InputDecoration(
      hintText: hint.isEmpty ? null : hint,
      prefixText: prefixText,
      prefixIcon: Icon(prefixIcon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFDDE1F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFDDE1F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide:
            const BorderSide(color: Color(0xFF536DFE), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
