import 'package:alerta_sudestada/src/current_value/current_value_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  // static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alturas Horarias del mareógrafo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: CurrentValueCard(date: DateTime.parse('2024-01-01'), height: 10.3),
    );
  }
}