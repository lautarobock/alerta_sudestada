import 'dart:convert';

import 'package:alerta_sudestada/src/all_values/all_values_dard.dart';
import 'package:alerta_sudestada/src/current_value/current_value_card.dart';
import 'package:alerta_sudestada/src/data.dart';
import 'package:alerta_sudestada/src/high_low_tide/high_low_tide_card.dart';
import 'package:alerta_sudestada/src/model.dart';
import 'package:alerta_sudestada/src/weather/weather_card.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class Response {
  final List<Tide> tides;

  Response({required this.tides});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        tides: (json['documents'] as List)
            .map((e) => Tide.fromJson(e))
            .toList());
  }

}

class ForecastValue {
  final DateTime date;
  final String mode;
  final double value;

  ForecastValue({required this.date, required this.mode, required this.value});

}

class Forecast {
  final DateTime moment;
  final List<ForecastValue> values;

  Forecast({required this.moment, required this.values});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final res = (json['documents'] as List)[0];
    return Forecast(
      moment: DateTime.parse(res['moment'].toString()).add(const Duration(hours: -3)),
      values: (res['values'] as List).map((e) => ForecastValue(
        date: DateTime.parse(e['date'].toString()).add(const Duration(hours: -3)),
        mode: e['mode'],
        value: (e['value'] as num).toDouble()
      )).toList()
    );
  }
}

class Tide {
  final String type;
  final double value;
  final DateTime moment;

  Tide({required this.type, required this.value, required this.moment});

  factory Tide.fromJson(Map<String, dynamic> json) {
    return Tide(
      type: json['type'],
      value: (json['value'] as num).toDouble(),
      moment: DateTime.parse(json['moment'].toString()).add(const Duration(hours: -3))
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  // static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Tide? last;
  bool? up;
  List<Tide>? readings;
  List<Tide>? astronomical;
  Forecast? forecast;
  OpenWeatherMapModel? weather;
  

  login() {
    return http.post(
        Uri.parse(
            'https://sa-east-1.aws.services.cloud.mongodb.com/api/client/v2.0/app/data-greykai/auth/providers/local-userpass/login'),
        body: {
          'username': 'alerta-sudestada-app',
          'password': 'SLJYAX7A2BkZmmhi'
        });
  }

  fetchTides(String token) {
    return http.post(
        Uri.parse(
            'https://sa-east-1.aws.data.mongodb-api.com/app/data-greykai/endpoint/data/v1/action/find'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Access-Control-Request-Headers': '*'
        },
        body: jsonEncode({
          'collection': 'tides',
          'database': 'alerta-sudestada',
          'dataSource': 'alerta-sudestada',
          'projection': {'type': 1, 'value': 1, 'moment': 1},
          // 'limit': 24
          'filter': {
            'moment': {
              '\$gte': {
                '\$date': {'\$numberLong': DateTime.now().add(const Duration(hours: -8)).millisecondsSinceEpoch.toString()} 
              }
            }
          }
        }));
  }

  fetchForecast(String token) {
    return http.post(
        Uri.parse(
            'https://sa-east-1.aws.data.mongodb-api.com/app/data-greykai/endpoint/data/v1/action/find'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Access-Control-Request-Headers': '*'
        },
        body: jsonEncode({
          'collection': 'forecast',
          'database': 'alerta-sudestada',
          'dataSource': 'alerta-sudestada',
          'projection': {'_id': 1, 'values': 1, 'moment': 1},
          'sort': {'moment': -1},
          'limit': 1
        }));
  }

  Future<void> loadData() async {
    setState(() {
      readings = null;
      astronomical = null;
      last = null;
      up = null;
      forecast = null;
      weather = null;
    });
    final loginResponse = await login();
    if (loginResponse.statusCode == 200) {
      final token = jsonDecode(loginResponse.body)['access_token'];
      final tidesResponse = await fetchTides(token);
      if (tidesResponse.statusCode == 200) {
        final forecastRes = await fetchForecast(token);
        if (forecastRes.statusCode == 200) {
          final res = Response.fromJson(jsonDecode(tidesResponse.body));
          final w = await WeatherDataService.getWeather();
          setState(() {
            readings = res.tides.where((element) => element.type == 'reading').toList();
            astronomical = res.tides.where((element) => element.type == 'astronomical').toList();
            last = readings?.last;
            up = readings != null ? readings!.last.value > readings![readings!.length - 2].value : null;
            forecast = Forecast.fromJson(jsonDecode(forecastRes.body));  
            weather = w;
          });  
        } else {
          throw Exception('Failed to load forecast');
        }
        
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to login');
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.waves),
          title: const Text('Alerta Sudestada!'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Recargar',
              onPressed: () {
                loadData();
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, '/settings');
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: loadData,
          color: Colors.white,
          backgroundColor: Colors.blue,
          child: Column(
            children: [
              CurrentValueCard(date: last?.moment, height: last?.value, up: up),
              HighLowTide(forecast: forecast),
              WeatherCard(data: weather),
              AllValuesCard(
                astronomical: astronomical ?? [],
                readings: readings ?? [],
              )
            ],
          )
        )
      );
  }

}
