import 'package:flutter/cupertino.dart';
import './data.dart';

abstract class DataCollectionDevice {
  const DataCollectionDevice();

  Data data(BuildContext context, {bool listen = false}) =>
      Data.of(context, listen: listen);

  ///
  /// This method fetches a new data point to the device, adds it to the data
  /// list and returns if it was a success or not.
  Future<bool> fetchNewDataPoint(BuildContext context, {notify = false});
}
