import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:crime_report/pages/home.dart';

void main() => runApp(new MyApp());

Color header = Color(0xFFdd00ff);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Expense',
      theme: new ThemeData(
        // buttonTheme: ButtonThemeData(
        //   textTheme: ButtonTextTheme.primary
        // ),
        primarySwatch: Colors.green,
        secondaryHeaderColor: Color.fromRGBO(44, 127, 108, 1.0),
        // buttonColor: Colors.black,
        // primarySwatch: Colors.grey,
        // brightness: Brightness.light,
        accentColor: Colors.blue[100],
        //canvasColor: header
        canvasColor: Colors.grey[200]
      ),
      home: MyHomePage()
    );
  }
}