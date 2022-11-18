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
    emotion: MoodDataLevel.none,
    comfort: MoodDataLevel.none,
    humidity: MoodDataLevel.none,
    autonomy: MoodDataLevel.none,
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
    final moodList = MoodDataPointList.of(context);

    return Column(
      children: [
        if (moodList.isNotEmpty)
          Text('Dernier état :\n'
              '\t\t${texts.emotion} : ${moodList.last.emotion},\n'
              '\t\t${texts.comfort} : ${moodList.last.comfort},\n'
              '\t\t${texts.humidity} : ${moodList.last.humidity},\n'
              '\t\t${texts.autonony} : ${moodList.last.autonomy}'),
        if (moodList.isNotEmpty) const SizedBox(height: 10),
        SelectMoodLevel(
          title: texts.emotion,
          sideSize: sideSize,
          onTap: _setEmotion,
          current: mood.emotion,
        ),
        const SizedBox(height: 12),
        SelectMoodLevel(
          title: texts.comfort,
          sideSize: sideSize,
          onTap: _setComfort,
          current: mood.comfort,
        ),
        const SizedBox(height: 12),
        SelectMoodLevel(
          title: texts.humidity,
          sideSize: sideSize,
          onTap: _setHumidity,
          current: mood.humidity,
        ),
        const SizedBox(height: 12),
        SelectMoodLevel(
          title: texts.autonony,
          sideSize: sideSize,
          onTap: _setAutonomy,
          current: mood.autonomy,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            elevation: 2,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(texts.submit),
          ),
        ),
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
    required this.current,
  });

  final String title;
  final double sideSize;
  final Function onTap;
  final MoodDataLevel current;

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
              BoxDecoration(
                color: Colors.green.withAlpha(
                    widget.current == MoodDataLevel.excellent ? 255 : 50),
              ),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.excellent),
            ),
            _Selector(
              BoxDecoration(
                  color: Colors.teal.withAlpha(
                      widget.current == MoodDataLevel.good ? 255 : 50)),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.good),
            ),
            _Selector(
              BoxDecoration(
                  color: Colors.yellow.withAlpha(
                      widget.current == MoodDataLevel.medium ? 255 : 50)),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.medium),
            ),
            _Selector(
              BoxDecoration(
                  color: Colors.orange.withAlpha(
                      widget.current == MoodDataLevel.poor ? 255 : 50)),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.poor),
            ),
            _Selector(
              BoxDecoration(
                  color: Colors.red.withAlpha(
                      widget.current == MoodDataLevel.veryBad ? 255 : 50)),
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
