import 'package:weather_clmx/services/weather.dart';
import 'package:weather_clmx/screen/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_clmx/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel =WeatherModel();
  late int temp;
  late String weathericon;
  late String weathermessage;
  late String ctnm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateui(widget.locationweather);
  }
  void updateui(dynamic weatherData){
    setState(() {
      if(weatherData == null){
        temp = 0;
        weathericon = 'Error';
        weathermessage = 'Unable to get weather data';
        ctnm = '';
        return;
      }
    });
    double t= weatherData['main']['temp'];
    temp = t.toInt();
    var condition = weatherData['weather'][0]['id'];
    weathericon =weatherModel.getWeatherIcon(condition);
    weathermessage = weatherModel.getMessage(temp);
    ctnm = weatherData['name'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weatherModel.getlocationweather();
                      updateui(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if(typedname != Null){
                        var weatherdata = await weatherModel.getcityweather(typedname);
                        updateui(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weathermessage in $ctnm!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

