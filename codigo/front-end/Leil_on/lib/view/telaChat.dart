import 'package:Leil_on/controller/autenticacao.dart';
import 'package:Leil_on/controller/leilaoController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class Chat extends StatefulWidget {
  //TelaDeLances({Key key}) : super(key: key);
  //final Item itemLeiloado;
  final String itemLeiloado, tipoChat, nomeLeilao;

  // TelaDeLances(this.itemLeiloado);
  Chat(this.nomeLeilao, this.itemLeiloado, this.tipoChat);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  //TextEditingController _chatTextController = TextEditingController();
  final inputController = TextEditingController();
  List<String> messageList = [];

  _enviaMensagem() {
    Provider.of<LeilaoController>(context, listen: false).enviarMensagem(
        inputController.text,
        widget.nomeLeilao,
        Provider.of<Autenticacao>(context, listen: false).userNome,
        widget.itemLeiloado);

    setState(() {
      messageList.clear();
      messageList.addAll(Provider.of<LeilaoController>(context).mensagensForum);
    });
  }

  _enviarLance() {
    Provider.of<LeilaoController>(context, listen: false).proporLance(
        widget.itemLeiloado,
        widget.nomeLeilao,
        double.parse(inputController.text),
        Provider.of<Autenticacao>(context, listen: false).userNome);
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
              widget.tipoChat == 'forum' ? _enviaMensagem() : _enviarLance();
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
    List<String> mensagens =
        Provider.of<LeilaoController>(context).mensagensForum;
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
                  : Expanded(child: getMessageList())),
          _bottomChatArea(),
        ],
      ),
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
