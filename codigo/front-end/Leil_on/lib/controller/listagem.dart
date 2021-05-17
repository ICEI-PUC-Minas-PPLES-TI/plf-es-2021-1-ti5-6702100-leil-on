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
    // print('esse print deu certo : ' + response.body);
    Map<String, dynamic> data = jsonDecode(response.body);

    itensPesquisados.clear();
    leiloesPesquisados.clear();
    data.forEach((chave, valor) => {
          if (chave == 'item')
            {
              (valor as List<dynamic>).forEach((item) => {
                    //               print('descricao do produto : ' +
                    //                 item['description'].toString()),
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
                    //           print(' dono do leilao : ' + leilao['owner']),
                    (leilao['items'] as List<dynamic>).forEach((item) => {
                          /*print(
                              'item do leilao eh : ' + item['name'].toString()),*/
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

/*
    data.forEach((chave, item) => {
          print('imprimindo o valor ' +
              item.toString() +
              ' imprimindo a chave : ' +
              chave.toString()),
          if (chave.toString() == 'item')
            {
              print('entrou aqui'),
              (item as List<dynamic>).map((info) => {
                    print('teste : asdadsa : ' + info.toString()),
                  }),
            }
          //print('')
        });

    //final responseBody = json.decode(response.body);
    /*print('ou foi esse print que deu certo, vamos descobrir' +
        responseBody['item']);

    itensPesquisados.forEach((item) => {
      final reponse = await http.post(),
    });*/
    notifyListeners();
  }
  */
