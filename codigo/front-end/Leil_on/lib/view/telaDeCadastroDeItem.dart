import 'package:Leil_on/controller/cadastroItem.dart';
import 'package:Leil_on/controller/cadastroLeilao.dart';

import 'package:Leil_on/model/leilao.dart';

import 'package:Leil_on/widget/imagensProduto.dart';
import 'package:Leil_on/widget/menuCategoriaForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaDeCadastroDeitem extends StatefulWidget {
  @override
  _TelaDeCadastroDeitemState createState() => _TelaDeCadastroDeitemState();
}

class _TelaDeCadastroDeitemState extends State<TelaDeCadastroDeitem> {
  final _precoMinimoFocusNode = FocusNode();
  final _descricaoFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formulario = Map<String, Object>();

  @override
  void _dispose() {
    // TODO: implement dispose
    super.dispose();
    _precoMinimoFocusNode.dispose();
    _descricaoFocusNode.dispose();
    //_form.currentState.save();

    // Item itemCadastrado = new Item();
  }

  void _salvarFormulario(String nomeLeilao) {
    _form.currentState.save();
    print('testando aqui : ' + nomeLeilao);

    CadastroItem novoItem = Provider.of<CadastroItem>(context, listen: false);
    novoItem.adicionarInformacoesDoItem(nomeLeilao, _formulario['nomeProduto'],
        _formulario['precoProduto'], _formulario['descricao']);
    Provider.of<CadastroLeilao>(context, listen: false)
        .addItem(novoItem.novoItem);
  }

  @override
  Widget build(BuildContext context) {
    Leilao novoLeilao = Provider.of<CadastroLeilao>(context).novoLeilao;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro De Item'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amber[400],
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                ImagensProduto(),
                // FormularioItem(),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Form(
                      key: _form,
                      child: Column(
                        //shrinkWrap: true,
                        children: [
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.purple,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelText: 'Nome do produto : ',
                                labelStyle: TextStyle(
                                  fontSize: 15.0,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                // hoverColor: Colors.purple,
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_precoMinimoFocusNode);
                              },
                              onSaved: (value) =>
                                  _formulario['nomeProduto'] = value,
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Preço mínimo: ',
                                labelStyle: TextStyle(
                                  fontSize: 15.0,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                hoverColor: Colors.purple,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              textInputAction: TextInputAction.next,
                              focusNode: _precoMinimoFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_descricaoFocusNode);
                              },
                              onSaved: (value) => _formulario['precoProduto'] =
                                  double.parse(value),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                                labelStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                hoverColor: Colors.purple,
                              ),
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              focusNode: _descricaoFocusNode,
                              onSaved: (value) =>
                                  _formulario['descricao'] = value,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MenuCategoriaForm(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.purple,
                                textColor: Colors.white,
                                label: Text(
                                  'Prosseguir',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                icon: Icon(Icons.navigate_next),
                                onPressed: () {
                                  setState(() {
                                    _salvarFormulario(novoLeilao.nomeLeilao);
                                    Navigator.of(context).pop();
                                  });
//_salvarFormulario();
/*
                      Navigator.of(context)
                          .pushNamed(AppRoutes.TELADEDADOSLEILAO);*/
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
