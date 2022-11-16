import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enhanced_containers/enhanced_containers.dart';

import './data_collection_device.dart';
import './data_point.dart';

class AllData extends ListProvided<DataPoint> {
  final DataCollectionDevice dataCollector;

  AllData({required this.dataCollector});

  static AllData of(BuildContext context, {bool listen = false}) =>
      Provider.of<AllData>(context, listen: listen);
  @override
  DataPoint deserializeItem(data) => DataPoint.deserialize(data);
}
