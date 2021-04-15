class Categoria {
  List<String> categoria1 = [
    'Informatica',
    'Celulares e Telefones',
    'Games',
    'Brinquedos e Hobbies',
    'Arte, Papelaria e Armarinho',
    'Livros,Revistas e Comics',
    'Eletrodomésticos',
    'Instrumentos Musicais',
  ];

  Map<String, List<String>> mapa;

  List<Map<String, String>> categoria = [
    {'categoria1': 'Informatica', 'categoria2': 'Acessórios de Antiestática'},
    {'categoria1': 'Informatica', 'categoria2': 'PC de Mesa'},
    {'categoria1': 'Informatica', 'categoria2': 'Armazenamento'},
    {'categoria1': 'Informatica', 'categoria2': 'Acessórios para PC Gaming'},
    {'categoria1': 'Informatica', 'categoria2': 'Componentes para PC'},
    {'categoria1': 'Informatica', 'categoria2': 'Monitores e Acessórios'},
    {'categoria1': 'Informatica', 'categoria2': 'Tablets e Acessórios'},
    {'categoria1': 'Informatica', 'categoria2': 'Notebook'},
    {'categoria1': 'Informatica', 'categoria2': 'Outros'},
    {'categoria1': 'Games', 'categoria2': 'Acessórios para Consoles'},
    {'categoria1': 'Games', 'categoria2': 'Consoles'},
    {'categoria1': 'Games', 'categoria2': 'Video Games'},
    {'categoria1': 'Games', 'categoria2': 'Outros'},
    {'categoria1': 'Eletrodomésticos', 'categoria2': 'Geladeiras e Freezers'},
    {'categoria1': 'Eletrodomésticos', 'categoria2': 'Ar e Ventilação'},
    {
      'categoria1': 'Eletrodomésticos',
      'categoria2': 'Pequenos Eletrodomésticos'
    },
    {'categoria1': 'Eletrodomésticos', 'categoria2': 'Outros'},
    {
      'categoria1': 'Celulares e Telefones',
      'categoria2': 'Acessórios para Celulares'
    },
    {'categoria1': 'Celulares e Telefones', 'categoria2': 'Peças para Celular'},
    {
      'categoria1': 'Celulares e Telefones',
      'categoria2': 'Celulares e Smartphones'
    },
    {'categoria1': 'Celulares e Telefones', 'categoria2': 'Walkie Talkies'},
    {'categoria1': 'Celulares e Telefones', 'categoria2': 'Outros'},
    {'categoria1': 'Arte,Papelaria e Armarinho', 'categoria2': 'Arte'},
    {
      'categoria1': 'Arte,Papelaria e Armarinho',
      'categoria2': 'Artigos de Armarinho'
    },
    {
      'categoria1': 'Arte,Papelaria e Armarinho',
      'categoria2': 'Espelhos de Mosaicos'
    },
    {'categoria1': 'Arte,Papelaria e Armarinho', 'categoria2': 'Outros'},
    {
      'categoria1': 'Instrumentos Musicais',
      'categoria2': 'Instrumentos de Corda'
    },
    {
      'categoria1': 'Instrumentos Musicais',
      'categoria2': 'Instrumento de Sopro'
    },
    {'categoria1': 'Instrumentos Musicais', 'categoria2': 'Pianos e Teclados'},
    {
      'categoria1': 'Instrumentos Musicais',
      'categoria2': 'Equipamentos para DJs'
    },
    {'categoria1': 'Instrumentos Musicais', 'categoria2': 'Outos'},
    {'categoria1': 'Livros,Revistas e Comics', 'categoria2': 'Mangás'},
    {'categoria1': 'Livros,Revistas e Comics', 'categoria2': 'HQs'},
    {'categoria1': 'Livros,Revistas e Comics', 'categoria2': 'Outros'},
    {'catregoria1': 'Antiguidades e Coleções', 'categoria2': 'Antiguidades'},
    {
      'catregoria1': 'Antiguidades e Coleções',
      'categoria2': 'Cédulas e Moedas'
    },
    {'catregoria1': 'Antiguidades e Coleções', 'categoria2': 'Esculturas'},
    {'catregoria1': 'Antiguidades e Coleções', 'categoria2': 'Pósteres'},
    {'catregoria1': 'Antiguidades e Coleções', 'categoria2': 'Outros'},
  ];
  /*
  List <String> categoria1=['Informatica','Celular','Eletrodomésticos'];
  print('categoria1'+categoria1[0]);
  print('categoria1'+categoria1[1]);
  print('categoria1'+categoria1[2]);

  */
  List<String> categoria2 = [];

  List<String> retornarCategoriaCorrespondene(String categoriaSelecionada) {
    print('3');
    categoria.forEach((categorias) => {
          //print(categorias.values.toString()),
          print('4'),
          if (categorias.values.elementAt(0) == categoriaSelecionada)
            {
              print('5'),
              //print(categorias.values.elementAt(0))
              //print(categorias.values.elementAt(1)),
              categoria2.add(categorias.values.elementAt(1))
            }
        });
    return categoria2;
  }
  /*
  print(categoria2[1].toString());

*/
}
