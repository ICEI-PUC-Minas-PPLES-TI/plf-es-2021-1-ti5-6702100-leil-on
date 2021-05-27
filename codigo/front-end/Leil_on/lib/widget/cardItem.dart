import 'dart:typed_data';

import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Uint8List imagem;
  final String nome;
  final String preco;
  const CardItem(this.imagem, this.nome, this.preco);

  @override
  Widget build(BuildContext context) {
    final larguraTotal = MediaQuery.of(context).size.width * 0.7;
    final alturaTotal = MediaQuery.of(context).size.height * 0.8;
    return Container(
      width: larguraTotal * 0.65,
      child: InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(2),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: Image.memory(
                  imagem,
                  height: alturaTotal * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(nome),
                subtitle: Text('R\$\ $preco'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
