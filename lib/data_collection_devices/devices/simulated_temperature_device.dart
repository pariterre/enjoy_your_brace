import 'dart:math';

import 'package:flutter/material.dart';

import 'data_collection_device.dart';
import '../data/data_list.dart';
import '../data/temperature_data_point.dart';

class SimulatedTemperatureDevice extends DataCollectionDevice {
  bool hasData = false;
  final randomizer = Random(42);

  SimulatedTemperatureDevice({
    required super.frequency,
    this.variability = 2,
    this.offset = 0,
  });
  final double variability;
  final double offset;

  void simulateData(
    BuildContext? context,
    int numberOfHours, {
    DataList? dataList,
  }) {
    dataList = dataList ?? data(context!);
    dataList.clear(notify: false);

    for (int i = 0; i < numberOfHours * frequency + 1; i++) {
      fetchNewDataPoint(context, dataList: dataList);
    }
    hasData = true;
  }

  @override
  Future<bool> fetchNewDataPoint(BuildContext? context,
      {notify = false, DataList? dataList}) async {
    dataList = dataList ?? data(context!);
    if (dataList.isEmpty) {
      dataList.add(TemperatureDataPoint(25, date: DateTime.now()),
          notify: notify);
    } else {
      dataList.add(
          TemperatureDataPoint(
              dataList.last.value +
                  randomizer.nextDouble() * variability -
                  (variability / 2) +
                  offset,
              date: dataList.last.date.add(Duration(minutes: 60 ~/ frequency))),
          notify: notify);
    }
    return true;
  }
}
