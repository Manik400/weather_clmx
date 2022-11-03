import 'package:weather_clmx/services/location.dart';
import 'package:weather_clmx/services/networking.dart';
const apikey = '24e647fafc4ea1ac6ca0f989d069f3c3';
const openweathermapurl  = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getcityweather(String cityname) async {
    var url = '$openweathermapurl?q=$cityname&appid=$apikey&units=metric';
    Networkhelper networkhelper = Networkhelper(url);
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }

  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getcurrentlocation();

    Networkhelper networkhelper = Networkhelper(
        '$openweathermapurl?lat=${location
            .latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
