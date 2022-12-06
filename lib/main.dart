import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_collection_devices/data_collection_devices.dart';
import 'models/locale_text.dart';
import 'models/theme.dart';
import 'mood_data/mood_data.dart';
import 'screens/home_screen.dart';

DataCollectionDevice prepareDevice(type) {
  if (type == 'blue_maestro') {
    return BlueMaestroDevice(useMock: true, numberOfSimulatedHours: 100);
  } else if (type == 'simulated') {
    return SimulatedTemperatureDevice(
        frequency: 2, numberOfSimulatedHours: 100);
  } else {
    throw 'Unrecognized device';
  }
}

void main() {
  // The build is associated with a specific device device
  final data = DataList(dataCollector: prepareDevice('blue_maestro'));

  runApp(MyApp(dataProvided: data));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.dataProvided});

  final DataList dataProvided;

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
