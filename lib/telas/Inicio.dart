import 'package:flutter/material.dart';
import 'package:youtube/API.dart';
import 'package:youtube/models/Video.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos() {
    var _api = YouTubeAPI();
    return _api.pesquisarVideo("Melhores");
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder< List<Video> >(
      future: _listarVideos(),
      builder: (context, snapshot){
        if(!snapshot.hasError){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: CircularProgressIndicator());
          }

          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            return ListView.separated(
                itemBuilder: (context, index){
                  List<Video> videos = snapshot.data;
                  Video video = videos[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(video.imagem),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        ListTile(
                          title: Text(video.titulo),
                          subtitle: Text(video.descricao),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: snapshot.data.length);
          }

          return Text("Nenhum vídeo encontrado");
        }

        return Text("Ocorreu um erro ao realizar a busca de videos");

      },

    );

  }
}
