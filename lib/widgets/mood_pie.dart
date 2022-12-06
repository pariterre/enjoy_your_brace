import 'dart:math';

import 'package:flutter/material.dart';

import 'pie.dart';
import '../data_collection_devices/data/data_list.dart';
import '../models/locale_text.dart';

class MoodPie extends StatelessWidget {
  const MoodPie({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final data = DataList.of(context, listen: true);
    data.dataCollector.fetchData(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.purple),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Transform.rotate(
            angle: -pi / 20,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  texts.meanWearingTime,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Pie(
            radius: 100,
            sweepAngle: pi,
            colors: const [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
            ],
            targetAngle: data.meanWearingTimePerDay / 24,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${data.meanWearingTimePerDay.toStringAsFixed(1)}h/${texts.day}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
