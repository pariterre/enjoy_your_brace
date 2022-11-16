import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/devices/devices.dart';
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
            create: (ctx) => AllData(dataCollector: SimulatedDevice())),
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
