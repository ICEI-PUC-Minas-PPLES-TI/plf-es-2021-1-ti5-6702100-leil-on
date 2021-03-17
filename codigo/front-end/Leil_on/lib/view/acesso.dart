import 'package:flutter/material.dart';

enum AythMode { Signup, Login }

class Acesso extends StatefulWidget {
  Acesso({Key key}) : super(key: key);

  @override
  _AcessoState createState() => _AcessoState();
}

class _AcessoState extends State<Acesso> {
  GlobalKey<FormState> _form = GlobalKey();
  bool ehLogin = true;

  void _switchAutMod() {
    if (ehLogin) {
      setState(() {
        ehLogin = false;
      });
    } else {
      setState(() {
        ehLogin = true;
      });
    }
  }

  /*
  bool _isLoading = false;
  final _senhaController = TextEditingController();
  //AuthMode _authMode = AuthMode.Login;

  final Map<String, String> _authData = {
    'email': '',
    'senha': '',
    'celular': '',
    'CEP': '',
  };

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Cadastro realizado!'),
        content: Text('Será retornado para a tela de login'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
             // Auth auth = Provider.of(context, listen: false);
              //auth.logout();
              //Navigator.of(context).popAndPushNamed(AppRoutes.AUTHOUFICHAS);
            },
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white54,
        child: Container(
          margin: EdgeInsets.only(
            top: 40,
            left: 40,
            right: 40,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                height: MediaQuery.of(context).size.height * 0.9,
                child: Form(
                  //  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Leil-on',
                          style: TextStyle(
                            color: Colors.deepPurple[800],
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      //    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.indigo[200],
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Informe um e-mail válido ! ';
                          }
                          email = value;
                          return null;
                        },
                        //  onSaved: (value) => _authData['email'] = value,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Colors.indigo[200],
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return 'Informe uma senha válida';
                          }
                          password = value
                          return null;
                        },
                        //  onSaved: (value) => _authData['senha'] = value,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ehLogin
                          ? SizedBox(
                              height: 10,
                            )
                          : TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Confirmar Senha",
                                labelStyle: TextStyle(
                                  color: Colors.indigo[200],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              /*  onSaved: (value) =>
                              _authData['confirmacao'] = value,*/
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      ehLogin
                          ? SizedBox(
                              height: 10,
                            )
                          : TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: "Celular",
                                labelStyle: TextStyle(
                                  color: Colors.indigo[200],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                              //controller: _senhaController,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.length < 11) {
                                  return 'Informe um número válido';
                                }
                                return null;
                              },
                              //  onSaved: (value) => _authData['senha'] = value,
                            ),
                      SizedBox(height: 10),
                      ehLogin
                          ? SizedBox(
                              height: 10,
                            )
                          : //if (_authMode == AuthMode.Signup)
                          TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "CEP",
                                onChanged: (value){
                                  cep = value;
                                }
                                labelStyle: TextStyle(
                                  color: Colors.indigo[200],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              /*  onSaved: (value) =>
                              _authData['confirmacao'] = value,*/
                            ),
                      SizedBox(height: 10),
                      //if (_isLoading)
                      //CircularProgressIndicator()
                      //else
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.amber[700],
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                        child: Text(
                          //  _authMode == AuthMode.Login
                          ehLogin ? 'Entrar' : 'Cadastrar',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          AuthService.login(email, password).then(value)
                        }, //_submit,
                      ),
                      FlatButton(
                        onPressed: _switchAutMod,
                        child: Text(
                          ehLogin ? 'Registrar' : 'Login',
                          style: TextStyle(
                            color: Colors.amber[700],
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
