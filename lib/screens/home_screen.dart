import 'package:flutter/material.dart';

import '../data_collection_devices/data_collection_devices.dart';
import '../models/locale_text.dart';
import '../mood_data/widgets/select_mood.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final data = DataList.of(context);
    (data.dataCollector as SimulatedTemperatureDevice)
        .simulateData(24 * 30, dataList: data);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleText.of(context).title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GraphData(
                title: Text(LocaleText.of(context).temperature), height: 300),
            const SizedBox(height: 15),
            Text(
              '${LocaleText.of(context).totalWearingTime} '
              '${data.totalWearingTime.toStringAsFixed(1)}h '
              '(${LocaleText.of(context).mean} '
              '${data.meanWearingTimePerDay.toStringAsFixed(1)}h/${LocaleText.of(context).day})',
            ),
            const SizedBox(height: 50),
            const SelectMood(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
