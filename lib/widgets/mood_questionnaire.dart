import 'dart:math';

import 'package:flutter/material.dart';

import '../models/locale_text.dart';
import '../mood_data/mood_data.dart';

class MoodQuestionnaire extends StatelessWidget {
  const MoodQuestionnaire({super.key});

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
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.orange),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Transform.rotate(
            angle: pi / 25,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  texts.tellUsNowYouFeel,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => _selectMood(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary),
              child: Text(texts.selectMood)),
        ],
      ),
    );
  }
}
