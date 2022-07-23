import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicutils/Widgets/Navbar.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
class SW extends StatefulWidget {
  const SW({Key? key}) : super(key: key);

  @override
  State<SW> createState() => _SWState();
}
String time = "00:00:00";
class _SWState extends State<SW> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    onChange: (value) {
        time = value.toString();
    },
  ); // Create instance.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: MediaQuery.of(context).size.height * 0.05),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'Stopwatch',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Text(
              '$time',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {_stopWatchTimer.onExecute.add(StopWatchExecute.start);}, child: Text("Start")),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                ElevatedButton(onPressed: () {_stopWatchTimer.onExecute.add(StopWatchExecute.stop);}, child: Text("Stop")),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Navbar(index: 2),
    );
  }
}
