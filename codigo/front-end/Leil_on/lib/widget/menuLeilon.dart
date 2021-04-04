import 'package:flutter/material.dart';

class MenuLeilon extends StatelessWidget {
  const MenuLeilon({Key key}) : super(key: key);

  Widget _createItem(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[50]),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
          color: Colors.purple,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[200],
          ),
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.amber[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              color: Colors.amber[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.purple[700],
                    size: 120.0,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.amber[400],
              child: Column(
                children: <Widget>[
                  _createItem(Icons.add_to_photos, 'Criar leilão'),
                  _createItem(Icons.settings, 'Configurações'),
                  _createItem(Icons.chat, 'Chat'),
                  _createItem(Icons.exit_to_app, 'Sair'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
