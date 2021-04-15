import 'package:Leil_on/controller/cadastroLeilao.dart';
import 'package:Leil_on/model/leilao.dart';
import 'package:Leil_on/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaCadastroLeilao extends StatefulWidget {
  TelaCadastroLeilao({Key key}) : super(key: key);

  @override
  _TelaCadastroLeilaoState createState() => _TelaCadastroLeilaoState();
}

class _TelaCadastroLeilaoState extends State<TelaCadastroLeilao> {
  final _descricaoFocusNode = FocusNode();
  final _dataFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formulario = Map<String, Object>();
  DateTime _dataTermino;
  Leilao novoLeilao = new Leilao();

  @override
  void dispose() {
    super.dispose();
    _descricaoFocusNode.dispose();
    _dataFocusNode
        .dispose(); // para limpa as informacoes armazenadas pelo objeto
  }

  void _salvarFormulario() {
    _form.currentState.save();
    Provider.of<CadastroLeilao>(context, listen: false).regInfoDoLeilao(
      _formulario['nomeLeilao'],
      'Lucas',
      _formulario['descricao'],
      '${_dataTermino.day}/${_dataTermino.month}/${_dataTermino.year}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cadastro do leilão'), backgroundColor: Colors.purple),
      body: Container(
        color: Colors.amber[400],
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: 'Nome do Leilão',
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    // hoverColor: Colors.purple,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descricaoFocusNode);
                  },
                  onSaved: (value) => _formulario['nomeLeilao'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    hoverColor: Colors.purple,
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descricaoFocusNode,
                  onSaved: (value) => _formulario['descricao'] = value,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Data de encerramento : ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[100],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    _dataTermino == null
                        ? RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text('Informar data'),
                            color: Colors.purple,
                            textColor: Colors.white,
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: _dataTermino == null
                                    ? DateTime.now()
                                    : _dataTermino,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              ).then((data) {
                                setState(() {
                                  _dataTermino = data;
                                });
                              });
                            },
                          )
                        : Row(
                            children: [
                              Text(
                                //  _dataTermino.toString(),
                                '${_dataTermino.day}/${_dataTermino.month}/${_dataTermino.year}',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: _dataTermino == null
                                        ? DateTime.now()
                                        : _dataTermino,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                  ).then((data) {
                                    setState(() {
                                      _dataTermino = data;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
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
                        _salvarFormulario();

                        Navigator.of(context)
                            .pushNamed(AppRoutes.TELADEDADOSLEILAO);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
