import 'package:Leil_on/controller/autenticacao.dart';
import 'package:Leil_on/utils/ExcecaoAcesso.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class Acesso extends StatefulWidget {
  Acesso({Key key}) : super(key: key);

  @override
  _AcessoState createState() => _AcessoState();
}

class _AcessoState extends State<Acesso> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  bool ehLogin = true;

  //Autenticacao auth=

  final Map<String, String> _authData = {
    'nome': '',
    'email': '',
    'senha': '',
    'celular': '',
    'CEP': '',
  };

  void _switchAutMod() {
    if (ehLogin) {
      setState(() {
        ehLogin = false;
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        ehLogin = true;
        _authMode = AuthMode.Login;
      });
    }
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    Autenticacao auth = Provider.of(context, listen: false);
    print("email salvo: " + _authData["email"]);
    try {
      if (_authMode == AuthMode.Login) {
        if (_authData["senha"].contains("kuskaorn")) {
          ExcecaoAcesso erro = new ExcecaoAcesso('INVALID_PASSWORD');
          // _showErrorDialog(erro.toString());
        } else {
          await auth.login(
            _authData["email"],
            _authData["senha"],
          );
        }
      } else {
        await auth.signup(
          _authData["email"],
          _authData["nome"],
          _authData["senha"],
          _authData["CEP"],
          _authData["celular"],
        );
        //   _showConfirmDialog();
      }
    } on ExcecaoAcesso catch (error) {
      // _showErrorDialog(error.toString());
    } catch (error) {
      // _showErrorDialog("Ocorreu um erro inesperado !");
    }

    setState(() {
      _isLoading = false;
    });
  }

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
                  key: _form,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Leil-on',
                            style: TextStyle(
                              color: Colors.deepPurple[800],
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        //    if (_authMode == AuthMode.Signup)
                        ehLogin
                            ? SizedBox(
                                height: 10,
                              )
                            : TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Nome",
                                  labelStyle: TextStyle(
                                    color: Colors.indigo[200],
                                    fontWeight: FontWeight.w400,
                                    fontSize: ehLogin ? 20 : 15,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: ehLogin ? 20 : 15,
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 4) {
                                    return 'Deve ter no minimo 4 caracteres';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _authData['nome'] = value,
                              ),

                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.indigo[200],
                              fontWeight: FontWeight.w400,
                              fontSize: ehLogin ? 20 : 15,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: ehLogin ? 20 : 15,
                          ),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Informe um e-mail válido ! ';
                            }
                            return null;
                          },
                          onSaved: (value) => _authData['email'] = value,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Colors.indigo[200],
                              fontWeight: FontWeight.w400,
                              fontSize: ehLogin ? 20 : 15,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return 'Informe uma senha válida';
                            }
                            return null;
                          },
                          onSaved: (value) => _authData['senha'] = value,
                          style: TextStyle(
                            fontSize: ehLogin ? 20 : 15,
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
                                    fontSize: 15,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 15,
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
                                    fontSize: 15,
                                  ),
                                ),
                                //controller: _senhaController,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 11) {
                                    return 'Informe um número válido';
                                  }
                                  return null;
                                },
                                onSaved: (value) =>
                                    _authData['celular'] = value,
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
                                  labelStyle: TextStyle(
                                    color: Colors.indigo[200],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                onSaved: (value) => _authData['CEP'] = value,
                              ),
                        SizedBox(height: 10),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
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
                              _authMode == AuthMode.Login
                                  ? 'Entrar'
                                  : 'Cadastrar',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: _submit,
                          ),
                        FlatButton(
                          onPressed: _switchAutMod,
                          child: Text(
                            ehLogin ? 'Cadastro' : 'Login',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
