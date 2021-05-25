import 'package:Leil_on/controller/autenticacao.dart';
import 'package:Leil_on/controller/cadastroItem.dart';
import 'package:Leil_on/controller/cadastroLeilao.dart';
import 'package:Leil_on/controller/leilaoController.dart';
import 'package:Leil_on/controller/listagem.dart';
import 'package:Leil_on/utils/app_routes.dart';
import 'package:Leil_on/utils/authOrUser.dart';
import 'package:Leil_on/view/acesso.dart';
import 'package:Leil_on/view/dashBoardUser.dart';
import 'package:Leil_on/view/telaCadastroLeilao.dart';
import 'package:Leil_on/view/telaDeCadastroDeItem.dart';
import 'package:Leil_on/view/telaDeDadosLeilao.dart';
import 'package:Leil_on/view/telaDeItemCadastrado.dart';
import 'package:Leil_on/view/telaDeItensCadastrados.dart';
import 'package:Leil_on/view/telaDePesquisa.dart';
import 'package:Leil_on/view/telaDoLeilao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Autenticacao(),
        ),
        ChangeNotifierProxyProvider<Autenticacao, CadastroLeilao>(
          create: (_) => new CadastroLeilao(null, null),
          update: (ctx, auth, cadastroLeilao) => new CadastroLeilao(
            auth.userNome,
            auth.userEmail,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => new CadastroItem(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => new Listagem(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => new LeilaoController(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //home: Acesso(),
          routes: {
            AppRoutes.AUTHOUUSER: (ctx) => AuthOrUser(),
            AppRoutes.LOGIN: (ctx) => Acesso(),
            AppRoutes.USERVIEW: (ctx) => Saudacao(),
            AppRoutes.CADASTROLEILAO: (ctx) => TelaCadastroLeilao(),
            AppRoutes.TELADEDADOSLEILAO: (ctx) => TelaDeDadosLeilao(),
            AppRoutes.TELADEITENSCADASTRADOS: (ctx) => TelaDeItensCadastrados(),
            AppRoutes.TELADEITEMCADASTRADO: (ctx) => TelaDeItemCadastrado(),
            AppRoutes.CADASTRARITEM: (ctx) => TelaDeCadastroDeitem(),
            // AppRoutes.TELADOLEILAO: (ctx) => TelaDoLeilao(),
            //AppRoutes.TELADEPESQUISA: (ctx) => TelaDePesquisa(),
          }),
    );
  }
}
