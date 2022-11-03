import 'location_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_clmx/services/weather.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationdata();
  }

  void getLocationdata() async {

    var weatherdata = await WeatherModel().getlocationweather();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather: weatherdata);
    }));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
