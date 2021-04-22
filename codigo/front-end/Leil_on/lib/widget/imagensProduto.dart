import 'dart:io';
import 'package:Leil_on/controller/cadastroItem.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
//import 'package:path_provider/path_provider.dart';

class ImagensProduto extends StatefulWidget {
  ImagensProduto({Key key}) : super(key: key);

  @override
  _ImagensProdutoState createState() => _ImagensProdutoState();
}

class _ImagensProdutoState extends State<ImagensProduto> {
  File _storedImage;
  List<File> _imagens = [];

  _alternarFoto(File imagem, int indice) {
    setState(() {
      _storedImage = _imagens[0];
      _imagens[0] = imagem;
      _imagens[indice] = _storedImage;
    });
  }

  _galleryPicture() async {
    final ImagePicker _picker = ImagePicker();
    PickedFile imageFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    // aqui da pra pegar da galeria tambem

    if (imageFile == null) return;
    setState(() {
      _imagens.add(File(imageFile.path));
      Provider.of<CadastroItem>(context, listen: false)
          .adicionarFoto(File(imageFile.path));
      //_storedImage = File(imageFile.path);
    });
  }

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    PickedFile imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    // aqui da pra pegar da galeria tambem

    if (imageFile == null) return;
    setState(() {
      _imagens.add(File(imageFile.path));
      Provider.of<CadastroItem>(context, listen: false)
          .adicionarFoto(File(imageFile.path));
      //_storedImage = File(imageFile.path);
    });
  }

  Widget _criarFotoConainer(double largura, double altura, double tamanhoIcone,
      File imagem, int indice) {
    return Container(
      width: largura,
      height: altura,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Colors.purple,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: imagem != null
            ? Image.file(
                imagem,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.image,
                color: Colors.white,
                size: tamanhoIcone,
              ),
        onPressed: () {
          _alternarFoto(imagem, indice);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final larguraTotal = MediaQuery.of(context).size.width;
    final alturaTotal = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _criarFotoConainer(
                        larguraTotal * 0.27,
                        alturaTotal * 0.1,
                        alturaTotal * 0.05,
                        _imagens.length < 2 ? _storedImage : _imagens[1],
                        1),
                    SizedBox(
                      height: 10,
                    ),
                    _criarFotoConainer(
                        larguraTotal * 0.27,
                        alturaTotal * 0.1,
                        alturaTotal * 0.05,
                        _imagens.length < 3 ? _storedImage : _imagens[2],
                        2),
                    SizedBox(
                      height: 10,
                    ),
                    _criarFotoConainer(
                        larguraTotal * 0.27,
                        alturaTotal * 0.1,
                        alturaTotal * 0.05,
                        _imagens.length < 4 ? _storedImage : _imagens[3],
                        3),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                _criarFotoConainer(
                    larguraTotal * 0.5,
                    alturaTotal * 0.35,
                    alturaTotal * 0.15,
                    _imagens.length < 1 ? _storedImage : _imagens[0],
                    0),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FlatButton.icon(
                label: Text('Tirar foto'),
                icon: Icon(
                  Icons.add_a_photo,
                  size: 30.0,
                  color: Colors.purple[800],
                ),
                onPressed: _takePicture,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: FlatButton.icon(
                label: Text('Galeria'),
                icon: Icon(
                  Icons.add_photo_alternate,
                  size: 30.0,
                  color: Colors.purple[800],
                ),
                onPressed: _galleryPicture,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
