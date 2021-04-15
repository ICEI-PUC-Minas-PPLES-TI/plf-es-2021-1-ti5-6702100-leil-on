import 'package:Leil_on/controller/autenticacao.dart';
import 'package:Leil_on/view/acesso.dart';
import 'package:Leil_on/view/dashBoardUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Autenticacao auth = Provider.of(context);
    //return auth.isAuth ? Saudacao() : Acesso();
    return Saudacao();
  }
}
