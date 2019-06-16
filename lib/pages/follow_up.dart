import 'dart:async';

import 'package:crime_report/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/pages/rep_cat.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:crime_report/pages/progress.dart';
import 'package:crime_report/pages/main_page.dart';

class FollowUpPage extends StatefulWidget {
  @override
  _FollowUpPageState createState() => new _FollowUpPageState();
}

class _FollowUpPageState extends State<FollowUpPage> {
  TextEditingController _textController = new TextEditingController();
  String text = '', situation = '', prob_status = '', runningTime = '';
  bool green = true, yellow = false, orange = false, red = false;
  bool not_fixed = true, adeq_fixed = false;

  @override
  void initState() {
    // final DateTime curTime = DateTime.now();
    // DateFormat("hh:mm:ss").format(curTime);
    runningTime = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      runningTime = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    Drawer drawer = new Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Report Progress",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-15.0, -10.0, 0.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressPage()),
                );
              },
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "Notifications",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotifyPage()),
                );
              },
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "Log Out",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TnCPage()),
                  );
                },
                child: Text(
                  "Legal v1.01",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              //trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
          //backgroundColor: Colors.transparent
          backgroundColor: mainheader,
          title: Text("Crime Report")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Container(
                    child: Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/logo.png'),
                  ),
                )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: subheader,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "YOUR COMPANY APP TITLE",
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Incidents | ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "Complaints | ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "Assets |",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Maintenance | ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "Assessments | ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "Reporting |",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                //height: 380,
                color: mainheader,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Follow up on report Number: "Insert Number"',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: blackbutton,
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Problem still not fixed',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                not_fixed = true;
                                adeq_fixed = false;
                                prob_status = '1';
                              });
                            },
                            child: (not_fixed == true && adeq_fixed == false)
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  )
                                : Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: blackbutton,
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Problem not fixed adequately',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                not_fixed = false;
                                adeq_fixed = true;
                                prob_status = '2';
                              });
                            },
                            child: (not_fixed == false && adeq_fixed == true)
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  )
                                : Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 130,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      //color: Colors.white,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 2.0, color: Colors.black),
                          bottom: BorderSide(width: 2.0, color: Colors.black),
                          right: BorderSide(width: 2.0, color: Colors.black),
                          left: BorderSide(width: 2.0, color: Colors.black),
                        ),
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Add info you feel is necessary*",
                          border: InputBorder.none,
                          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: BorderSide(color: Colors.black, width: 10.0)),
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        ),
                        onChanged: (value) {
                          text = value;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(surname,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(password,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(width: 2.0, color: Colors.black),
                                bottom:
                                    BorderSide(width: 2.0, color: Colors.black),
                                right:
                                    BorderSide(width: 2.0, color: Colors.black),
                                left:
                                    BorderSide(width: 2.0, color: Colors.black),
                              ),
                              borderRadius: BorderRadius.circular(0),
                              color: subheader,
                            ),
                            child: Text("Location Detect",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold)),
                          ),
                          (locate == '' || add == '')
                              ? Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      bottom: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      right: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      left: BorderSide(
                                          width: 2.0, color: Colors.black),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.grey,
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      locate = location;
                                      add = address;
                                    },
                                    child: Text("ON",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          //fontWeight: FontWeight.bold
                                        )),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      bottom: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      right: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      left: BorderSide(
                                          width: 2.0, color: Colors.black),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.black,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text("ON",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            //fontWeight: FontWeight.bold
                                          )),
                                      Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                          (locate == '' || add == '')
                              ? Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      bottom: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      right: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      left: BorderSide(
                                          width: 2.0, color: Colors.black),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.black,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text("OFF",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            //fontWeight: FontWeight.bold
                                          )),
                                      Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      bottom: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      right: BorderSide(
                                          width: 2.0, color: Colors.black),
                                      left: BorderSide(
                                          width: 2.0, color: Colors.black),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.grey,
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        locate = '';
                                        add = ''; 
                                      });
                                    },
                                    child: Text("OFF",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          //fontWeight: FontWeight.bold
                                        )),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "*If Location is OFF, turn on before start reporting",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: blackbutton,
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Take Photo/s',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add_box,
                                color: Colors.white,
                                size: 25,
                              ),
                              Icon(
                                Icons.camera_enhance,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: blackbutton,
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Attach Photo/s',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                          Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("No photos attached or\n5 photos attached",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(address, style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Autofil previous problem type",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Date : " + date,
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "Time : " +
                                  runningTime +
                                  " (" +
                                  country +
                                  " standard time)",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Location Cordinates : " + location,
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(width: 2.0, color: Colors.black),
                                bottom:
                                    BorderSide(width: 2.0, color: Colors.black),
                                right:
                                    BorderSide(width: 2.0, color: Colors.black),
                                left:
                                    BorderSide(width: 2.0, color: Colors.black),
                              ),
                              borderRadius: BorderRadius.circular(0),
                              color: subheader,
                            ),
                            child: Text("Situation",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                green = true;
                                yellow = false;
                                orange = false;
                                red = false;
                                situation = '1';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  left: BorderSide(
                                      width: 2.0, color: Colors.black),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.green,
                              ),
                              child: (green == true &&
                                      yellow == false &&
                                      orange == false &&
                                      red == false)
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : Container(
                                      width: 10,
                                      height: 10,
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                green = false;
                                yellow = true;
                                orange = false;
                                red = false;
                                situation = '2';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  left: BorderSide(
                                      width: 2.0, color: Colors.black),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.yellow,
                              ),
                              child: (green == false &&
                                      yellow == true &&
                                      orange == false &&
                                      red == false)
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.black,
                                      size: 20,
                                    )
                                  : Container(
                                      width: 10,
                                      height: 10,
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                green = false;
                                yellow = false;
                                orange = true;
                                red = false;
                                situation = '3';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  left: BorderSide(
                                      width: 2.0, color: Colors.black),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.orange,
                              ),
                              child: (green == false &&
                                      yellow == false &&
                                      orange == true &&
                                      red == false)
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : Container(
                                      width: 10,
                                      height: 10,
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                green = false;
                                yellow = false;
                                orange = false;
                                red = true;
                                situation = '4';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  left: BorderSide(
                                      width: 2.0, color: Colors.black),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.red,
                              ),
                              child: (green == false &&
                                      yellow == false &&
                                      orange == false &&
                                      red == true)
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : Container(
                                      width: 10,
                                      height: 10,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(15),
                child: BackButton(
                  color: Colors.white,
                ),
                // child: Icon(
                //   Icons.chevron_left,
                //   color: Colors.white,
                //   size: 40,
                // ),
              ),
              Container(
                height: 78.25,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2.0, color: Colors.black),
                    bottom: BorderSide(width: 2.0, color: Colors.black),
                    right: BorderSide(width: 2.0, color: Colors.black),
                    left: BorderSide(width: 2.0, color: Colors.black),
                  ),
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.grey,
                ),
                child: Center(
                  child: Text("EXIT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        //fontWeight: FontWeight.bold
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  height: 78.25,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2.0, color: Colors.black),
                      bottom: BorderSide(width: 2.0, color: Colors.black),
                      right: BorderSide(width: 2.0, color: Colors.black),
                      left: BorderSide(width: 2.0, color: Colors.black),
                    ),
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      child: Text("SEND FOLLOW UP",
                          style: TextStyle(color: Colors.white, fontSize: 20
                              //fontWeight: FontWeight.bold
                              )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
