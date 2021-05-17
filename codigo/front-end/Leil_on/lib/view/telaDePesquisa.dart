import 'package:Leil_on/controller/listagem.dart';
import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:Leil_on/widget/cardLeilao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Leil_on/widget/cardItem.dart';

class TelaDePesquisa extends StatefulWidget {
  final String tipoPesquisa;
  TelaDePesquisa(this.tipoPesquisa);
  //TelaDePesquisa({Key key}) : super(key: key);

  @override
  _TelaDePesquisaState createState() => _TelaDePesquisaState();
}

class _TelaDePesquisaState extends State<TelaDePesquisa> {
  GlobalKey<FormState> _form = GlobalKey();
  String pesquisa = '';

  _pesquisar() {
    _form.currentState.save();

    print('palavra pesquisada eh ... ' + pesquisa);
    Provider.of<Listagem>(context, listen: false)
        .retornarPesquisa(pesquisa, widget.tipoPesquisa);
  }

  @override
  Widget build(BuildContext context) {
    Listagem listagem = Provider.of<Listagem>(context);

    List<Item> listaDeProdutos = listagem.itensPesquisados;
    List<Leilao> listaDeLeiloes = listagem.leiloesPesquisados;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        title: Form(
          key: _form,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Pesquisar",
              labelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: _pesquisar,
              ),
            ),
            onSaved: (value) => pesquisa = value,
          ),
        ),
        backgroundColor: Colors.amber[400],
      ),
      body: SingleChildScrollView(
        child: (listaDeProdutos.isEmpty && widget.tipoPesquisa == 'item') ||
                (listaDeLeiloes.isEmpty && widget.tipoPesquisa == 'leilao')
            ? Text('vazio')
            : Padding(
                padding: const EdgeInsets.all(5),
                child: widget.tipoPesquisa == 'item'
                    ? GridView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(5),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: (3 / 2) / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        children: listaDeProdutos.map((item) {
                          return CardItem(item.imagens1[0], item.nomeProduto,
                              item.precoMinimo.toString());
                        }).toList(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(5),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listaDeLeiloes.length,
                        itemBuilder: (ctx, index) {
                          final leilao = listaDeLeiloes[index];
                          return CardLeilao(
                              leilao); //Text('ok'); //CardLeilao(leilao);
                        },
                      )),
      ),
      backgroundColor: Colors.amber[100],
    );
  }
}

/*physics: 
GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: DUMMY_CATEGORIES.map((cat) {
        return CategoryItem(cat);
      }).toList(),
    );

CardItem()

Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Item(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Item(),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Item(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Item(),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Item(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Item(),
                ),
              ],
            ),
          ],
        ),


ListView.builder(
                shrinkWrap: true,
                itemCount: listaDeProdutos.length,
                itemBuilder: (ctx, index) {
                  final item = listaDeProdutos[index];
                  return Row(
                    children: [
                      CardItem(),
                    ],
                  );
                },
              ),

 */
