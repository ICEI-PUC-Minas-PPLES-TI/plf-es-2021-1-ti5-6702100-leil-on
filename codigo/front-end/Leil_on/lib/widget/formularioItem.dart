import 'package:Leil_on/widget/menuCategoriaForm.dart';
import 'package:flutter/material.dart';

class FormularioItem extends StatefulWidget {
  //FormularioItem({Key key}) : super(key: key);

  @override
  _FormularioItemState createState() => _FormularioItemState();
}

class _FormularioItemState extends State<FormularioItem> {
  final _precoMinimoFocusNode = FocusNode();
  final _descricaoFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formulario = Map<String, Object>();

  @override
  void _dispose() {
    // TODO: implement dispose
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: _form,
          child: Column(
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
                      color: Colors.black,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_precoMinimoFocusNode);
                  },
                  onSaved: (value) => _formulario['nomeProduto'] = value,
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
                    FocusScope.of(context).requestFocus(_descricaoFocusNode);
                  },
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
                  onSaved: (value) => _formulario['descricao'] = value,
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
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
