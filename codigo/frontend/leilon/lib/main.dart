import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage()
  ),
  );
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  Map data;
  List usersData;

  getUsers() async{
  http.Response response = await http.get('http://10.0.2.2:8081/api/users');
  data = json.decode(response.body);
  setState(() {
    usersData =   data['users'];
  });
  }

 @override
 void initState(){
    super.initState();
    getUsers();
  }

  Widget build(BuildContext context){
  return Scaffold(
      appBar: AppBar(
          title: Text('Leil-on'),
          backgroundColor: Colors.indigo[900]),
      body: ListView.builder(itemCount: usersData == null ? 0 : usersData.length,
        itemBuilder: (BuildContext context, int index){
        return Card(
          child: Row(
            children: <Widget>[
              Text("${usersData[index]["firstName"]}")
            ],
          ),
        );
        },

      )
      );
}
}
