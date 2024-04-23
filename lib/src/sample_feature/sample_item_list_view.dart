import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  
  SampleItemListView({
    super.key
  });

  static const routeName = '/';

  final List<DataValue> items = [DataValue(date: DateTime.parse('2024-01-01'), height: 10.1)];

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
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.waves),
                title: Text('Altura 5m'),
                subtitle: Text('10am'),
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
        ),
      )

      // ListView.builder(
      //   // Providing a restorationId allows the ListView to restore the
      //   // scroll position when a user leaves and returns to the app after it
      //   // has been killed while running in the background.
      //   restorationId: 'sampleItemListView',
      //   itemCount: items.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final item = items[index];

      //     return ListTile(
      //       title: Text('Altura ${item.height}'),
      //       leading: const CircleAvatar(
      //         // Display the Flutter Logo image asset.
      //         foregroundImage: AssetImage('assets/images/flutter_logo.png'),
      //       ),
      //       onTap: () {
      //         // Navigate to the details page. If the user leaves and returns to
      //         // the app after it has been killed while running in the
      //         // background, the navigation stack is restored.
      //         Navigator.restorablePushNamed(
      //           context,
      //           SampleItemDetailsView.routeName,
      //         );
      //       }
      //     );
      //   },
      // ),
    );
  }
}
