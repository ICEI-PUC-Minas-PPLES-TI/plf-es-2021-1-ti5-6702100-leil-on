import 'dart:convert';

import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
//import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart' as dio;

class CadastroLeilao with ChangeNotifier {
  Leilao novoLeilao = new Leilao();
  List<Item> itens = [];
  String nomeUsuario;
  String nomeEmail;
  CadastroLeilao(this.nomeUsuario, this.nomeEmail);

  void regInfoDoLeilao(String nomeLeilao, String nomeVendedor, String descricao,
      String dataTermino, DateTime data) {
    String diferenca = data.difference(DateTime.now()).inHours.toString();
    novoLeilao = new Leilao(
      nomeLeilao: nomeLeilao,
      nomeVendedor: nomeVendedor,
      emailVendedor: nomeEmail,
      descricao: descricao,
      dataTermino: dataTermino,
      time: diferenca,
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

// cadastro do leilao
  Future<void> addLeilao() async {
    novoLeilao.itensCadastrados = itens;
    final urlCadastroLeilao = 'http://leil-on.herokuapp.com/addauction';
    print('diferenca em horas : ' + novoLeilao.time);
    final response = await http.post(
      urlCadastroLeilao,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode({
        'time': novoLeilao.time,
        'name': novoLeilao.nomeLeilao,
        'items': novoLeilao.itensCadastrados
            .map((item) => {
                  'name': item.nomeProduto,
                })
            .toList(),
        'owner': novoLeilao.nomeVendedor,
        'owneremail': novoLeilao.emailVendedor,
        'endDate': novoLeilao.dataTermino,
        'description': novoLeilao.descricao,
      }),
    );

    var responseBody = json.decode(response.body);

    print(responseBody);
  }

// cadastro dos itens cadastrando apenas uma imagem

  Future<void> cadastrarItem(Item item) async {
    // List<int> imageBytes = item.imagens[0].readAsBytesSync().toList();
    // String base64Image = base64Encode(imageBytes);
    //final urlCadastrarItem =
    //base64Encode(imagem.readAsBytesSync().toList())
    //    'https://teste-b8c97-default-rtdb.firebaseio.com/additem.json';
    final urlCadastrarItem = 'http://leil-on.herokuapp.com/additem';
    final response = await http.post(
      urlCadastrarItem,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: json.encode(
        {
          'name': item.nomeProduto,
          'price': item.precoMinimo,
          'itemOwner': novoLeilao.nomeVendedor,
          //'imagens': 'SW1hZ2VtIDE=',
          'imagens': [
            base64Encode(item.imagens[0].readAsBytesSync().toList()),
            base64Encode(item.imagens[1].readAsBytesSync().toList()),
            base64Encode(item.imagens[2].readAsBytesSync().toList()),
            base64Encode(item.imagens[3].readAsBytesSync().toList()),
          ],
          /*item.imagens
              .map((imagem) =>
                  {'image': base64Encode(imagem.readAsBytesSync().toList())})
              .toList(),*/
          'description': item.descricao,
          'linkedAuction': item.nomeLeilao,
          'categories': [item.categoria1, item.categoria2].toList(),
        },
      ),
    );

    if (response.statusCode == 200) print('ok deu certo');

    print('oiii');

    var responseBody = json.decode(response.body);
    print('oiii');
    //print('resposta  : ' + responseBody);
    print('oiii');
  }

  void addItens() {
    itens.forEach((item) => {cadastrarItem(item)});
  }
}
