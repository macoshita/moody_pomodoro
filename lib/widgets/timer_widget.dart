import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "25:00",
      style: GoogleFonts.crimsonText(fontSize: 64),
    );
  }
}
