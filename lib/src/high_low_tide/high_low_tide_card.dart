import 'package:alerta_sudestada/src/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HighLowTide extends StatelessWidget {

  const HighLowTide({
    super.key,
    this.forecast,
  });

  final Forecast? forecast;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: (forecast?.values ?? []).map((val) => ListTile(
              title: Text('${_modeStr(val.mode)} ${val.value}m', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_formatDate(val.date)),
              leading: Icon(
                val.mode == 'high' ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                color: val.mode == 'high' ? Colors.green : Colors.orange
              )
            )
          ).toList()
        ),
      )
    );
  }

  _modeStr(String mode) {
    if (mode == 'high') {
      return 'Pleamar';
    } else {
      return 'Bajamar';
    }
  }

  _formatDate(DateTime date) {
    if (_isToday(date)) {
      return 'Hoy ${DateFormat('HH:mm').format(date)}';
    } else {
      return 'Mañana ${DateFormat('HH:mm').format(date)}';
    }    
  }

  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
