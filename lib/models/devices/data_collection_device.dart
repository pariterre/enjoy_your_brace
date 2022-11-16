import 'package:flutter/material.dart';

import './all_data.dart';

abstract class DataCollectionDevice {
  const DataCollectionDevice();

  AllData data(BuildContext context, {bool listen = false}) =>
      AllData.of(context, listen: listen);

  ///
  /// This method fetches a new data point to the device, adds it to the data
  /// list and returns if it was a success or not.
  Future<bool> fetchNewDataPoint(BuildContext context, {notify = false});
}
