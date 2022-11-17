import 'dart:math';

import 'package:flutter/material.dart';

import 'data_collection_device.dart';
import '../data/temperature_data_point.dart';

class SimulatedTemperatureDevice extends DataCollectionDevice {
  bool hasData = false;
  final randomizer = Random(42);

  SimulatedTemperatureDevice(super.frequency);

  void simulateData(BuildContext context, int numberOfHours) {
    data(context).clear(notify: false);

    for (int i = 0; i < numberOfHours * frequency; i++) {
      fetchNewDataPoint(context);
    }
    hasData = true;
    final dataProvided = data(context);
  }

  @override
  Future<bool> fetchNewDataPoint(BuildContext context, {notify = false}) async {
    final dataProvided = data(context);
    if (dataProvided.isEmpty) {
      dataProvided.add(TemperatureDataPoint(25, date: DateTime.now()),
          notify: notify);
    } else {
      dataProvided.add(
          TemperatureDataPoint(
              dataProvided.last.value + randomizer.nextDouble() * 2,
              date: dataProvided.last.date
                  .add(Duration(minutes: 60 ~/ frequency))),
          notify: notify);
    }
    return true;
  }
}
