import 'package:flutter/material.dart';

import '../models/locale_text.dart';
import '../widgets/mood_pie.dart';
import '../widgets/mood_questionnaire.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);

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
