import 'dart:ui';

import 'package:Leil_on/controller/cadastroLeilao.dart';
import 'package:Leil_on/widget/menuLeilon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saudacao extends StatelessWidget {
  const Saudacao({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nomeUsuario = Provider.of<CadastroLeilao>(context).nomeUsuario;
    String emailUsuario = Provider.of<CadastroLeilao>(context).nomeEmail;
    var agora =
        ((new DateTime.utc(2021, DateTime.april, 18).millisecondsSinceEpoch) -
                DateTime.now().millisecondsSinceEpoch) /
            1000;
    var horas = DateTime.now().hour.toString();
    //var domingo =

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.purple, size: 50.0),
        title: Text(
          'Cadastro Leilao',
          style: TextStyle(
            color: Colors.grey[100],
          ),
        ),
        backgroundColor: Colors.amber[400],
      ),
      drawer: MenuLeilon(),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Bem vindo $nomeUsuario',
              style: TextStyle(
                color: Colors.amber[300],
                fontSize: 40.0,
              ),
            ),
            Text(
              'Seu contanto $emailUsuario',
              style: TextStyle(
                color: Colors.amber[300],
                fontSize: 40.0,
              ),
            ),
            Text(
              'data agora $agora',
              style: TextStyle(
                color: Colors.amber[300],
                fontSize: 40.0,
              ),
            ),
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
