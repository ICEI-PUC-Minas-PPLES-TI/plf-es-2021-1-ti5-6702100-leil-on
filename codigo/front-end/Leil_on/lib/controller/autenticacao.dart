import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Autenticacao with ChangeNotifier {
  String _token;
  String _userId;
  String userNome;
  String userEmail;

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
    final urlSignup = 'http://leil-on.herokuapp.com/adduser';
    var response = await http.post(
      urlSignup,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          "name": nome,
          "password": senha,
          "email": email,
          "cep": cep,
          "telefone": telefone,
        },
      ),
    );
    final responseBody = json.decode(response.body);

    if (responseBody['msg'] != null) {}
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
    final responseBody = json.decode(response.body);
    if (responseBody['msg'] != null) {
    } else {
      _token = responseBody['token'];
      userNome = responseBody['decodedtoken']['name'];
      userEmail = responseBody['decodedtoken']['email'];
      notifyListeners();
    }

    return Future.value();
  }

  logout() {
    _token = null;
    _userId = null;
  }
}
