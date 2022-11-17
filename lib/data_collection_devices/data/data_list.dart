import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enhanced_containers/enhanced_containers.dart';

import 'data_point.dart';
import '../devices/data_collection_device.dart';

class DataList extends ListProvided<DataPoint> {
  final DataCollectionDevice dataCollector;

  DataList({required this.dataCollector});

  static DataList of(BuildContext context, {bool listen = false}) =>
      Provider.of<DataList>(context, listen: listen);

  @override
  DataPoint deserializeItem(data) => throw UnimplementedError();

  ///
  /// Returns the wearing time (in hours) associated with each data points
  List<double> get wearingTime {
    final List<double> out = [];

    for (int i = 0; i < length - 1; i++) {
      out.add(this[i].isBraceOn
          ? this[i + 1].date.difference(this[i].date).inMinutes.toDouble() / 60
          : 0);
    }
    return out;
  }

  ///
  /// Returns the earliest point acquired (independent of the list order)
  DataPoint get earliest => reduce(
      (value, element) => element.date.isBefore(value.date) ? element : value);

  ///
  /// Returns the latest point acquired (independent of the list order)
  DataPoint get latest => reduce(
      (value, element) => element.date.isBefore(value.date) ? value : element);

  ///
  /// Returns the total wearing time (in hours) of the scoliosis brace
  double get totalWearingTime =>
      wearingTime.fold(0, (runningSum, e) => runningSum + e);

  ///
  /// Returns the mean wearing time per day of the scoliosis brace
  double get meanWearingTimePerDay =>
      totalWearingTime /
      (latest.date.difference(earliest.date).inHours.toDouble() / 24);
}
