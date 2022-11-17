import 'package:flutter/material.dart';

import '../data_collection_devices/data_collection_devices.dart';
import '../models/locale_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final data = DataList.of(context);
    final device = data.dataCollector as SimulatedTemperatureDevice;
    device.simulateData(context, 24 * 30);

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
          ],
        ),
      ),
    );
  }
}
