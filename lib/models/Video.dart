class Video{
  String id;
  String titulo;
  String imagem;
  String descricao;
  String canal;

  Video({this.id, this.titulo, this.imagem, this.descricao});

  factory Video.fromJson(Map<String, dynamic> map){
    return Video(
        id: map["id"]["videoId"],
        titulo: map["snippet"]["title"],
        imagem: map["snippet"]["thumbnails"]["high"]["url"],
        descricao: map["snippet"]["description"]
    );
  }
}