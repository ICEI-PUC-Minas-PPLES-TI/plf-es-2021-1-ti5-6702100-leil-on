import 'package:Leil_on/controller/autenticacao.dart';
import 'package:Leil_on/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuLeilon extends StatelessWidget {
  final String nomeUsuario;
  const MenuLeilon(this.nomeUsuario);

  Widget _createItem(IconData icon, String label, Function ontap) {
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
        onTap: ontap,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: Colors.purple[700],
                          size: 120.0,
                        ),
                      ],
                    ),
                    Text(
                      nomeUsuario,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.amber[400],
              child: Column(
                children: <Widget>[
                  _createItem(Icons.add_to_photos, 'Criar leilão', () {
                    Navigator.of(context).pushNamed(AppRoutes.CADASTROLEILAO);
                  }),
                  _createItem(Icons.chat, 'Chat', () {}),
                  _createItem(Icons.settings, 'Configurações', () {}),
                  _createItem(Icons.exit_to_app, 'Sair', () {
                    Autenticacao sair =
                        Provider.of<Autenticacao>(context, listen: false);
                    sair.logout();
                    Navigator.of(context).pushNamed(AppRoutes.AUTHOUUSER);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
