import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Topic page',
          style:
              GoogleFonts.nunito(textStyle: Theme.of(context).textTheme.body1),
        ),
      ),
    );
  }
}
