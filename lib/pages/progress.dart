import 'package:crime_report/api/api.dart';
import 'package:crime_report/main.dart';
import 'package:crime_report/pages/login_reg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/json_serialize/progress_json.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/progress_det.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => new _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  var userData;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;
  List<Progress> prog = [];

  @override
  void initState() {
    _getUserInfo();
    loadProgressList();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
    //print("ID's : userData['id']");
  }

  Future loadProgressList() async {
    //////   for API without json array value  /////////
    // http.Response response =
    //     await http.get("http://192.168.0.100:8000/api/getallreport/29");

    await Future.delayed(Duration(seconds: 3));

    /////    for content without json array value   ////////
    // var data = {
    //   'id': '${userData['id']}',
    // };
    String id = "${userData['id']}";
    var response = await CallApi().getData('getallreport/' + id);
    var content = response.body;
    print("Content : " + content);
    List collection = json.decode(content);

    List<Progress> _list =
        collection.map((json) => Progress.fromJson(json)).toList();

    setState(() {
      prog = _list;
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
          AppBar(backgroundColor: mainheader, title: Text("Progress Report")),
      // body: Container(
      //   child: ListView(
      //     children: <Widget>[
      //       Container(
      //         margin: EdgeInsets.only(top: 20, bottom: 20),
      //         child: Center(
      //           child: Text(
      //             "Report Progress",
      //             style: TextStyle(fontSize: 22, color: Colors.black),
      //           ),
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(right: 20, left: 20),
      //         child: Column(
      //           children: <Widget>[
      //             Container(
      //               color: Colors.grey[400],
      //               margin: EdgeInsets.only(bottom: 10),
      //               child: ListTile(
      //                 title: Container(
      //                     height: 40,
      //                     margin: EdgeInsets.only(bottom: 10, top: 10),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: <Widget>[
      //                         Text(
      //                           '1. Report/Complaint: "Insert Number"',
      //                           style: TextStyle(fontSize: 15),
      //                         ),
      //                         Row(
      //                           children: <Widget>[
      //                             SizedBox(height: 5),
      //                             Text('Situation'),
      //                             SizedBox(width: 5),
      //                             CircleAvatar(
      //                               backgroundColor: Colors.red,
      //                               radius: 8,
      //                             )
      //                           ],
      //                         ),
      //                       ],
      //                     )),
      //                 subtitle: Container(
      //                     margin: EdgeInsets.only(bottom: 7),
      //                     child: Text("Read more...")),
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ProgressDetPage()),
      //                   );
      //                 },
      //               ),
      //             ),
      //             Container(
      //               color: Colors.grey[400],
      //               margin: EdgeInsets.only(bottom: 10),
      //               child: ListTile(
      //                 title: Container(
      //                     margin: EdgeInsets.only(bottom: 10, top: 10),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: <Widget>[
      //                         Text(
      //                           '2. Report/Complaint: "Insert Number"',
      //                           style: TextStyle(fontSize: 15),
      //                         ),
      //                         Row(
      //                           children: <Widget>[
      //                             SizedBox(height: 5),
      //                             Text('Situation'),
      //                             SizedBox(width: 5),
      //                             CircleAvatar(
      //                               backgroundColor: Colors.yellow,
      //                               radius: 8,
      //                             )
      //                           ],
      //                         ),
      //                       ],
      //                     )),
      //                 subtitle: Container(
      //                     margin: EdgeInsets.only(bottom: 7),
      //                     child: Text("Read more...")),
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ProgressDetPage()),
      //                   );
      //                 },
      //               ),
      //             ),
      //             Container(
      //               color: Colors.grey[400],
      //               margin: EdgeInsets.only(bottom: 10),
      //               child: ListTile(
      //                 title: Container(
      //                     margin: EdgeInsets.only(bottom: 10, top: 10),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: <Widget>[
      //                         Text(
      //                           '3. Report/Complaint: "Insert Number"',
      //                           style: TextStyle(fontSize: 15),
      //                         ),
      //                         Row(
      //                           children: <Widget>[
      //                             SizedBox(height: 5),
      //                             Text('Situation'),
      //                             SizedBox(width: 5),
      //                             CircleAvatar(
      //                               backgroundColor: Colors.green,
      //                               radius: 8,
      //                             )
      //                           ],
      //                         ),
      //                       ],
      //                     )),
      //                 subtitle: Container(
      //                     margin: EdgeInsets.only(bottom: 7),
      //                     child: Text("Read more...")),
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ProgressDetPage()),
      //                   );
      //                 },
      //               ),
      //             ),
      //             Container(
      //               color: Colors.grey[400],
      //               margin: EdgeInsets.only(bottom: 10),
      //               child: ListTile(
      //                 title: Container(
      //                     margin: EdgeInsets.only(bottom: 10, top: 10),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: <Widget>[
      //                         Text(
      //                           '1. Report/Complaint: "Insert Number"',
      //                           style: TextStyle(fontSize: 15),
      //                         ),
      //                         Row(
      //                           children: <Widget>[
      //                             SizedBox(height: 5),
      //                             Text('Situation'),
      //                             SizedBox(width: 5),
      //                             CircleAvatar(
      //                               backgroundColor: Colors.red,
      //                               radius: 8,
      //                             )
      //                           ],
      //                         ),
      //                       ],
      //                     )),
      //                 subtitle: Container(
      //                     margin: EdgeInsets.only(bottom: 7),
      //                     child: Text("Read more...")),
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ProgressDetPage()),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                itemCount: prog.length,
                //separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  Progress progRep = prog[index];
                  String c = progRep.situation;
                  return Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, bottom: 10, top: 10),
                    color: Colors.grey[400],
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${index + 1}. Report/Complaint: "#${progRep.id}"',
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Situation'),
                                  SizedBox(width: 5),
                                  (c == 'green')
                                      ? CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 8,
                                        )
                                      : (c == 'red')
                                          ? CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 8,
                                            )
                                          : (c == 'yellow')
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      Colors.yellow,
                                                  radius: 8,
                                                )
                                              : (c == 'orange')
                                                  ? CircleAvatar(
                                                      backgroundColor:
                                                          Colors.orange,
                                                      radius: 8,
                                                    )
                                                  : null
                                ],
                              ),
                            ],
                          )),
                      subtitle: Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: Text("Read more...")),
                      onTap: () {
                        handleClick(progRep.id, progRep.lat, progRep.longi, c,
                            progRep.problem_id, progRep.notes, progRep.address);
                      },
                    ),
                  );
                },
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

  void handleClick(int id, String lat, String longi, String c,
      String problem_id, String note, String address) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProgressDetPage(
              id: id,
              lat: lat,
              longi: longi,
              sit: c,
              pID: problem_id,
              notes: note,
              add: address)),
    );
  }
}
