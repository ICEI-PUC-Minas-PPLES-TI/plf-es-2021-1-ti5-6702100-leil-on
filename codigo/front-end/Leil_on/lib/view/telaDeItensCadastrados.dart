import 'package:Leil_on/controller/cadastroLeilao.dart';
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
  @override
  void initState() {
    super.initState();
    print('sera?');
    // _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    Leilao dadosLeilao = Provider.of<CadastroLeilao>(context).novoLeilao;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista De Produtos'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100], //amber[400],
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              dadosLeilao.itensCadastrados.length == 0
                  ? Text('Vazio')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: dadosLeilao.itensCadastrados.length,
                      itemBuilder: (ctx, index) {
                        final item = dadosLeilao.itensCadastrados[index];
                        return Text('${item.nomeProduto}');
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
                      Navigator.of(context).pushNamed(AppRoutes.CADASTRARITEM);
                    },
                  ),
                ],
              ),
            ],
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
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
