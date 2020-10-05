


import 'dart:async';

import 'package:do_my/Usuario/model/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation _currentLocation;

  Location location = Location();
  StreamController<UserLocation> _locationController = StreamController<UserLocation>.broadcast();


  LocationService(){
    location.requestPermission().then((granted){
      if(granted == PermissionStatus.granted){
          location.onLocationChanged.listen((locationData) {
              if(locationData != null){
                _locationController.add(UserLocation(latitude: locationData.latitude, longitude: locationData.longitude));
              }
          });
      }
    });
  }

  Stream<UserLocation>  get locationStream => _locationController.stream;
  Future<UserLocation> getLocation() async{
    try{
      var userLocation = await location.getLocation();
      return _currentLocation = UserLocation(latitude: userLocation.latitude, longitude: userLocation.longitude);
    }catch(e){
      print("ocurrio un error al intentar obtener la ubicacion $e}");
      return null;
    }
  }
}