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
import 'package:crime_report/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifyPage extends StatefulWidget {
  @override
  _NotifyPageState createState() => new _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
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
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "Start Reporting",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RepCatPage()),
                );
              },
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
                onTap: () {
                  logoutAlert("Do you want to logout?");
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
      appBar: AppBar(backgroundColor: mainheader, title: Text("Crime Report")),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Text(
                  "Notifications",
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
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('1. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('2. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('3. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('4. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('5. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('6. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('7. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('8. "Insert Notification Heading"')),
                      subtitle: Text("Read more..."),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifyDetPage()),
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

  void logoutAlert(String msg) {
    showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
          child: AlertDialog(
            title: new Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
            content: new Text(
              msg,
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    onPressed: () {
                      logoutConfirm();
                    },
                  ),
                  new FlatButton(
                    child: new Text(
                      "No",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void logoutConfirm() async {
    Navigator.of(context).pop();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogRegPage()),
    );
  }
}
