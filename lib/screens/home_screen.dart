import 'package:flutter/material.dart';

import '../data_collection_devices/data_collection_devices.dart';
import '../models/locale_text.dart';
import '../widgets/mood_pie.dart';
import '../widgets/mood_questionnaire.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final data = DataList.of(context);
    (data.dataCollector as SimulatedTemperatureDevice)
        .simulateData(24 * 30, dataList: data);

    return Scaffold(
      appBar: AppBar(
        title: Text(texts.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              MoodPie(),
              MoodQuestionnaire(),
            ],
          ),
        ),
      ),
    );
  }
}
