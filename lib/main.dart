import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_collection_devices/data_collection_devices.dart';
import 'models/locale_text.dart';
import 'models/theme.dart';
import 'mood_data/mood_data.dart';
import 'screens/home_screen.dart';

void main() {
  // The build is associated with a specific device device
  final dataCollector = SimulatedTemperatureDevice(frequency: 2);
  final data = DataList(dataCollector: dataCollector);

  runApp(MyApp(dataProvided: data, dataCollector: dataCollector));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.dataProvided, required this.dataCollector});

  final DataList dataProvided;
  final DataCollectionDevice dataCollector;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocaleText(language: 'fr')),
        ChangeNotifierProvider(create: (ctx) => dataProvided),
        ChangeNotifierProvider(create: (ctx) => MoodDataPointList()),
      ],
      child: MaterialApp(
        initialRoute: HomeScreen.route,
        theme: enjoyYourBraceTheme,
        routes: {
          HomeScreen.route: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
