import 'dart:ui';

import 'package:Leil_on/controller/cadastroLeilao.dart';
import 'package:Leil_on/utils/app_routes.dart';
import 'package:Leil_on/view/telaDePesquisa.dart';
import 'package:Leil_on/widget/menuLeilon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saudacao extends StatelessWidget {
  const Saudacao({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nomeUsuario = Provider.of<CadastroLeilao>(context).nomeUsuario;
    final larguraTotal = MediaQuery.of(context).size.width * 0.7;
    final alturaTotal = MediaQuery.of(context).size.height * 0.8;
    //String emailUsuario = Provider.of<CadastroLeilao>(context).nomeEmail;
    /*var agora =
        ((new DateTime.utc(2021, DateTime.april, 18).millisecondsSinceEpoch) -
                DateTime.now().millisecondsSinceEpoch) /
            1000;
    var horas = DateTime.now().hour.toString();*/

    //var domingo =
    //
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.purple, size: 50.0),
        title: Text(
          'Bem vindo $nomeUsuario',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.amber[400],
      ),
      drawer: MenuLeilon(nomeUsuario),
      body: Container(
        //width: larguraTotal,
        color: Colors.amber[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: InkWell(
                onTap: () {
                  /*Navigator.of(context).pushNamed(AppRoutes.TELADEPESQUISA,
                      arguments: {'leilao'});*/
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TelaDePesquisa('auction'),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: Image.network(
                          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.gMXC8cCMuRe0c9ypKKcqTgHaFo%26pid%3DApi&f=1',
                          height: alturaTotal * 0.4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        // usado na stack para posicionar os itens dentro
                        right: 10,
                        bottom: 20,
                        child: Container(
                          width: larguraTotal,
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Text(
                            'Pesquisar por leilões',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                            ),
                            softWrap: true, // para ajustar tambem
                            overflow: TextOverflow
                                .fade, // para ajustar textos grandes
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: InkWell(
                onTap: () {
                  /* Navigator.of(context)
                      .pushNamed(AppRoutes.TELADEPESQUISA, arguments: {'item'});*/
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TelaDePesquisa('item'),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: Image.network(
                          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fst2.depositphotos.com%2F3643517%2F5662%2Fv%2F950%2Fdepositphotos_56622197-stock-illustration-digital-products-color-icons.jpg&f=1&nofb=1',
                          height: alturaTotal * 0.4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        // usado na stack para posicionar os itens dentro
                        right: 10,
                        bottom: 20,
                        child: Container(
                          width: larguraTotal,
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Text(
                            'Pesquisar por produtos',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                            ),
                            softWrap: true, // para ajustar tambem
                            overflow: TextOverflow
                                .fade, // para ajustar textos grandes
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
