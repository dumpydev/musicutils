import 'dart:math';
import 'package:musicutils/Services/ScaleNames.dart';
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

  Future<void> selectScales() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Scales"),
            content: Container(
              child: Column(
                children: [
                  Text("Select the scales you want to play"),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: scalesWithHints.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          title: Text(scalesWithHints[index]['scale']),
                          value: scalesWithHints.contains(index),
                          onChanged: (bool? value) {
                            if(value == true) {
                              setState(() {
                                scalesplayedlist.add(index);
                                value=false;
                              });
                            } else {
                              setState(() {
                                scalesplayedlist.remove(index);
                                value=true;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
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

  Future<void> toggleNotes() async {
    setState(() {
      if (shownotes) {
        shownotes = false;
      } else {
        shownotes = true;
      }
    });
  }

  bool showhint = false;
  bool shownotes = false;
  String hint = "";
  String scalename = "";
  String scalenotes = "";
  int scalesplayed = 0;
  int scalestodo = 20;
  List scalesplayedlist = [];

  Future<String> generateScale() async {
    var scale = scalesWithHints[Random().nextInt(scalesWithHints.length)];
    setState(() {
      scalename = scale['scale'];
      hint = scale['hint'];
      scalenotes = scale['notes'];
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
            Text('Scale Practice',
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  fontWeight: FontWeight.w700,
                ))),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Text("Play me a:",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ))),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$scalename",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.085,
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
              style: GoogleFonts.montserrat(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            if (showhint)
              Container(
                alignment: Alignment.center,
                child: Text(
                  "$hint",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ElevatedButton(
                onPressed: () {
                  toggleNotes();
                },
                child: Text("Toggle Notes")),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            if (shownotes)
              Container(
                alignment: Alignment.center,
                child: Text(
                  "$scalenotes",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ElevatedButton(
                onPressed: () {
                  selectScales();
                },
                child: Text("Select Scales")),
          ]),
        ),
      ),
      bottomNavigationBar: Navbar(index: 1),
    );
  }
}
