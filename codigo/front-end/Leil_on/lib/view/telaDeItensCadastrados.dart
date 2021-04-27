import 'dart:io';

import 'package:Leil_on/controller/cadastroLeilao.dart';
import 'package:Leil_on/model/item.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:Leil_on/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaDeItensCadastrados extends StatefulWidget {
  TelaDeItensCadastrados({Key key}) : super(key: key);

  @override
  _TelaDeItensCadastradosState createState() => _TelaDeItensCadastradosState();
}

class _TelaDeItensCadastradosState extends State<TelaDeItensCadastrados> {
  // bool _isLoading = true;
  //CadastroLeilao cadastroLeilao;
  //Leilao dadosLeilao;

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
  void initState() {
    super.initState();
    print('sera?');
    // _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    //Leilao dadosLeilao = Provider.of<CadastroLeilao>(context).novoLeilao;
    List<Item> itens = Provider.of<CadastroLeilao>(context).itens;
    Leilao novoLeilao = Provider.of<CadastroLeilao>(context).novoLeilao;
    final larguraTotal = MediaQuery.of(context).size.width;
    final alturaTotal = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: AppBar(
        title: Text('Lista De Produtos'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amber[300],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              right: 10,
              left: 10,
              bottom: 10,
            ),
            child: Column(
              children: [
                itens.length == 0
                    ? Text('Vazio')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: itens.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          final item = itens[index];

                          return Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _criarFotoConainer(larguraTotal * 0.35,
                                    alturaTotal * 0.25, item.imagens[0]),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: larguraTotal * 0.55,
                                      alignment: Alignment.bottomLeft,
                                      child: TextButton(
                                        child: Text(
                                          item.nomeProduto,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple[700],
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Text(
                                      'Preço Inicial:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.purple[700]),
                                    ),
                                    Container(
                                      width: larguraTotal * 0.55,
                                      child: Text(
                                        item.precoMinimo.toString(),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Text(
                                      'Descricao',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.purple[700]),
                                    ),
                                    Container(
                                      width: larguraTotal * 0.55,
                                      child: Text(
                                        item.descricao,
                                        overflow: TextOverflow.clip,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );

                          //Text('${item.descricao}');
                        },
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      child: Icon(
                        Icons.add,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.CADASTRARITEM);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.CADASTRARITEM);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        //elevation: 50.0,
        color: Colors.purple,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            FlatButton.icon(
              label: Text(
                'Finalizar',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Provider.of<CadastroLeilao>(context, listen: false)
                      .addLeilao();
                  Provider.of<CadastroLeilao>(context, listen: false)
                      .cadastrarItem(itens[0]);
                  Navigator.of(context).pushNamed(AppRoutes.AUTHOUUSER);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
