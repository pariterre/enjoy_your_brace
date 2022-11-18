import 'package:enjoy_your_brace/mood_data/mood_data_point.dart';
import 'package:flutter/material.dart';

import '../data_collection_devices/data_collection_devices.dart';
import '../models/locale_text.dart';
import '../mood_data/widgets/select_mood.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home-screen';

  void _submitMood(context, MoodDataPoint mood) {
    Navigator.of(context).pop();
    debugPrint(mood.toString());
  }

  void _selectMood(context) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
                content: SelectMood(
              onSubmit: (mood) => _submitMood(context, mood),
            ))));
  }

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
        child: Column(
          children: [
            GraphData(title: Text(texts.temperature), height: 300),
            const SizedBox(height: 15),
            Text(
              '${texts.totalWearingTime} '
              '${data.totalWearingTime.toStringAsFixed(1)}h '
              '(${texts.mean} '
              '${data.meanWearingTimePerDay.toStringAsFixed(1)}h/${texts.day})',
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () => _selectMood(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary),
                child: Text(texts.selectMood)),
          ],
        ),
      ),
    );
  }
}
