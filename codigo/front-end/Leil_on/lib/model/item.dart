import 'dart:io';

class Item {
  String nomeLeilao;
  List<File> imagens = [];
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
    //this.precoDeEncerramento,
    this.categoria1,
    this.categoria2,
    this.descricao,
  });
}
