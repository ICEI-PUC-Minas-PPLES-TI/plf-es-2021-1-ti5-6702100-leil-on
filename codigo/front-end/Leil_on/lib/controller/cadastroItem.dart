import 'dart:io';

import 'package:Leil_on/model/item.dart';
import 'package:flutter/cupertino.dart';

class CadastroItem with ChangeNotifier {
  List<File> imagens = [];
  String primeiraCategoria;
  String segundaCategoria;
  Item novoItem;
  void adicionarFoto(File imagem) {
    imagens.add(imagem);
    notifyListeners();
  }

  void removerFoto(File imagem) {}

  void adicionarCategorias(String categoria1, String categoria2) {
    primeiraCategoria = categoria1;
    segundaCategoria = categoria2;
  }

  void adicionarInformacoesDoItem(String nomeLeilao, String nomeProduto,
      double precoMinimo, String descricaoProduto) {
    novoItem = new Item(
      nomeLeilao: nomeLeilao,
      imagens: imagens,
      nomeProduto: nomeProduto,
      precoMinimo: precoMinimo,
      categoria1: primeiraCategoria,
      categoria2: segundaCategoria,
      descricao: descricaoProduto,
    );
    imagens.removeRange(0, 2);
    notifyListeners();
  }
}
