import 'package:flutter/material.dart';

import '../models/devices/devices.dart';
import '../models/locale_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final data = AllData.of(context);
    final device = data.dataCollector as SimulatedDevice;
    if (!device.hasData) device.simulateData(context, 12 * 30);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleText.of(context).title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: GraphData(
              title: Text(LocaleText.of(context).temperature),
              width: 350,
              height: 300),
        ),
      ),
    );
  }
}
