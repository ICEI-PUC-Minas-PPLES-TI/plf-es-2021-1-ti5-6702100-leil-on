import 'package:Leil_on/model/item.dart';

class Leilao {
  String nomeLeilao;
  String nomeVendedor;
  String emailVendedor;
  String descricao;
  String dataTermino;
  List<Item> itensCadastrados = [];
  //
  //
  Leilao({
    this.nomeLeilao,
    this.nomeVendedor,
    this.descricao,
    this.dataTermino,
  });
}

/*
{
    this.nomeLeilao,
    this.nomeVendedor,
    this.descricao,
    this.dataTermino,
    this.itensCadastrados,
  }
  */
