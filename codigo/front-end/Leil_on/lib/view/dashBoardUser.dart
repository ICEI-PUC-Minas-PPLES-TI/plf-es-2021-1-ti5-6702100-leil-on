import 'dart:ui';

import 'package:Leil_on/widget/menuLeilon.dart';
import 'package:flutter/material.dart';

class Saudacao extends StatelessWidget {
  const Saudacao({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.purple, size: 50.0),
        title: Text(
          'Tela DashBoard',
          style: TextStyle(
            color: Colors.grey[100],
          ),
        ),
        backgroundColor: Colors.amber[400],
      ),
      drawer: MenuLeilon(),
      body: Container(
        color: Colors.grey[200],
        child: Text(
          'Bem vindo Pedro',
          style: TextStyle(
            color: Colors.amber[300],
            fontSize: 50.0,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
