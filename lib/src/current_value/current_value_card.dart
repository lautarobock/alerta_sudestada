import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class CurrentValueCard extends StatefulWidget {

  const CurrentValueCard({
    super.key,
    required this.date,
    required this.height,
  });

  final DateTime date;
  final double height;
  
  @override
  State<CurrentValueCard> createState() => _CurrentValueCardState();
}

class _CurrentValueCardState extends State<CurrentValueCard> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.waves),
            title: Text('Altura ${widget.height}m'),
            subtitle: Text('${widget.date.hour}:${widget.date.minute}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    ));
  }
}
