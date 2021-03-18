import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Autenticacao with ChangeNotifier {
  String _token;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> signup(String email, String nome, String senha, String cep,
      String telefone) async {
    print('email :  $email  senha : $senha  cep :  $cep  telefone : $telefone');
    final urlSignup = 'http://leil-on.herokuapp.com/adduser';
    var response = await http.post(
      urlSignup,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          "name": "name",
          "password": senha,
          "email": email,
          "cep": cep,
          "telefone": telefone,
        },
      ),
    );
    print("resposta do servidor : " + response.body);
    final responseBody = json.decode(response.body);

    if (responseBody['msg'] != null) {}

    print('resposta do servidor eh ... ' + responseBody);
  }

  Future<void> login(String email, String senha) async {
    final urlLogin = 'http://leil-on.herokuapp.com/authenticate';

    var response = await http.post(
      urlLogin,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode({
        "email": email,
        "password": senha,
      }),
    );
    print('informacao : ' + response.body);
    final responseBody = json.decode(response.body);
    if (responseBody['msg'] != null) {
      print(' dentro ${responseBody['msg']}');
    } else {
      notifyListeners();
    }
    _token = responseBody['token'];
    return Future.value();
  }

  logout() {
    _token = null;
    // _userId = null;
  }
}
