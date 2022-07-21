import 'package:flutter/material.dart';
import 'package:musicutils/Screens/Metronome.dart';

import 'Screens/Scales.dart';
import 'Screens/Settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.pinkAccent, brightness: Brightness.light),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.pinkAccent, brightness: Brightness.dark),
      ),

      home: Scales(),
      routes: {
        '/settings': (context) => Settings(),
        '/metronome': (context) => Metronome(),
      },
    );
  }
}
