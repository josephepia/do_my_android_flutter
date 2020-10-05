import 'dart:async';

import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapboxSearch;

class OrigenHero extends StatefulWidget {

  @override
  _OrigenHeroState createState() => _OrigenHeroState();
}

class _OrigenHeroState extends State<OrigenHero> {
  final _searchQuery = new TextEditingController();
  Timer _debounce;
  UserBloc userBloc;
  bool debounceActive = false;
  List<mapboxSearch.MapBoxPlace> resultados = [];

//  _onSearchChanged() {
//    if (_debounce?.isActive ?? false) _debounce.cancel();
//    _debounce = Timer(const Duration(milliseconds: 500), (){
//      // do something with _searchQuery.text
//      if(_searchQuery.text.isNotEmpty && _searchQuery.text.length > 10 ){
//         userBloc.getPlaces(_searchQuery.text).then((value) => resultados = value);
//
//      }
//
//    });
//  }
  _onSearchChanged() async {
    if(debounceActive) return null;
    debounceActive = true;
    await Future.delayed(Duration(milliseconds: 700));
    debounceActive = false;
  }



  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Column(


        children: [
          TextFormField(
            controller: _searchQuery,
            maxLines: 1,
            keyboardType: TextInputType.text,
//                                            inputFormatters: [
//                                              WhitelistingTextInputFormatter.digitsOnly
//                                            ],
            onSaved: (value) {
              userBloc.nuevoPedido.origen = value;
            },
            onChanged: (value){

            },
            validator: (value) {
              if (value.isEmpty || value == "") {
                return 'Ingrese una dirección';
              }
              return null;
            },
            style: TextStyle(fontFamily: "Poppins"),

            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                labelStyle: TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                border: InputBorder.none,
                hintText: "Origen",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),

          ItemSearch(this.resultados)
        ],
      ),
    );
  }
}

class ItemSearch extends StatelessWidget {
  final List<mapboxSearch.MapBoxPlace> places;

  ItemSearch(this.places);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: places.length,
        itemBuilder:(BuildContext context, int i){
          print("datos ");
          print(places[i].placeName);
          print("------------");
          print(places[i].toString());
          return ListTile(
            title: Text("nombre de la direccion")
          );

        }

    );
  }
}

