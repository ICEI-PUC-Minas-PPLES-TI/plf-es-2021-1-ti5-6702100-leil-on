import 'dart:convert';

import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LeilaoController with ChangeNotifier {
  Leilao leilaoSelecionado;
  Item itemSelecionado;
  List<Map<String, String>> lancesLeilao = [];
  List<String> mensagensForum = [];

  Future<void> proporLance(String nomeItem, String nomeLeilao, double lance,
      String pessoaLance) async {
    final urlLanceLeilao = 'http://leil-on.herokuapp.com/bid';
    final response = await http.post(
      urlLanceLeilao,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode({
        'itemName': nomeItem,
        'linkedAuction': nomeLeilao,
        'bid': lance,
        'personName': pessoaLance,
      }),
    );
    var responseBody = json.decode(response.body);

    print(responseBody);
    notifyListeners();

    lancesLeilao.add({'usuario': 'fulano', 'lance': lance.toString()});
  }

  Future<void> enviarMensagem(String mensagem, String nomeLeilao,
      String usuario, String itemLeiloado) async {
    final urlMensagemForum = 'http://leil-on.herokuapp.com/sendmsg';
    final response = await http.post(
      urlMensagemForum,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'item': itemLeiloado,
          'linkedAuction': nomeLeilao,
          'user': usuario,
          'msg': mensagem,
        },
      ),
    );
    var responseBody = json.decode(response.body);

    print(responseBody);

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((chave, valor) => {
          if (chave == 'forum')
            {
              (valor as List<dynamic>).forEach(
                  (mensagem) => {mensagensForum.add(mensagem['mensagem'])})
            }
        });

    //mensagensForum.add()
    notifyListeners();
  }

  carregarMensagemForum() {}

  carregarMensagemLance() {}
}
