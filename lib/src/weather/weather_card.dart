import 'package:alerta_sudestada/src/model.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    this.data
  });

  final OpenWeatherMapModel? data;

  @override
  Widget build(BuildContext context) {
    
    return Center(
      heightFactor: 1,
      child: Card(
        color: Colors.lightBlue[50],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: data == null ? [] : [
            ListTile(
              title: Text('${data?.main.temp.round()}°C Viento ${_windDirection(data?.wind.deg)} ${data?.wind.speed.round()}km/h ${data?.weather.first.description}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('ST: ${data?.main.feelsLike.round()}°C | Nubosidad ${data?.clouds.all}% | Humedad ${data?.main.humidity}% | Presión ${data?.main.pressure} hPa | Visibilidad ${(data?.visibility ?? 0) / 1000.0}Km'),
              leading: Image.network('https://openweathermap.org/img/wn/${data?.weather.first.icon}.png')
            ),
            ListTile(
              title: Text('${data?.main.temp.round()}°C Viento ${_windDirection(data?.wind.deg)} ${data?.wind.speed.round()}km/h ${data?.weather.first.description}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('ST: ${data?.main.feelsLike.round()}°C | Nubosidad ${data?.clouds.all}% | Humedad ${data?.main.humidity}% | Presión ${data?.main.pressure} hPa | Visibilidad ${(data?.visibility ?? 0) / 1000.0}Km'),
              leading: Image.network('https://openweathermap.org/img/wn/${data?.weather.first.icon}.png')
            )
          ]
        ),
      )
    );
  }

  String _windDirection(int? degrees) {
    // List of directions corresponding to the wind degrees
    List<String> directions = [
      'N',
      'NNE',
      'NE',
      'ENE',
      'E',
      'ESE',
      'SE',
      'SSE',
      'S',
      'SSO',
      'SO',
      'OSO',
      'O',
      'OO',
      'NO',
      'NNO'
    ];

    // Calculate the index by normalizing the degrees and dividing by the slice angle (360/16)
    if (degrees == null) {
      return '';
    } else {
      int index = ((degrees + 11.25) / 22.5).floor() % 16;
      // Return the direction
      return directions[index];
    }
  }
}
