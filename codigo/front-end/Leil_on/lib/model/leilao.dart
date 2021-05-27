import 'package:Leil_on/model/item.dart';

class Leilao {
  String nomeLeilao;
  String nomeVendedor;
  String emailVendedor;
  String descricao;
  String dataTermino;
  List<Item> itensCadastrados = [];
  List<String> itensAnunciados = [];
  String time;

  Leilao({
    this.nomeLeilao,
    this.nomeVendedor,
    this.emailVendedor,
    this.descricao,
    this.dataTermino,
    this.time,
    this.itensAnunciados,
  });
}
