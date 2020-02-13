import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black87,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.teal[300],
          textTheme: TextTheme(
            title: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 1.6,
            ),
          ),

        ),
        brightness: Brightness.dark,
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 18),
          body2: TextStyle(fontSize: 16),
          button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
          headline: TextStyle(fontWeight: FontWeight.bold),
          subhead: TextStyle(color: Colors.grey),
        ),
        buttonTheme: ButtonThemeData(),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Center(
          child: Text(
            'This is home page',
            style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.headline),
          ),
        ),
      ),
    );
  }
}
