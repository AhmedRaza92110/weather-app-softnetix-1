import 'package:flutter/material.dart';

class weather{
  final String cityname;
  final double temperature;
  final String condtion;

  weather({
    required this.cityname,
    required this.condtion,
    required this.temperature,
  });

  factory weather.fromJson(Map<String,dynamic> json){
    return weather(
      cityname: json['name'],
      condtion: json['main']['temp'].toDouble(), 
      temperature: json['weather'][0]['main']);

  }


}