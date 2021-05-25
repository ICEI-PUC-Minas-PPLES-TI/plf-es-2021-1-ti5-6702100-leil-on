import 'package:Leil_on/controller/leilaoController.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
//import 'package:Leil_on/model/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  //TelaDeLances({Key key}) : super(key: key);
  //final Item itemLeiloado;
  final String itemLeiloado, tipoChat;

  // TelaDeLances(this.itemLeiloado);
  Chat(this.itemLeiloado, this.tipoChat);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  //TextEditingController _chatTextController = TextEditingController();
  final inputController = TextEditingController();
  List<String> messageList = [];
  SocketIO _socket;
  //------------------------

  setOnChatMessageReceiveListener(Function onMessageReceived) {
    _socket.on("entrar", (data) {
      onMessageReceived(data);
    });
  }

  _bottomChatArea() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          _chatTextArea(),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.amber,
            ),
            onPressed: () {
              // _sendMessageBtnTap();
            },
          ),
        ],
      ),
    );
  }

  _chatTextArea() {
    return Expanded(
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // borda a ser exibida quando o inputDecoration é ativado e sem erro
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(10.0),
          hintText: 'Pesquisar ...', // texto de fundo do campo
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final larguraTotal = MediaQuery.of(context).size.width * 0.7;
    final alturaTotal = MediaQuery.of(context).size.height * 0.8;
    List<Map<String, String>> lances =
        Provider.of<LeilaoController>(context).lancesLeilao;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.purple, size: 50.0),
        title: Text(
          //'${widget.itemLeiloado.nomeProduto}',
          widget.itemLeiloado,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.amber[400],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: lances.isEmpty
                  ? Center(child: Text('Não há mensagens'))
                  : Expanded(child: getMessageList())
              /*ListView.builder(
                    padding: const EdgeInsets.all(5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lances.length,
                    itemBuilder: (ctx, index) {
                      final lance = lances[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3.0,
                            shadowColor: Colors.amber,
                            color: Colors.amber[400],
                            child: ListTile(
                              title: Text(lance.keys.toString()),
                              //subtitle: Text,
                              trailing: Text(
                                lance.values.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.purple,
                                ),
                              ),
                            )),
                      ); //CardLeilao(leilao); //Text('ok'); //CardLeilao(leilao);
                    },
                  ),*/
              ),
          _bottomChatArea(),
        ],
      ),
      /* bottomNavigationBar: BottomAppBar(
        color: Colors.purple,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: _bottomChatArea(),
      ),*/
    );
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (String message in messageList) {
      listWidget.add(ListTile(
        title: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 22),
            ),
          ),
          color: Colors.teal[50],
          height: 60,
        ),
      ));
    }

    return ListView(children: listWidget);
  }

  @override
  void dispose() {
    inputController.dispose();

    super.dispose();
  }
}
