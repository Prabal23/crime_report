import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:crime_report/pages/home.dart';

void main() => runApp(new MyApp());

Color mainheader = Color(0xFF00746b);
Color subheader = Color(0xFFd2ebe8);
Color subheader1 = Color(0xFFd2ebe8);
Color canvas = Color(0xFFeaebf0);
Color greybutton = Color(0xFF464646);
Color blackbutton = Color(0xFF000000);
String name = '',
    surname = '',
    password = '',
    location = '',
    address = '',
    country = '',
    locate = '',
    add = '',
    lat = '',
    longi = '';
String date = '', time = '', prob = '';
String _urls = 'http://192.168.0.108:8000/api/';

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
            accentColor: mainheader,
            canvasColor: canvas
            //canvasColor: Colors.grey[200]
            ),
        home: MyHomePage());
  }
}
