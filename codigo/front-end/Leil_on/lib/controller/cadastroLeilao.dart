import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:flutter/cupertino.dart';

class CadastroLeilao with ChangeNotifier {
  Leilao novoLeilao = new Leilao();
  String teste = 'sucrilhos';
  List<Item> itens = [];

  void regInfoDoLeilao(String nomeLeilao, String nomeVendedor, String descricao,
      String dataTermino) {
    teste = 'ola';
    novoLeilao = new Leilao(
      nomeLeilao: nomeLeilao,
      nomeVendedor: nomeVendedor,
      descricao: descricao,
      dataTermino: dataTermino,
    );
    // print('o tamanho da lista eh de : '+novoLeilao.)
    notifyListeners();
  }

/*
  Leilao retornaLeilao() {
    // print('acessando internamente');
   
    return novoLeilao;
  }
*/
  void addItem(Item novoItem) {
    itens.add(novoItem);
    /*print('1');
    print(novoItem.nomeProduto);
    print('122222222');
    print('nomeProduto :' +
        novoItem.nomeProduto +
        'preco do produto' +
        novoItem.precoMinimo.toString());
    print('nomeDoLeilao : ' + novoItem.nomeLeilao);*/
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
