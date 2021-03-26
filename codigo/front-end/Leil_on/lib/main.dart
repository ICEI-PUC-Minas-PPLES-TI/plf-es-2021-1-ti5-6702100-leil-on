import 'package:Leil_on/controller/autenticacao.dart';
import 'package:Leil_on/utils/app_routes.dart';
import 'package:Leil_on/utils/authOrUser.dart';
import 'package:Leil_on/view/acesso.dart';
import 'package:Leil_on/view/dashBoardUser.dart';
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
          }),
    );
  }
}
