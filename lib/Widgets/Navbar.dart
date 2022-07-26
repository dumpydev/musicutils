// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  var index;

  Navbar({Key? key, required this.index}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.timer), label: "Metronome"),
        NavigationDestination(icon: Icon(Icons.music_note), label: "Scales"),
        NavigationDestination(icon: Icon(Icons.timer_3), label: "Stopwatch"),
        NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
      ],
      onDestinationSelected: (int index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/metronome');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/settings');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/stopwatch');
        }
      },
      selectedIndex: widget.index,
      height: MediaQuery.of(context).size.height * 0.08,
    );
  }
}
