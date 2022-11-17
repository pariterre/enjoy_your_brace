import 'package:enhanced_containers/enhanced_containers.dart';

import 'mood_data_point.dart';

class MoodDataPointList extends ListProvided<MoodDataPoint> {
  @override
  MoodDataPoint deserializeItem(data) => MoodDataPoint.deserialize(data);
}
