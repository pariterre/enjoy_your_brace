import 'dart:math';

import 'package:flutter/material.dart';

import '../data/data_list.dart';
import '../data/temperature_data_point.dart';
import 'data_collection_device.dart';

class SimulatedTemperatureDevice extends DataCollectionDevice {
  bool hasData = false;
  final randomizer = Random(42);

  SimulatedTemperatureDevice({
    required super.frequency,
    this.variability = 2,
    this.numberOfSimulatedHours = 100,
  });
  final double variability;
  final int numberOfSimulatedHours;

  void simulateData(DataList dataList, {double offset = 0}) {
    final firstTimeStamp = DateTime.now().subtract(Duration(
        minutes: numberOfSimulatedHours * frequency + 1 * (60 ~/ frequency)));
    var runningTemperature = 25.0;
    for (int i = 0; i < numberOfSimulatedHours * frequency + 1; i++) {
      final timeStamp =
          firstTimeStamp.add(Duration(minutes: i * (60 ~/ frequency)));
      dataList.add(TemperatureDataPoint(runningTemperature, date: timeStamp),
          notify: false);
      runningTemperature +=
          randomizer.nextDouble() * variability - (variability / 2) + offset;
    }
  }

  @override
  Future<bool> fetchData(BuildContext context, {notify = false}) async {
    if (data(context, listen: false).isNotEmpty) return true;

    final dataList = data(context)..clear(notify: false);
    simulateData(dataList);

    return true;
  }
}
