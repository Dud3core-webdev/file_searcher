import 'package:flutter/material.dart';

final ThemeData lightThemeData = ThemeData(
  primarySwatch: Colors.purple,
  brightness: Brightness.light,
  primaryColor: Colors.purple[900],
  secondaryHeaderColor: Colors.purple[400],
  backgroundColor: Colors.white70,
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.normal, color: Colors.black),
    headline2: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: Colors.black),
    headline3: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, color: Colors.black),
    headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),
    headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
    headline6: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black),
    button: TextStyle(color: Colors.white)
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple[900]
  )
);