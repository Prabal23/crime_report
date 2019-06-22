import 'package:crime_report/main.dart';
import 'package:crime_report/pages/login_reg.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/pages/rep_cat.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:crime_report/pages/notify_det.dart';
import 'package:crime_report/pages/progress.dart';
import 'package:crime_report/pages/follow_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressDetPage extends StatefulWidget {
  final int id;
  final String lat;
  final String longi;
  final String sit;
  final String pID;
  final String notes;
  final String add;

  ProgressDetPage(
      {Key key,
      @required this.id,
      @required this.lat,
      @required this.longi,
      @required this.sit,
      @required this.pID,
      @required this.notes,
      @required this.add})
      : super(key: key);
  @override
  _ProgressDetPageState createState() => new _ProgressDetPageState();
}

class _ProgressDetPageState extends State<ProgressDetPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

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
              title: GestureDetector(
                onTap: () async {
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  localStorage.remove('user');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogRegPage()),
                  );
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
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
      appBar:
          AppBar(backgroundColor: mainheader, title: Text("Report Progress")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Text(
                    //   "Report Progress",
                    //   style: TextStyle(fontSize: 22, color: Colors.black),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '1. Report/Complaint: "#${widget.id}"',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(height: 5),
                                Text(
                                  'Situation',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                SizedBox(width: 5),
                                (widget.sit == 'green')
                                    ? CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 8,
                                      )
                                    : (widget.sit == 'red')
                                        ? CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 8,
                                          )
                                        : (widget.sit == 'yellow')
                                            ? CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                radius: 8,
                                              )
                                            : (widget.sit == 'orange')
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.orange,
                                                    radius: 8,
                                                  )
                                                : null
                                // CircleAvatar(
                                //   backgroundColor: Colors.red,
                                //   radius: 8,
                                // )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Province",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Number of days in System",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Order Number : #${widget.id}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Attending Person",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Internal Staff Appointed",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "External Supplier Appointed",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "3rd Party involvement",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Required Completion Date",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Actual Completion Date",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Late by Number of Days",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Early by Number of Days",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Report Description : " + widget.notes,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Address : " + widget.add,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "GPS : " + widget.lat + ", " + widget.longi,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "Resolved (Yes/No)",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "*All relevant info related to report/complaint if anything missed above",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      //height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(5),
                              //width: 140,
                              color: mainheader,
                              child: FlatButton(
                                onPressed: () {
                                  handleClick(widget.pID, widget.id, widget.notes);
                                },
                                child: Text(
                                  "Follow up",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )),
                          SizedBox(width: 10),
                          Container(
                              padding: EdgeInsets.all(5),
                              //width: 140,
                              color: mainheader,
                              child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "Problem fixed,\nthank you",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(15),
          color: blackbutton,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BackButton(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleClick(String problem, int id, String notes) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FollowUpPage(
        prob: problem, pID: id, desc: notes
      )),
    );
  }
}
