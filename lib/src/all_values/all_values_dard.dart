import 'package:alerta_sudestada/src/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Model {
  final double? reading;
  final double astronomical;
  final DateTime moment;

  Model({required this.moment, required this.astronomical, this.reading});
}

class AllValuesCard extends StatelessWidget {
  const AllValuesCard({super.key, required this.astronomical, required this.readings});

  final List<Tide> astronomical;
  final List<Tide> readings;

  @override
  Widget build(BuildContext context) {
    final List<Model> tides = astronomical.map((e) => Model(
      moment: e.moment,
      astronomical: e.value,
      reading: readings.where((element) => element.moment == e.moment).isEmpty ? null : readings.firstWhere((element) => element.moment == e.moment).value
    )).toList();


    return Expanded(child: Card(child:  ListView.builder(
      restorationId: 'allValuesList',
      itemCount: tides.length,
      itemBuilder: (BuildContext context, int index) {
        final item = tides[index];
        var text = '${_formatDate(item.moment)} - ${item.astronomical}m';
        if (item.reading != null) {
          text += ' [${item.reading}m]';
        }
        IconData? icon;
        Color color;
        if (index == 0) {
          icon = null;
          color = Colors.grey;
        } else if (item.astronomical > (tides[index - 1].astronomical)) {
          icon = Icons.arrow_upward;
          color = Colors.green;
        } else if (item.astronomical < (tides[index - 1].astronomical)) {
          icon = Icons.arrow_downward;
          color = Colors.orange;
        } else {
          icon = Icons.remove;
          color = Colors.grey;
        }
        return ListTile(
          title: Text(text),
          leading: Icon(icon, color: color),
        );
      },
    )));
  }

  _formatDate(DateTime date) {
    if (_isToday(date)) {
      return 'Hoy ${DateFormat('HH:mm').format(date)}';
    } else if (date.isAfter(DateTime.now())){
      return 'Mañana ${DateFormat('HH:mm').format(date)}';
    } else if (date.isBefore(DateTime.now())){
      return 'Ayer ${DateFormat('HH:mm').format(date)}';
    }    
  }

  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
