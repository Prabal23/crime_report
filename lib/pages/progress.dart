import 'package:crime_report/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/progress_det.dart';
import 'package:crime_report/pages/notify_page.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => new _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
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
      appBar: AppBar(backgroundColor: mainheader, title: Text("Crime Report")),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Text(
                  "Report Progress",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          height: 40,
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '1. Report/Complaint: "Insert Number"',
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Situation'),
                                  SizedBox(width: 5),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 8,
                                  )
                                ],
                              ),
                            ],
                          )),
                      subtitle: Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: Text("Read more...")),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '2. Report/Complaint: "Insert Number"',
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Situation'),
                                  SizedBox(width: 5),
                                  CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    radius: 8,
                                  )
                                ],
                              ),
                            ],
                          )),
                      subtitle: Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: Text("Read more...")),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '3. Report/Complaint: "Insert Number"',
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Situation'),
                                  SizedBox(width: 5),
                                  CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 8,
                                  )
                                ],
                              ),
                            ],
                          )),
                      subtitle: Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: Text("Read more...")),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '1. Report/Complaint: "Insert Number"',
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Situation'),
                                  SizedBox(width: 5),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 8,
                                  )
                                ],
                              ),
                            ],
                          )),
                      subtitle: Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: Text("Read more...")),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressDetPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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
}
