import 'dart:math';

import 'package:flutter/material.dart';

import './data.dart';
import './data_collection_device.dart';

class SimulatedDevice extends DataCollectionDevice {
  bool hasData = false;

  // Randomize temperature values
  final randomizer = Random(42);

  void simulateData(BuildContext context, int numberOfMeasures) {
    for (int i = 0; i < numberOfMeasures; i++) {
      fetchNewDataPoint(context);
    }
    hasData = true;
  }

  @override
  Future<bool> fetchNewDataPoint(BuildContext context, {notify = false}) async {
    final dataProvided = data(context);
    if (dataProvided.isEmpty) {
      dataProvided.add(DataPoint(25, date: DateTime.now()), notify: notify);
    } else {
      dataProvided.add(
          DataPoint(dataProvided.last.value + randomizer.nextDouble() * 2 - 1,
              date: dataProvided.last.date.add(const Duration(hours: 12))),
          notify: notify);
    }
    return true;
  }
}
