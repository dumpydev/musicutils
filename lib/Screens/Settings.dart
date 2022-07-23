// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/Navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Uri github = Uri.parse("https://github.com/dumpydev/musicutils");

  Future<void> _launchUrl() async {
    if (!await launchUrl(github, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $github';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text('Settings',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w700,
              ))),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(
            "(C) 2022 by Andrew Wang.\nAll rights reserved.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _launchUrl();
              },
              child: Text("Github"))
        ]),
      ),
      bottomNavigationBar: Navbar(index: 3),
    );
  }
}
