import 'package:flutter/material.dart';

import '../data/data_list.dart';

abstract class DataCollectionDevice {
  const DataCollectionDevice(this.frequency);

  DataList data(BuildContext context, {bool listen = false}) =>
      DataList.of(context, listen: listen);

  ///
  /// Data acquisition frequency in data per hour
  final double frequency;

  ///
  /// This method fetches a new data point to the device, adds it to the data
  /// list and returns if it was a success or not.
  Future<bool> fetchNewDataPoint(BuildContext context, {notify = false});
}
