import 'package:Leil_on/view/telaChat.dart';
import 'package:flutter/material.dart';

class CardItemLeilaoSelecionado extends StatelessWidget {
  final String item, nomeLeilao;
  CardItemLeilaoSelecionado(this.nomeLeilao, this.item);

  Widget _createItem(IconData icon, String label, Function ontap) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.purple),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 20,
          color: Colors.purple,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        onTap: ontap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: //Text('leilao'),
          Card(
        color: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                title: Text(item),
                subtitle: Text('Preço : R\$100.00 '),
                trailing: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.purple[700],
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Text(
                    'Participar do Leilão',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Chat(nomeLeilao, item, 'lance'),
                      ),
                    );
                  },
                ),
              ),
              ExpansionTile(
                title: Text('Informacoes'),
                children: [
                  _createItem(
                      Icons.search_rounded, 'Visualizar produto', () {}),
                  _createItem(Icons.forum_rounded, 'Fórum', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            Chat(nomeLeilao, item, 'forum'), //TelaDeChat()
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
