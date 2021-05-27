import 'package:Leil_on/controller/cadastroItem.dart';
import 'package:Leil_on/model/categoria.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuCategoriaForm extends StatefulWidget {
  @override
  _MenuCategoriaFormState createState() => _MenuCategoriaFormState();
}

class _MenuCategoriaFormState extends State<MenuCategoriaForm> {
  List<String> categories = new Categoria().categoria1;
  List<String> categories2 = [];
  String _category;
  String _category1;
  bool _vazio = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Categoria 1 : ',
            style: TextStyle(color: Colors.black),
          ),
          Container(
            child: DropdownButtonFormField(
              items: categories.map((String category) {
                return new DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.star),
                        Text(category),
                      ],
                    ));
              }).toList(),
              onChanged: (newValue) {
                // do other stuff with _category
                setState(() {
                  print('1');
                  _category = newValue;
                  print('2');
                  categories2 =
                      new Categoria().retornarCategoriaCorrespondene(_category);
                  _vazio = true;
                });
              },
              value: _category,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                filled: true,
                fillColor: Colors.amber[400],
              ),
            ),
          ),
          _vazio
              ? Text('Selecione uma categoria anterior')
              : Text(
                  'Categoria 2 : ',
                  style: TextStyle(color: Colors.black),
                ),
          Container(
            child: DropdownButtonFormField(
              items: categories2.map((String category1) {
                return new DropdownMenuItem(
                    value: category1,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.star),
                        Text(category1),
                      ],
                    ));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _category1 = newValue;
                  Provider.of<CadastroItem>(context, listen: false)
                      .adicionarCategorias(_category, _category1);
                });
              },
              value: _category1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                filled: true,
                fillColor: Colors.amber[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
