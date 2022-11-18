import 'package:flutter/material.dart';

import '../mood_data_point.dart';
import '../mood_data_point_list.dart';
import '../../models/locale_text.dart';

class SelectMood extends StatefulWidget {
  const SelectMood({super.key, this.onSubmit});

  final Function(MoodDataPoint)? onSubmit;

  @override
  State<SelectMood> createState() => _SelectMoodState();
}

class _SelectMoodState extends State<SelectMood> {
  MoodDataPoint mood = MoodDataPoint();

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
    if (widget.onSubmit != null) widget.onSubmit!(mood);

    mood = MoodDataPoint();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sideSize = MediaQuery.of(context).size.width / 10;
    final texts = LocaleText.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(texts.feelingToday),
        const SizedBox(height: 20),
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
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: mood.allMoodsAreSelected ? _submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
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
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Selector(
              BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/excellent.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(
                        widget.current == MoodDataLevel.excellent ? 255 : 70),
                    BlendMode.modulate,
                  ),
                ),
              ),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.excellent),
            ),
            _Selector(
              BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/good.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(
                        widget.current == MoodDataLevel.good ? 255 : 70),
                    BlendMode.modulate,
                  ),
                ),
              ),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.good),
            ),
            _Selector(
              BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/medium.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(
                        widget.current == MoodDataLevel.medium ? 255 : 70),
                    BlendMode.modulate,
                  ),
                ),
              ),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.medium),
            ),
            _Selector(
              BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/poor.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(
                        widget.current == MoodDataLevel.poor ? 255 : 70),
                    BlendMode.modulate,
                  ),
                ),
              ),
              sideSize: widget.sideSize,
              onTap: () => widget.onTap(MoodDataLevel.poor),
            ),
            _Selector(
              BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/veryBad.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(
                        widget.current == MoodDataLevel.veryBad ? 255 : 70),
                    BlendMode.modulate,
                  ),
                ),
              ),
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
