import 'package:enjoy_your_brace/models/locale_text.dart';
import 'package:enjoy_your_brace/mood_data/mood_data_point.dart';
import 'package:enjoy_your_brace/mood_data/mood_data_point_list.dart';
import 'package:flutter/material.dart';

class SelectMood extends StatefulWidget {
  const SelectMood({super.key});

  @override
  State<SelectMood> createState() => _SelectMoodState();
}

class _SelectMoodState extends State<SelectMood> {
  MoodDataPoint mood = MoodDataPoint(
    emotion: MoodDataLevel.medium,
    comfort: MoodDataLevel.medium,
    humidity: MoodDataLevel.medium,
    autonomy: MoodDataLevel.medium,
  );

  void _setEmotion(MoodDataLevel level) {
    mood = mood.copyWith(emotion: level);
    setState(() {});
  }

  void _setComfort(MoodDataLevel level) {
    mood = mood.copyWith(comfort: level);
    setState(() {});
  }

  void _setHumidity(MoodDataLevel level) {
    mood = mood.copyWith(humidity: level);
    setState(() {});
  }

  void _setAutonomy(MoodDataLevel level) {
    mood = mood.copyWith(autonomy: level);
    setState(() {});
  }

  void _submit() {
    MoodDataPointList.of(context, listen: false).add(mood);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sideSize = MediaQuery.of(context).size.width / 6;
    final texts = LocaleText.of(context);
    final currentMood = MoodDataPointList.of(context);

    return Column(
      children: [
        SelectMoodLevel(
            title: texts.emotion, sideSize: sideSize, onTap: _setEmotion),
        const SizedBox(height: 12),
        SelectMoodLevel(
            title: texts.comfort, sideSize: sideSize, onTap: _setComfort),
        const SizedBox(height: 12),
        SelectMoodLevel(
            title: texts.humidity, sideSize: sideSize, onTap: _setHumidity),
        const SizedBox(height: 12),
        SelectMoodLevel(
            title: texts.autonony, sideSize: sideSize, onTap: _setAutonomy),
        const SizedBox(height: 15),
        ElevatedButton(onPressed: _submit, child: Text(texts.submit)),
        if (currentMood.isNotEmpty)
          Text('État actuel :\n'
              '\t\t${texts.emotion} : ${currentMood.last.emotion},\n'
              '\t\t${texts.comfort} : ${currentMood.last.comfort},\n'
              '\t\t${texts.humidity} : ${currentMood.last.humidity},\n'
              '\t\t${texts.autonony} : ${currentMood.last.autonomy}'),
      ],
    );
  }
}

class SelectMoodLevel extends StatefulWidget {
  const SelectMoodLevel({
    super.key,
    required this.title,
    required this.sideSize,
    required this.onTap,
  });

  final String title;
  final double sideSize;
  final Function onTap;

  @override
  State<SelectMoodLevel> createState() => _SelectMoodLevelState();
}

class _SelectMoodLevelState extends State<SelectMoodLevel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Selector(
              const BoxDecoration(color: Colors.green),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.excellent),
            ),
            _Selector(
              const BoxDecoration(color: Colors.teal),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.good),
            ),
            _Selector(
              const BoxDecoration(color: Colors.yellow),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.medium),
            ),
            _Selector(
              const BoxDecoration(color: Colors.orange),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.poor),
            ),
            _Selector(
              const BoxDecoration(color: Colors.red),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.veryBad),
            ),
          ],
        ),
      ],
    );
  }
}

class _Selector extends StatelessWidget {
  const _Selector(
    this.boxDecoration, {
    Key? key,
    required this.sideSize,
    required this.onTap,
  }) : super(key: key);

  final double sideSize;
  final BoxDecoration boxDecoration;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: boxDecoration,
        height: sideSize,
        width: sideSize,
      ),
    );
  }
}
