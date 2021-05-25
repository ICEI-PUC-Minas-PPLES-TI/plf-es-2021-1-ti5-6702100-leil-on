import 'package:Leil_on/model/leilao.dart';
import 'package:Leil_on/view/telaDoLeilao.dart';
import 'package:flutter/material.dart';

class CardLeilao extends StatelessWidget {
  final Leilao leilao;
  CardLeilao(this.leilao);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purple,
        child: //Text('leilao'),
            Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  title: Text(leilao.nomeLeilao),
                  subtitle: Text(leilao.dataTermino),
                  trailing: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.purple[700],
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Text(
                      'Visualizar Leilão',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TelaDoLeilao(leilao),
                        ),
                      );
                    },
                  ),
                ),
                ExpansionTile(
                  title: Text('Itens'),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: leilao.itensAnunciados.length,
                      itemBuilder: (ctx, index) {
                        final item = leilao.itensAnunciados[index];
                        return ListTile(
                          title: Text(item),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
