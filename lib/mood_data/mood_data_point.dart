import 'package:enhanced_containers/enhanced_containers.dart';

enum MoodDataLevel {
  none,
  veryBad,
  poor,
  medium,
  good,
  excellent,
}

class MoodDataPoint extends ItemSerializable {
  final MoodDataLevel emotion;
  final MoodDataLevel comfort;
  final MoodDataLevel humidity;
  final MoodDataLevel autonomy;

  MoodDataPoint({
    this.emotion = MoodDataLevel.none,
    this.comfort = MoodDataLevel.none,
    this.humidity = MoodDataLevel.none,
    this.autonomy = MoodDataLevel.none,
  });

  MoodDataPoint copyWith(
      {MoodDataLevel? emotion,
      MoodDataLevel? comfort,
      MoodDataLevel? humidity,
      MoodDataLevel? autonomy}) {
    return MoodDataPoint(
      emotion: emotion ?? this.emotion,
      comfort: comfort ?? this.comfort,
      humidity: humidity ?? this.humidity,
      autonomy: autonomy ?? this.autonomy,
    );
  }

  @override
  Map<String, dynamic> serializedMap() => {
        'emotion': emotion.index,
        'comfort': comfort.index,
        'humidity': humidity.index,
        'autonomy': autonomy.index,
      };
  MoodDataPoint.deserialize(map)
      : emotion = MoodDataLevel.values[['emotion'] as int],
        comfort = MoodDataLevel.values[map['comfort'] as int],
        humidity = MoodDataLevel.values[map['humidty'] as int],
        autonomy = MoodDataLevel.values[map['autonomy'] as int];

  bool get allMoodsAreSelected {
    return emotion != MoodDataLevel.none &&
        comfort != MoodDataLevel.none &&
        humidity != MoodDataLevel.none &&
        autonomy != MoodDataLevel.none;
  }

  @override
  String toString() =>
      'Emotion: $emotion, Comfort: $comfort, Humidity: $humidity, Autonony: $autonomy';
}
