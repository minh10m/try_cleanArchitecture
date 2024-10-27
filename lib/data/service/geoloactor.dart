import 'package:geolocator/geolocator.dart';

Future <Position>  getLocation() async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied){
      return Future.error('location permission is denied');
    }
  }

  if (permission == LocationPermission.deniedForever){
    return Future.error('location permission is denied forever');
  }

  return await Geolocator.getCurrentPosition();
}