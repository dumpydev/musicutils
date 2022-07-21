// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:musicutils/Widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class Metronome extends StatefulWidget {
  const Metronome({Key? key}) : super(key: key);

  @override
  State<Metronome> createState() => _MetronomeState();
}

class _MetronomeState extends State<Metronome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text('Metronome',
              style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ))),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        ]),
      ),
      bottomNavigationBar: Navbar(index: 0),
    );
  }
}
