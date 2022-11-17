import 'package:enhanced_containers/enhanced_containers.dart';

enum MoodDataLevel {
  veryBad,
  poor,
  medium,
  good,
  excellent,
}

class MoodDataPoint extends ItemSerializable {
  final MoodDataLevel emotion;
  final MoodDataLevel confort;
  final MoodDataLevel humidity;
  final MoodDataLevel automony;

  MoodDataPoint(this.emotion, this.confort, this.humidity, this.automony);

  @override
  Map<String, dynamic> serializedMap() => {
        'emotion': emotion as int,
        'confort': confort as int,
        'humidity': humidity as int,
        'autonomy': automony as int,
      };
  MoodDataPoint.deserialize(map)
      : emotion = map['emotion'],
        confort = map['confort'],
        humidity = map['humidty'],
        automony = map['autonomy'];
}
