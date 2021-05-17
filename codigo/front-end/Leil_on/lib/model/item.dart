import 'dart:ffi';
import 'dart:io';

import 'dart:typed_data';

class Item {
  String nomeLeilao;
  List<File> imagens = [];
  List<Uint8List> imagens1 = [];
  String nomeProduto;
  double precoMinimo;
  //double precoDeEncerramento;
  String categoria1;
  String categoria2;
  String descricao;

  Item({
    this.nomeLeilao,
    this.imagens,
    this.nomeProduto,
    this.precoMinimo,
    this.imagens1,
    //this.precoDeEncerramento,
    this.categoria1,
    this.categoria2,
    this.descricao,
  });
}
