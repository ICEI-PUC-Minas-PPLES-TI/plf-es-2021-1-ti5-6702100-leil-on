import 'package:Leil_on/controller/cadastroLeilao.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:Leil_on/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaDeDadosLeilao extends StatefulWidget {
  @override
  _TelaDeDadosLeilaoState createState() => _TelaDeDadosLeilaoState();
}

class _TelaDeDadosLeilaoState extends State<TelaDeDadosLeilao> {
  @override
  Widget build(BuildContext context) {
    Leilao dadosLeilao = Provider.of<CadastroLeilao>(context).novoLeilao;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro do leilão'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.amber[400],
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 10.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dadosLeilao.nomeLeilao,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.text_snippet,
                        color: Colors.purple,
                        size: 30.0,
                      ),
                      title: Container(
                        child: Text(
                          'Descrição',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        dadosLeilao.descricao,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.purple,
                      ),
                      title: Text(
                        'Data de término',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        dadosLeilao.dataTermino,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.purple,
                textColor: Colors.white,
                label: Text(
                  'Cadastrar Itens',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                icon: Icon(Icons.add_a_photo),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.TELADEITENSCADASTRADOS);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
