import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentValueCard extends StatelessWidget {
  
  const CurrentValueCard({
    super.key,
    this.date,
    this.height,
    this.up
  });

  final DateTime? date;
  final double? height;
  final bool? up;
  
  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    if (up == null) {
      icon = Icons.remove;
      color = Colors.grey;
    } else if (up ?? false) {
      icon = Icons.arrow_upward;
      color = Colors.green;
    } else {
      icon = Icons.arrow_downward;
      color = Colors.orange;
    }
    return Center(
      heightFactor: 1,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(icon, color: color),
              title: Text(height != null ? '${height}m' : '-', textAlign: TextAlign.center),
              titleTextStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
              subtitle: Text(date != null ? DateFormat('HH:mm').format(date!) : '-', textAlign: TextAlign.center),
              subtitleTextStyle: const TextStyle(fontSize: 20, color: Colors.blue),
            )
          ]
        ),
      )
    );
  }
}
