import 'dart:io';

import 'package:flutter/material.dart';

class TelaDeItemCadastrado extends StatelessWidget {
  const TelaDeItemCadastrado({Key key}) : super(key: key);
  Widget _criarFotoConainer(double largura, double altura, File imagem) {
    return Container(
      width: largura,
      height: altura,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Colors.purple,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Image.file(
          imagem,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
