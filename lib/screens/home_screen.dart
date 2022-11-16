import 'package:flutter/material.dart';

import '../models/devices/devices.dart';
import '../models/locale_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String route = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleText.of(context).title),
      ),
      body: const Center(child: Charting()),
    );
  }
}

class Charting extends StatelessWidget {
  const Charting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Data.of(context);
    final device = data.dataCollector as SimulatedDevice;
    if (!device.hasData) device.simulateData(context, 100);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 350,
      height: 300,
      child: data.drawGraph(),
    );
  }
}
