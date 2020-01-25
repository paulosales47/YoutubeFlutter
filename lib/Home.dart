import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricoes.dart';

class Home extends StatefulWidget {

  String termoBusca = "";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> _telas = [
      Inicio(widget.termoBusca),
      EmAlta(),
      Inscricoes(),
      Biblioteca(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        title: Image.asset("images/youtube.png",
        width: 98, height: 22,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String termoBusca = await showSearch(context: context, delegate: CustomSearchDelegate());
              setState(() {
                widget.termoBusca = termoBusca;
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
        setState(() {
          _indiceAtual = indice;
        });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.orange,
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
              //backgroundColor: Colors.yellow,
              title: Text("Em alta"),
              icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
              //backgroundColor: Colors.blue,
              title: Text("Inscrições"),
              icon: Icon(Icons.video_library)
          ),
          BottomNavigationBarItem(
              //backgroundColor: Colors.green,
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
          ),
        ],
      ),

    );
  }
}
