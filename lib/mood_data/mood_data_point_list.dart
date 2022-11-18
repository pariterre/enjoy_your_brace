import 'package:enhanced_containers/enhanced_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mood_data_point.dart';

class MoodDataPointList extends ListProvided<MoodDataPoint> {
  @override
  MoodDataPoint deserializeItem(data) => MoodDataPoint.deserialize(data);

  static MoodDataPointList of(BuildContext context, {listen = true}) =>
      Provider.of(context, listen: listen);
}
