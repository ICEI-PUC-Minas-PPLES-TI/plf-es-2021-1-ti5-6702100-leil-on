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
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child:
                    /* Image.network(
                  'https://a-static.mlcdn.com.br/618x463/kit-computador-desktop-dell-vostro-3681-m20m-10a-geracao-intel-core-i5-8gb-1tb-windows-10-monitor-21/dell/v3681w209w1/dede26e9bf2c75467333e9201ea2d6d1.jpg',
                  height: alturaTotal * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),*/
                    Image.memory(
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
