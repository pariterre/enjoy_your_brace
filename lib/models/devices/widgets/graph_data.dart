import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';

import '../all_data.dart';

class GraphData extends StatelessWidget {
  const GraphData({
    super.key,
    required this.width,
    required this.height,
    this.title,
  });

  final Widget? title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) title!,
        SizedBox(
          width: width,
          height: height,
          child: Chart(
            data: AllData.of(context)
                .map((element) => element.serializedMap())
                .toList(),
            variables: {
              'x': Variable(
                accessor: (Map map) {
                  return DateTime.fromMillisecondsSinceEpoch(
                      map['date'] * 1000 * 60);
                },
                scale: TimeScale(
                    tickCount: 5,
                    formatter: ((p0) => DateFormat('dd/MM').format(p0))),
              ),
              'y': Variable(
                accessor: (Map map) => map['value'] as num,
              ),
            },
            elements: [
              LineElement(
                position: Varset('x') * Varset('y'),
                shape: ShapeAttr(value: BasicLineShape(smooth: true)),
                size: SizeAttr(value: 1),
              ),
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
          ),
        ),
      ],
    );
  }
}
