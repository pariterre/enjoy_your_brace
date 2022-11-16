import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enhanced_containers/enhanced_containers.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';

import './data_collection_device.dart';

class DataPoint extends ItemSerializable {
  final DateTime date;
  final double value;

  DataPoint(this.value, {DateTime? date}) : date = date ?? DateTime.now();

  static DataPoint deserialize(map) {
    return DataPoint(map['value'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']));
  }

  @override
  Map<String, dynamic> serializedMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'value': value,
    };
  }
}

class Data extends ListProvided<DataPoint> {
  final DataCollectionDevice dataCollector;

  Data({required this.dataCollector});

  List<Map<dynamic, dynamic>> _toGraphData() {
    return map((element) => element.serializedMap()).toList();
  }

  Widget drawGraph() {
    return Chart(
      data: _toGraphData(),
      variables: {
        'date': Variable(
          accessor: (Map map) {
            return DateTime.fromMillisecondsSinceEpoch(map['date']);
          },
          scale: TimeScale(
              title: "Time",
              tickCount: 5,
              formatter: ((p0) => DateFormat('dd/MM').format(p0))),
        ),
        'value': Variable(
          accessor: (Map map) => map['value'] as num,
        ),
      },
      elements: [
        LineElement(
          position: Varset('date') * Varset('value'),
          shape: ShapeAttr(value: BasicLineShape(smooth: true)),
          size: SizeAttr(value: 1),
        ),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
    );
  }

  static Data of(BuildContext context, {bool listen = false}) =>
      Provider.of<Data>(context, listen: listen);
  @override
  DataPoint deserializeItem(data) => DataPoint.deserialize(data);
}
