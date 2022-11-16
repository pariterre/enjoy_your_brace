import 'package:enhanced_containers/enhanced_containers.dart';

class DataPoint extends ItemSerializable {
  final DateTime date;
  final double value;

  DataPoint(this.value, {DateTime? date}) : date = date ?? DateTime.now();

  static DataPoint deserialize(map) {
    return DataPoint(map['value'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']));
  }

  @override
  Map<String, dynamic> serializedMap() {
    return {
      'date': date.millisecondsSinceEpoch ~/ 1000 ~/ 60,
      'value': value,
    };
  }
}
