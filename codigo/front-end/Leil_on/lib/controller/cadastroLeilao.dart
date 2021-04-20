import 'dart:convert';
import 'dart:io';

import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
//import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
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
      String dataTermino) {
    novoLeilao = new Leilao(
      nomeLeilao: nomeLeilao,
      nomeVendedor: nomeVendedor,
      emailVendedor: nomeEmail,
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

  Future<void> addLeilao() async {
    novoLeilao.itensCadastrados = itens;
    final urlCadastroLeilao = 'http://leil-on.herokuapp.com/addauction';
    final response = await http.post(
      urlCadastroLeilao,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode({
        'name': novoLeilao.nomeLeilao,
        'items': novoLeilao.itensCadastrados,
        'owner': novoLeilao.nomeVendedor,
        'owneremail': novoLeilao.emailVendedor,
        'endDate': novoLeilao.dataTermino,
        'description': novoLeilao.descricao,
      }),
    );

    var responseBody = json.decode(response.body);
    print(responseBody);
  }

  
}
