import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:flutter/cupertino.dart';

class CadastroLeilao with ChangeNotifier {
  Leilao novoLeilao = new Leilao();
  List<Item> itens = [];

  void regInfoDoLeilao(String nomeLeilao, String nomeVendedor, String descricao,
      String dataTermino) {
    novoLeilao = new Leilao(
      nomeLeilao: nomeLeilao,
      nomeVendedor: nomeVendedor,
      descricao: descricao,
      dataTermino: dataTermino,
    );
    notifyListeners();
  }

  void addItem(Item novoItem) {
    itens.add(novoItem);
    notifyListeners();
  }

  void deleteItem(Item item) {
    itens.remove(item);
    notifyListeners();
  }

  void atualizarItem(int indice, Item atualizado) {
    itens[indice] = atualizado;
    notifyListeners();
  }
}
