import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/models/Video.dart';

const CHAVE_API = "AIzaSyBuwEea3vEUEJW84A_txUyLTbhEfpTW2u4";// "AIzaSyCLvVAZgtzZvKOn2YLJJ1GjBpoaYXiVllA";
const ID_CANAL = "UCBFLqK7PAP9DQ3JpIrWFI7w";
const URL_BASE = "https://www.googleapis.com/youtube/v3";

class YouTubeAPI{

  Future<List<Video>> pesquisarVideo(String pesquisa) async{

    http.Response response = await http.get(
        "$URL_BASE/search"
        "?part=snippet"
        "&type=video"
        "&maxResults=20"
        "&order=date"
        "&channelId=$ID_CANAL"
        "&key=$CHAVE_API"
        "&q=$pesquisa");

    if(response.statusCode == 200){

        Map<String, dynamic> retornoApi = jsonDecode(response.body);

        List<Video> videos = retornoApi["items"].map<Video>((map){
          return Video.fromJson(map);
        }).toList();

        return videos;
    }

  }
}