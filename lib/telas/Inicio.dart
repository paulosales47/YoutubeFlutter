import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube/API.dart';
import 'package:youtube/models/Video.dart';

class Inicio extends StatefulWidget {

  String termoBusca;

  Inicio(this.termoBusca);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String termoBusca) {
    var _api = YouTubeAPI();
    return _api.pesquisarVideo(termoBusca);
  }

  @override
  void initState() {
    super.initState();
    print("1 - initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("2 - didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    print("4 - dispose");
  }
  
  @override
  void didUpdateWidget(Inicio oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }
  
  @override
  Widget build(BuildContext context) {

    return FutureBuilder< List<Video> >(
      future: _listarVideos(widget.termoBusca),
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

                  return GestureDetector(
                    onTap: () =>
                      FlutterYoutube.playYoutubeVideoById(
                          apiKey: CHAVE_API,
                          videoId:video.id,
                          fullScreen: true,
                          autoPlay: true)
                    ,
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
                          title: Text(video.titulo, textAlign: TextAlign.center,),
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
