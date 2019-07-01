import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:geocoder/geocoder.dart';
import 'package:crime_report/api/api.dart';
import 'package:crime_report/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:crime_report/pages/routeAnimation.dart';
import 'package:crime_report/pages/login_reg.dart';
import 'package:crime_report/pages/rep_cat.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:crime_report/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final formKey = GlobalKey<FormState>();
  //final FirebaseMessaging _messaging = FirebaseMessaging();
  var userData;
  String proImage = '', profile = '';
  Map<String, double> curLocation = new Map();
  StreamSubscription<Map<String, double>> locSub;
  Location loc = new Location();
  @override
  void initState() {
    _getUserInfo();
    _getURL();

    curLocation['latitude'] = 0.0;
    curLocation['longitude'] = 0.0;

    mapState();
    locSub = loc.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        curLocation = result;
      });
    });

    // _messaging.getToken().then((token) {
    //   print("Token : " + token);
    // });

    super.initState();
  }

  void _getURL() async {
    proImage = await CallApi().getURL();
    proImage = proImage + '${userData['image']}';
    print("Image : " + profile);
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
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
                color: subheader1,
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
                height: 450,
                color: mainheader,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Text("Hello,",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    //TextField(controller:  _textNameController),
                    Text(
                        '${userData['first_name']}' +
                            " " +
                            '${userData['last_name']}',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text("Work Code :  " + '${userData['username']}',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: EdgeInsets.only(left: 20, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                            padding: EdgeInsets.all(5.0),
                            //color: subheader,
                            child: ('${userData['image']}' == null ||
                                    '${userData['username']}' == '')
                                ? Container(
                                    transform: Matrix4.translationValues(
                                        0.0, 0.0, 0.0),
                                    padding: EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      radius: 60.0,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/person.png'),
                                    ),
                                    decoration: new BoxDecoration(
                                      color: subheader, // border color
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : Container(
                                    child: CircleAvatar(
                                        radius: 60.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: subheader,
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                image:
                                                    new NetworkImage(proImage),
                                                fit: BoxFit.cover,
                                              )),
                                        )),
                                  ),
                            // decoration: new BoxDecoration(
                            //     color: subheader, // border color
                            //     shape: BoxShape.circle,
                            //     image: new DecorationImage(
                            //       image: new NetworkImage('http://192.168.0.109:8000/uploads/profile-1561186060.jpg'),
                            //       fit: BoxFit.cover,
                            //     )),
                          ),
                          SizedBox(width: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, SlideLeftRoute(page: LogRegPage()));
                            },
                            child: Container(
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
                                  color: subheader
                                  //color: Theme.of(context).accentColor,
                                  ),
                              child: Text("Login as a different person?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.5,
                                      fontStyle: FontStyle.italic)),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                    onTap: () {
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
                                    onTap: () {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "*If Location is OFF, turn on before start reporting",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    //SizedBox(height: 5,),
                    // Container(
                    //   margin: EdgeInsets.only(left: 20),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: <Widget>[
                    //       Text(
                    //         location,
                    //         style: TextStyle(color: Colors.white)
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 50,
                    )
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
              GestureDetector(
                onTap: () {
                  exit(0);
                },
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
              ),
              Expanded(
                child: Container(
                  height: 70,
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => RepCatPage()),
                        // );
                        Navigator.push(
                            context, SlideLeftRoute(page: RepCatPage()));
                      },
                      child: Text("START REPORTING",
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

  void mapState() async {
    Map<String, double> my_loc;

    try {
      my_loc = await loc.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
      if (e.code == 'PERMISSION_DENIED_NEVER_ASKED') {}
      my_loc = null;
    }
    setState(() {
      curLocation = my_loc;
    });
    final coordinates =
        new Coordinates(curLocation['latitude'], curLocation['longitude']);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    //address = "${first.featureName} & ${first.addressLine} & ${first.adminArea}";
    address = "${first.addressLine}";
    String addr = "${first.addressLine}";
    country = "${first.countryName}";
    location = curLocation['latitude'].toString() +
        ", " +
        curLocation['longitude'].toString();

    String locates = curLocation['latitude'].toString() +
        ", " +
        curLocation['longitude'].toString();

    lat = curLocation['latitude'].toString();
    longi = curLocation['longitude'].toString();

    setState(() {
      add = addr;
      locate = locates;
    });
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
