import 'package:flutter/material.dart';

class Saudacao extends StatelessWidget {
  const Saudacao({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela DashBoard'),
        backgroundColor: Colors.amber[400],
      ),
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
