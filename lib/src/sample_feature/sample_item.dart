/// A placeholder class that represents an entity or model.
class SampleItem {
  const SampleItem(this.id);

  final int id;
}


class DataValue {
  final DateTime date;
  final double height;

  DataValue({required this.date, required this.height});
}

class Data {
  
  final String tideGauge;
  final List<DataValue> astronomical;
  final List<DataValue> readings;

  Data({required this.tideGauge, required this.astronomical, required this.readings});

  factory Data.fromJson(Map<String, dynamic> json) {
    List<DataValue> astronomical = [];
    List<DataValue> readings = [];

    for (var item in json['astronomica']) {
      astronomical.add(DataValue(date: DateTime.parse(item['fecha']), height: item['altura']));
    }

    for (var item in json['lecturas']) {
      readings.add(DataValue(date: DateTime.parse(item['fecha']), height: item['altura']));
    }

    return Data(
      tideGauge: json['mareografo'],
      astronomical: astronomical,
      readings: readings,
    );
  }
}
