import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator/geolocator.dart';

class Location{
  late double latitude;
  late double longitude;

  Future<void> getcurrentlocation() async {
    try{
      await Geolocator.openLocationSettings();
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;

    } catch(e){
      print(e);
    }
  }
}