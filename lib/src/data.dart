import 'dart:convert';

import 'package:alerta_sudestada/src/model.dart';

import 'package:http/http.dart' as http;

class WeatherDataService {

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '0431882dbe2347a8347a181f08dfae1d';
  static const String _lang = 'es';
  static const String _units = 'metric';
  static const String _lat = '-34.426';
  static const String _lon = '-58.5796';

  static Future<OpenWeatherMapModel> getWeather() async {
    final response = await http.get(
      Uri.parse('$_baseUrl?APPID=$_apiKey&lang=$_lang&units=$_units&lat=$_lat&lon=$_lon'),
    );
    if (response.statusCode == 200) {
      return OpenWeatherMapModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

}