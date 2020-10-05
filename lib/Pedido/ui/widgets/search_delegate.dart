import 'package:flutter/material.dart';


class DataSearch extends SearchDelegate{
  final TextEditingController controller;
  DataSearch(this.controller);
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
   return [
     IconButton(
       icon: Icon(Icons.clear),
       onPressed: (){
         print("clin en boton borrar ");
       },
     )
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
   return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
  
}