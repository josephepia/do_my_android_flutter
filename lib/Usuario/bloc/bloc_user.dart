import 'dart:async';
import 'dart:io';

import 'package:do_my/Pedido/model/pedido.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/model/user_location.dart';
import 'package:do_my/Usuario/repository/firebase_database_api.dart';
import 'package:do_my/Usuario/repository/firebase_database_repository.dart';
import 'package:do_my/Usuario/repository/firebase_storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:do_my/Usuario/repository/auth_repository.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapboxSearch;
class UserBloc implements Bloc{
  final _auth_repository = AuthRepository();
  final _database_repository = FirebaseDatabaseRepository();
  final _apiKey = "pk.eyJ1Ijoiam9zZXBoZXBpYSIsImEiOiJja2Vha2F3N3QwMWRwMzBwYjh3ZDllczQ4In0.Ygj_AikKyCebs2N51vcMHQ";
  final _storageRepository = FirebaseSorageRepository();
//  final geoLocator = Geolocator()..forceAndroidLocationManager = true;

  final _locationService = Location();
  static UserBloc _instancia;

  static final UserBloc _singleton = UserBloc._internal();

  factory UserBloc(){
//    if(_instancia == null){
//      _instancia = new UserBloc._internal();
//    }

//    return _instancia;

  return _singleton;
  }


  StreamController<geo.Position> geoController = StreamController.broadcast();

  Stream<geo.Position>  get geoStream => geoController.stream.asBroadcastStream();




  Future<geo.Position> get positionGeo =>  geo.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.low ,forceAndroidLocationManager: true);
//  UserBloc._internal();

   


_geoListen(dynamic geo){

  geoController.add(geo);

}


  UserLocation _currentLocation;

  Location location = Location();


  //Stream de firebase para la sesion

  Pedido _nuevoPedido = Pedido();
  Stream<LocationData> get streamLocationNew => _locationService.onLocationChanged;

  final Stream<FirebaseUser> _streamFirebsae = FirebaseAuth.instance.onAuthStateChanged.asBroadcastStream();
  Stream<FirebaseUser> get authStatus => _streamFirebsae;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  Stream myProfileDataOnline(String uid) => FirebaseDatabaseAPI().userRef.child(uid).onValue.asBroadcastStream();

  Future<User> getUser(String uid) => _database_repository.getUser(uid);
  Future<User> myProfileOnce(String uid) => _database_repository.myProfileOnce(uid);
  Stream myProfileOnce2(String uid) => _database_repository.myProfileOnce2(uid);
//  Stream streamUser = _database_repository.streamUser

  StreamController<UserLocation> _locationController = StreamController<UserLocation>.broadcast();

  Stream<UserLocation>  get locationStream => _locationController.stream;

  User buildUser(DataSnapshot snapShot) => _database_repository.buildUser(snapShot);

  Future<AuthResult> signIn({Key key,@required ProviderAuth providerAuth, String codeSms}) {
    return _auth_repository.signInFirebase(providerAuth: providerAuth,codeSms: codeSms);
  }


  Future<StorageUploadTask> uploadFile(String path, File file) => _storageRepository.uploadFile(path, file);


  Pedido get  nuevoPedido{
    return _nuevoPedido;
  }

  set nuevoPedido( Pedido nuevoPedido ){
    this._nuevoPedido = nuevoPedido;
  }


  UserLocation get myLocation{
    return _currentLocation;
  }

  UserBloc._internal(){
//    location.requestPermission().then((granted){
//
//      if(granted == PermissionStatus.granted){
//        location.onLocationChanged.listen((locationData) {
//          if(locationData != null){
//
//            _locationController.add(UserLocation(latitude: locationData.latitude, longitude: locationData.longitude));
//
//          }
//        });
//      }
//    });

//    geo.getPositionStream(forceAndroidLocationManager: true, desiredAccuracy: geo.LocationAccuracy.low, distanceFilter: 2).asBroadcastStream(
//        onListen: (dat){
//          dat.onData((posi) {
//            geoController.sink.add(posi);
//          });
//        }
//    );
    geo.getPositionStream(forceAndroidLocationManager: true, desiredAccuracy: geo.LocationAccuracy.low, distanceFilter: 2).asBroadcastStream().listen((posi) {
                  geoController.sink.add(posi);

    });



//    loaadSearchMapbox();
  }

  Future<UserLocation> getLocation() async{
    try{
      var userLocation = await location.getLocation();
      return _currentLocation = UserLocation(latitude: userLocation.latitude, longitude: userLocation.longitude);
    }catch(e){
      print("ocurrio un error al intentar obtener la ubicacion $e}");
      return null;
    }
  }

//  Future<void> loaadSearchMapbox() async {
//    String apiKey = "pk.eyJ1Ijoiam9zZXBoZXBpYSIsImEiOiJja2Vha2F3N3QwMWRwMzBwYjh3ZDllczQ4In0.Ygj_AikKyCebs2N51vcMHQ"; //Set up a test api key before running
//
//    await geoCoding(apiKey).catchError(print);
//    await placesSearch(apiKey).catchError(print);
//  }

  ///Reverse GeoCoding sample call
//  Future geoCoding(String apiKey) async {
//    var geoCodingService = mapboxSearch.ReverseGeoCoding(
//      apiKey: apiKey,
//      country: "BR",
//      limit: 5,
//    );
//
//    var addresses = await geoCodingService.getAddress(mapboxSearch.Location(
//      lat: -19.984846,
//      lng: -43.946852,
//    ));
//
//    print(addresses);
//  }

  ///Places search sample call
//  Future placesSearch(String apiKey) async {
//    var placesService = mapboxSearch.PlacesSearch(
//      apiKey: apiKey,
//      country: "BR",
//      limit: 5,
//    );
//
//    var places = await placesService.getPlaces(
//      "patio",
//      location: mapboxSearch.Location(
//        lat: -19.984634,
//        lng: -43.9502958,
//      ),
//    );
//
//    print(places);
//  }


  Future<List<mapboxSearch.MapBoxPlace>> getPlaces(String address){
    var placesSearch = mapboxSearch.PlacesSearch(
      apiKey: _apiKey,
      country: 'CO',
      language: 'es',


      limit: 5,
    );
      return placesSearch.getPlaces(address);
  }


  Future<User> getUser2(uid) async{


    return await FirebaseDatabaseAPI().userRef.orderByKey().equalTo(uid).limitToFirst(1).once().then((value) {
      print("datos de user -> ${value.value}");
    });
  }

  getStatus() async{
    var status = await FacebookLogin().isLoggedIn;

    print('estatus de login facebook -> ${status}');
  }

  signOut() async{
    await _auth_repository.singOut();
  }

  saveUser(User user) => _database_repository.saveUserFirebase(user);

  Future updateUser({User user, bool checkConductor}) => _database_repository.updateUserFirebase(user: user,checkConductor: checkConductor);
  lastLoginUser(User user) => _database_repository.lastLoginUserFirebase(user);
  Future sendVerificarionPhone(String phoneNumber) => _auth_repository.sendVerificarionPhone(phoneNumber);

  @override
  void dispose() {


//    this._locationController?.close();
    // TODO: implement dispose
  }

}