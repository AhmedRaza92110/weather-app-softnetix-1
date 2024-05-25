import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/pages/weather_model.dart';


class weatherService{

  static const BASE_URL="http://api.weatherapi.com/v1/current.json?key=4c622d9e4e794677af5172755242704&q=London&aqi=no";
  final String apikeys;

  weatherService(this.apikeys);
  Future<weather> getweather(String cityname)async{
    final response=await http.get(Uri.parse('$BASE_URL?q=cityname&appid=$apikeys&units=metric'));

    if(response.statusCode==200){
      return weather.fromJson(jsonDecode(response.body));

    }else{
      throw Exception('failed ahmed');
    }

  }
    


    
}