import 'package:Leil_on/model/leilao.dart';
import 'package:Leil_on/widget/cardItemDoLeilao.dart';
import 'package:flutter/material.dart';

class TelaDoLeilao extends StatefulWidget {
  final Leilao leilaoSelecionado;
  TelaDoLeilao(this.leilaoSelecionado);
  @override
  _TelaDoLeilaoState createState() => _TelaDoLeilaoState();
}

class _TelaDoLeilaoState extends State<TelaDoLeilao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.purple, size: 50.0),
        title: Text(
          '${widget.leilaoSelecionado.nomeLeilao}',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.amber[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                      title: Text('Vendedor : '),
                      subtitle: Text(widget.leilaoSelecionado.nomeVendedor),
                    ),
                    ListTile(
                      title: Text('Data de término : '),
                      subtitle: Text(widget.leilaoSelecionado.dataTermino),
                    ),
                    ExpansionTile(
                      title: Text('Descrição : '),
                      children: [
                        Text(
                          widget.leilaoSelecionado.descricao,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'Itens',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // a listagem de item
              Container(
                color: Colors.amber[100],
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.leilaoSelecionado.itensAnunciados.length,
                  itemBuilder: (ctx, index) {
                    final item =
                        widget.leilaoSelecionado.itensAnunciados[index];
                    return CardItemLeilaoSelecionado(
                        widget.leilaoSelecionado.nomeLeilao, item);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.amber[100],
    );
  }
}
