import 'dart:convert';

import 'dart:typed_data';

import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Listagem with ChangeNotifier {
  List<Item> itensPesquisados = [];
  List<Leilao> leiloesPesquisados = [];
  List<String> itensDoLeilaoPesquisado = [];

  Future<void> retornarPesquisa(String pesquisa, String tipoPesquisa) async {
    final urlSearch = 'http://leil-on.herokuapp.com/search';
    List<Uint8List> _image = [];
    final response = await http.post(urlSearch,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode({'type': tipoPesquisa, 'obj': pesquisa}));

    Map<String, dynamic> data = jsonDecode(response.body);

    itensPesquisados.clear();
    leiloesPesquisados.clear();
    data.forEach((chave, valor) => {
          if (chave == 'item')
            {
              (valor as List<dynamic>).forEach((item) => {
                    (item['imagens'] as List<dynamic>).forEach(
                      (imagem) => {
                        _image.add(Base64Decoder().convert(imagem.toString())),
                      },
                    ),
                    itensPesquisados.add(
                      new Item(
                        nomeLeilao: item['linkedAuction'].toString(),
                        nomeProduto: item['name'].toString(),
                        precoMinimo: double.parse(item['price'].toString()),
                        descricao: item['description'].toString(),
                        imagens1: _image,
                      ),
                    ),
                  }),
            }
          else if (chave == 'leilão')
            {
              itensDoLeilaoPesquisado.clear(),
              (valor as List<dynamic>).forEach((leilao) => {
                    (leilao['items'] as List<dynamic>).forEach((item) => {
                          itensDoLeilaoPesquisado.add(item['name'].toString()),
                        }),
                    leiloesPesquisados.add(new Leilao(
                      nomeLeilao: leilao['name'],
                      nomeVendedor: leilao['owner'],
                      dataTermino: leilao['endDate'],
                      descricao: leilao['description'],
                      itensAnunciados: itensDoLeilaoPesquisado,
                    )),
                  })
            }
        });
    notifyListeners();
  }
}
