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
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.pink,
        accentColor: Colors.pinkAccent,
        brightness: Brightness.dark,
      ),
      home: Scales(),
      routes: {
        '/settings': (context) => Settings(),
        '/metronome': (context) => Metronome(),
      },
    );
  }
}
