import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:flutter/widgets.dart';

class LeilaoController with ChangeNotifier {
  Leilao leilaoSelecionado;
  Item itemSelecionado;
  List<Map<String, String>> lancesLeilao = [];

  proporLance(String lance) {
    lancesLeilao.add({'usuario': 'fulano', 'lance': lance});
  }
}
