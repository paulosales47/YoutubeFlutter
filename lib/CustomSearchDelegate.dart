import 'package:flutter/material.dart';
import 'package:youtube/API.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
        icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, "");
      },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isNotEmpty){

      List<String> sugestoes = ["Oscar", "Terror", "Ação", "Melhores", "Piores"]
          .where( (texto) =>
            texto.toLowerCase().startsWith(query)
      ).toList();

      return ListView.builder(
          itemCount: sugestoes.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(sugestoes[index]),
              onTap: (){
                close(context, sugestoes[index]);
              },
            );
          });


    }


    return Container();


  }


}