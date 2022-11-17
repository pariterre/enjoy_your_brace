import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_collection_devices/data_collection_devices.dart';
import './models/locale_text.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocaleText(language: 'fr')),
        ChangeNotifierProvider(
            create: (ctx) => DataList(
                dataCollector: SimulatedTemperatureDevice(frequency: 2))),
      ],
      child: MaterialApp(
        initialRoute: HomeScreen.route,
        routes: {
          HomeScreen.route: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
