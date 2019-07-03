import 'dart:convert';

import 'package:crime_report/api/api.dart';
import 'package:crime_report/json_serialize/photo.dart';
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
import 'package:crime_report/pages/main_page.dart';
import 'package:photo_view/photo_view.dart';
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
  var userData;
  bool isLoading = true;
  List<Photo> prog = [];
  String photo = '', proImage = '', ph = '0';

  @override
  void initState() {
    _getUserInfo();
    loadImageList();

    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });

    proImage = await CallApi().getURL();
    //print("ID's : userData['id']");
  }

  Future loadImageList() async {
    await Future.delayed(Duration(seconds: 3));

    /////    for content without json array value   ////////
    String id = "${userData['id']}";
    String proid = "${widget.id}";
    var response = await CallApi().getData('getReportImageById/' + proid);
    var content = response.body;
    print("Content : " + content);
    List collection = json.decode(content);

    List<Photo> _list = collection.map((json) => Photo.fromJson(json)).toList();

    setState(() {
      prog = _list;
      ph = prog.length.toString();
      isLoading = false;
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
                        SizedBox(height: 10),
                        Text(
                          "Number of days in System",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Order Number : #${widget.id}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Attending Person",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Internal Staff Appointed",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "External Supplier Appointed",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "3rd Party involvement",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Required Completion Date",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Actual Completion Date",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Late by Number of Days",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Early by Number of Days",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Report Description : " + widget.notes,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Address : " + widget.add,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "GPS : " + widget.lat + ", " + widget.longi,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Resolved (Yes/No)",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                //width: 140,
                                color: mainheader,
                                child: FlatButton(
                                  onPressed: () {
                                    handleClick(widget.pID, widget.id,
                                        widget.notes, widget.sit);
                                  },
                                  child: Text(
                                    "Follow up",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                )),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                //width: 140,
                                color: mainheader,
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Problem fixed,\nthank you",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(ph + " Image/s",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    prog == null
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(left: 0, right: 0),
                            color: Colors.white,
                            height: 270.0,
                            width: MediaQuery.of(context).size.width,
                            child: isLoading
                                ? Center(
                                    // child: Text(
                                    //   "Please wait...\nImages are loading",
                                    //   textAlign: TextAlign.center,
                                    // )
                                    child: CircularProgressIndicator())
                                : GridView.count(
                                    primary: true,
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.80,
                                    // mainAxisSpacing: 4,
                                    // crossAxisSpacing: 4,
                                    children:
                                        List.generate(prog.length, (index) {
                                      Photo photos = prog[index];
                                      setState(() {
                                        ph = '${prog.length}';
                                      });
                                      return Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: subheader,
                                          child: GestureDetector(
                                            child: GridTile(
                                              child: Container(
                                                padding: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    color: subheader,
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: Colors.grey),
                                                    //shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                      image: new NetworkImage(
                                                        proImage +
                                                            '${photos.photo}',
                                                      ),
                                                      fit: BoxFit.fill,
                                                    )),
                                              ),
                                            ),
                                            onLongPress: () {
                                              //deleteDialog(photos.id);
                                            },
                                            onTap: () {
                                              viewImage(photos.photo, 1);
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  )),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BackButton(
                color: Colors.white,
              ),
              // Expanded(
              //   child: Container(
              //     //width: 282,
              //     //margin: EdgeInsets.only(right: 78),
              //     //transform: Matrix4.translationValues(0.0, 0.0, -78.0),
              //     height: 78.25,
              //     //transform: Matrix4.translationValues(0.0, 0.0, -140.0),
              //     //margin: EdgeInsets.only(right: 70),
              //     padding: EdgeInsets.all(15),
              //     decoration: BoxDecoration(
              //       border: Border(
              //         top: BorderSide(width: 2.0, color: Colors.black),
              //         bottom: BorderSide(width: 2.0, color: Colors.black),
              //         right: BorderSide(width: 2.0, color: Colors.black),
              //         left: BorderSide(width: 2.0, color: Colors.black),
              //       ),
              //       borderRadius: BorderRadius.circular(0),
              //       color: Colors.grey,
              //     ),
              //     child: Center(
              //       child: Text("CAMERA",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 20.6,
              //             //fontWeight: FontWeight.bold
              //           )),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Container(
              //     //width: 282,
              //     //margin: EdgeInsets.only(right: 78),
              //     //transform: Matrix4.translationValues(0.0, 0.0, -78.0),
              //     height: 78.25,
              //     //transform: Matrix4.translationValues(0.0, 0.0, -140.0),
              //     //margin: EdgeInsets.only(right: 70),
              //     padding: EdgeInsets.all(15),
              //     decoration: BoxDecoration(
              //       border: Border(
              //         top: BorderSide(width: 2.0, color: Colors.black),
              //         bottom: BorderSide(width: 2.0, color: Colors.black),
              //         right: BorderSide(width: 2.0, color: Colors.black),
              //         left: BorderSide(width: 2.0, color: Colors.black),
              //       ),
              //       borderRadius: BorderRadius.circular(0),
              //       color: Colors.grey,
              //     ),
              //     child: Center(
              //       child: Text("GALLERY",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 20.6,
              //             //fontWeight: FontWeight.bold
              //           )),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void handleClick(String problem, int id, String notes, String situ) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FollowUpPage(prob: problem, pID: id, desc: notes, situat: situ)),
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

  void viewImage(var photo, int number) {
    showDialog<String>(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.black),
          child: AlertDialog(
            // title: new Text(
            //   proImage + '$photo',
            //   style: TextStyle(color: Colors.white),
            // ),
            content: Container(
              padding: EdgeInsets.all(5.0),
              child: number == 1
                  ? PhotoView(
                      imageProvider: NetworkImage(
                        proImage + '$photo',
                      ),
                      minScale: PhotoViewComputedScale.contained * 1.2,
                      maxScale: 4.0,
                    )
                  : null,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "OK",
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
