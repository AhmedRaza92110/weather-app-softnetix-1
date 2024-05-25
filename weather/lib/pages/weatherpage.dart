import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';


class WeatherData {
  final String city;
  final double temperature;
  final String condition;

  WeatherData({required this.city, required this.temperature, required this.condition});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<StatefulWidget> {
  late WeatherData _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final response = await http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=4c622d9e4e794677af5172755242704&q=London&aqi=no'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _weatherData = WeatherData.fromJson(data);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(child: Text('Weather App',style: TextStyle(color: Colors.white),)),
      ),
      body:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'City: ${_weatherData.city}',
                    style: TextStyle(fontSize: 20),

                  ),
                  Lottie.asset('assets/animation.json'),
                  
                  Text(
                    'Temperature: ${_weatherData.temperature}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Condition: ${_weatherData.condition}',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ],
              ),
            ),
          // Center(
          //     child: CircularProgressIndicator(),
          //   ),
    );
  }
}
