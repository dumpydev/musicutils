import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/Navbar.dart';

class Scales extends StatefulWidget {
  const Scales({Key? key}) : super(key: key);

  @override
  State<Scales> createState() => _ScalesState();
}

class _ScalesState extends State<Scales> {
  @override
  void initState() {
    super.initState();
    generateScale();
  }

  Future<void> reset() async {
    setState(() {
      scalesplayedlist = [];
      scalesplayed = 0;
      scalestodo = 20;
    });
    generateScale();
  }

  Future<void> check() async {
    if (scalesplayed >= scalestodo) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Congratulations!'),
              content: Text(
                  'You have completed the scales! The scales you have played were\n${scalesplayedlist.map((e) => e.toString()).join(',\n')}.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      reset();
    }
  }

  Future<void> toggleHint() async {
    setState(() {
      if (showhint) {
        showhint = false;
      } else {
        showhint = true;
      }
    });
  }

  bool showhint = false;
  String hint = "";
  String scalename = "";
  int scalesplayed = 0;
  int scalestodo = 20;
  List scalesplayedlist = [];
  List scalesWithHints = [
    {'scale': 'C Major', 'hint': 'Nothing in key signature.'},
    {'scale': 'A Harmonic Minor', 'hint': 'Raised 7th (G♯) up&down.'},
    {
      'scale': 'A Melodic Minor',
      'hint': 'Raised 6th and 7th (F♯ and G♯) up only.'
    },
    {'scale': 'G Major', 'hint': 'F♯ in key signature'},
    {
      'scale': 'E Harmonic Minor',
      'hint': 'F♯ in key signature. Raised 7th (D♯) up&down.'
    },
    {
      'scale': 'E Melodic Minor',
      'hint': 'F♯ in key signature. Raised 6th and 7th (C♯ and D♯) up only.'
    },
    {'scale': 'F Major', 'hint': 'B♭ in key signature.'},
    {
      'scale': 'D Harmonic Minor',
      'hint': 'B♭ in key signature. Raised 7th (C♯) up&down.'
    },
    {
      'scale': 'D Melodic Minor',
      'hint': 'B♭ in key signature. Raised 6th and 7th (B♮, C♯)'
    },
    {'scale': 'D Major', 'hint': 'F♯ and C♯ in key signature.'},
    {
      'scale': 'B Harmonic Minor',
      'hint': 'F♯ and C♯ in key signature. Raised 7th (A♯) up&down.'
    },
    {'scale': 'B♭ Major', 'hint': 'B♭ and E♭ in key signature.'},
    {
      'scale': 'G Harmonic Minor',
      'hint': 'B♭ and E♭ in key signature. Raised 7th (F♯) up&down'
    },
    {'scale': 'Blues', 'hint': 'E♭ F♯ B♭ C♯'},
    {'scale': 'Chromatic', 'hint': 'Nothing in key signature'},
  ];

  Future<String> generateScale() async {
    var scale = scalesWithHints[Random().nextInt(scalesWithHints.length)];
    setState(() {
      scalename = scale['scale'];
      hint = scale['hint'];
    });
    return scale['scale'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text('Scale Generator',
                style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ))),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Text("Play me a:",
                style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ))),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$scalename",
                    style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontWeight: FontWeight.w700,
                    ))),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      generateScale();
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        margin: EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow),
                            SizedBox(width: 5.0),
                            Text("Generate"),
                          ],
                        ))),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        scalesplayed++;
                      });
                      scalesplayedlist.add(scalename);
                      check();
                      generateScale();
                      if (scalesplayedlist.contains(scalename) &&
                          scalesWithHints.length < scalestodo) {
                        generateScale();
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        margin: EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.navigate_next),
                            SizedBox(width: 5.0),
                            Text("Finished!"),
                          ],
                        )))
              ],
            ),
            Text(
              "Scales played: $scalesplayed/$scalestodo",
              style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              )),
            ),
            ElevatedButton(
                onPressed: () {
                  reset();
                },
                child: Text("Reset!")),
            Slider(
              value: scalestodo.toDouble(),
              onChanged: (double value) {
                setState(() {
                  scalestodo = value.round().toInt();
                });
              },
              min: 0,
              max: 50,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ElevatedButton(
                onPressed: () {
                  toggleHint();
                },
                child: Text("Toggle Hint")),
            if (showhint)
              Container(
                alignment: Alignment.center,
                child: Text(
                  "$hint",
                  style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  )),
                ),
              )
          ]),
        ),
      ),
      bottomNavigationBar: Navbar(index: 1),
    );
    ;
  }
}
