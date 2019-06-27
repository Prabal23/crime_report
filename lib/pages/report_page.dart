import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:crime_report/api/api.dart';
import 'package:crime_report/pages/login_reg.dart';
import 'package:http/http.dart' as http;
import 'package:crime_report/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/pages/rep_cat.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:crime_report/pages/progress.dart';
import 'package:crime_report/pages/main_page.dart';
import 'package:flutter/services.dart';
import 'package:crime_report/json_serialize/problem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => new _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController _textController = new TextEditingController();
  TextEditingController _textController1 = new TextEditingController();
  //List<Asset> images = List<Asset>();
  List images;
  var img = [];
  int maxImageNo = 5;
  bool selectSingleImage = false;
  String text = '',
      prob = '',
      situation = 'green',
      prob_status = '',
      runningTime = '',
      runningdate = '',
      problem_name = '',
      photo = '';
  int problem_id, imgNum = 0;
  bool green = true, yellow = false, orange = false, red = false;
  List _problems = ["Burst Pipe", "Flood"];
  List<DropdownMenuItem<String>> _dropDownProblemItems;
  List<Problem> probsList = const [];
  bool isLoading = true;
  bool isAddLoading = false;
  var userData;
  var profileImage;
  File fileImage;
  bool isImage = false;
  bool isChosen = false;

  initMultiPickUp() async {
    setState(() {
      images = null;
      //_platformMessage = 'No Error';
    });
    List resultList;
    //String error;
    try {
      resultList = await FlutterMultipleImagePicker.pickMultiImages(
          maxImageNo, selectSingleImage);
    } on PlatformException catch (e) {
      //error = e.message;
      print(e.message);
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      isImage = false;
      photo = '1';
      //if (error == null) _platformMessage = 'No Error Dectected';
    });
  }

  Future getProblemList() async {
    // http.Response response =
    //     await http.get('http://192.168.0.104:8000/api/getAllProblems');

    //await Future.delayed(Duration(seconds: 3));

    /////    for content without json array value   ////////
    var response = await CallApi().getData('getAllProblems');
    var content = response.body;
    List collection = json.decode(content);

    List<Problem> _list =
        collection.map((json) => Problem.fromJson(json)).toList();

    setState(() {
      probsList = _list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getUserInfo();
    getProblemList();
    // _dropDownProblemItems = getDropDownproblemItems();
    // prob = _dropDownProblemItems[0].value;
    _textController.text = address;
    runningTime = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    runningdate = _formatDateTime1(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getDate());
    super.initState();
  }

  clickImagefromCamera() async {
    profileImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      fileImage = profileImage;
      isImage = true;
      images = null;
      photo = '1';
    });
  }

  pickImagefromGallery() async {
    profileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      fileImage = profileImage;
      isImage = false;
      isChosen = true;
      photo = '1';
    });
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

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      runningTime = formattedDateTime;
    });
  }

  void _getDate() {
    final DateTime now = DateTime.now();
    final String formattedDateTime1 = _formatDateTime1(now);
    setState(() {
      runningdate = formattedDateTime1;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  String _formatDateTime1(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  List<DropdownMenuItem<String>> getDropDownproblemItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String problems in _problems) {
      items.add(new DropdownMenuItem(
          value: problems,
          child: new Text(
            problems,
            style: TextStyle(fontSize: 17, color: Colors.white),
          )));
    }
    return items;
  }

//   Future<void> loadAssets() async {
//     List<Asset> resultList = List<Asset>();
//     String error = 'No Error Dectected';

//     try {
//       resultList = await MultiImagePicker.pickImages(
//           maxImages: 300,
//           enableCamera: true,
//           selectedAssets: images,
//           cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//           materialOptions: MaterialOptions(
//             actionBarColor: "#abcdef",
//             actionBarTitle: "Example App",
//             allViewTitle: "All Photos",
//             selectCircleStrokeColor: "#000000",
//           ));
//     } on PlatformException catch (e) {
//       error = e.message;
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       images = resultList;
//       imgNum = images.length;
//       print("Image Number : "+ '$imgNum');
//     });
// }

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
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Name : ${userData['first_name']}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Surname : ${userData['last_name']}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Work Code : ${userData['username']}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
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
                      GestureDetector(
                        onTap: () {
                          clickImagefromCamera();
                        },
                        child: Container(
                          color: blackbutton,
                          padding: EdgeInsets.only(
                              left: 10, top: 10, bottom: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Take Photo/s',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
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
                      ),
                      Center(
                        child: (isImage == true && images == null)
                            ? new Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                color: Colors.white,
                                height: 60.0,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: fileImage != null
                                      ? new Image.file(fileImage)
                                      : null,
                                ),
                              )
                            : new Container(),
                      ),
                      (isImage == true && images == null)
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            (isImage == true && images == null)
                                ? Text(
                                    'Photo taken',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        // onTap: () {
                        //   pickImagefromGallery();
                        // },
                        onTap: initMultiPickUp,
                        child: Container(
                          color: blackbutton,
                          padding: EdgeInsets.only(
                              left: 10, top: 10, bottom: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Attach Photo/s',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
                              Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: images == null
                            ? new Container()
                            : new Container(
                                margin: EdgeInsets.only(left: 0, right: 0),
                                color: Colors.white,
                                height: 60.0,
                                width: MediaQuery.of(context).size.width,
                                child: new ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      new Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: new Image.file(
                                          new File(images[index].toString()),
                                        ),
                                      ),
                                  itemCount: images.length,
                                ),
                              ),
                      ),
                      images == null
                          ? SizedBox(
                              height: 0,
                            )
                          : SizedBox(height: 10),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                //imgNum == 0 ? "No photos attached or" : "$imgNum" + " photos attached",
                                (isImage == false && images != null)
                                    ? "${images.length}" + " Photo attached"
                                    : "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                          "The autofilled address below and location is within 20m accuracy, rather type in the address if the address is incorrect (preferable)",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
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
                            hintText: "Address autofilled*",
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
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10),
                        color: Colors.black,
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              //width: 70,
                              child: Text(
                                "Problem: ",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              //width: 50,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(canvasColor: blackbutton),
                                child: Expanded(
                                  // child: DropdownButtonHideUnderline(
                                  //   child: DropdownButton(
                                  //     style: TextStyle(
                                  //         fontSize: 17, color: Colors.white),
                                  //     value: prob,
                                  //     items: _dropDownProblemItems,
                                  //     hint: Text(prob,
                                  //         style:
                                  //             TextStyle(color: Colors.white)),
                                  //     iconSize: 40,
                                  //     iconDisabledColor: Colors.white,
                                  //     iconEnabledColor: Colors.white,
                                  //     onChanged: (String value) {
                                  //       setState(() {
                                  //         prob = value;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  child: GestureDetector(
                                    onTap: () {
                                      problemList();
                                    },
                                    child: Container(
                                      child: Text(
                                        problem_name == ''
                                            ? "Select Problem"
                                            : problem_name,
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 130,
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
                          controller: _textController1,
                          decoration: InputDecoration(
                            hintText:
                                "Notes: any additional info you feel is necessary*",
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
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Date : " + runningdate,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
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
                                  situation = 'green';
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
                                  situation = 'yellow';
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
                                  situation = 'orange';
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
                                  situation = 'red';
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
                child: GestureDetector(
                  onTap: () {
                    exit(0);
                  },
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
                        isAddLoading ? null : sendReport();
                      },
                      child: Text(isAddLoading ? "SENDING..." : "SEND REPORT",
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

  void problemList() {
    showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.black),
          child: AlertDialog(
            title: Center(
              child: new Text(
                "Select Problem",
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: ListView.builder(
                      itemCount: probsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Problem probList = probsList[index];
                        return ListTile(
                          title: Text(
                            probList.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 30,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _getProblemID(probList.id, probList.title);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
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

  void _getProblemID(int id, String title) {
    setState(() {
      problem_name = title;
      problem_id = id;
    });
  }

  void sendReport() async {
    int pID = 0;
    //String pID = '';
    String add = _textController.text;
    String des = _textController1.text;
    pID = problem_id;
    int uID = userData['id'];
    String work_code = password;
    String latitude = lat;
    String longitude = longi;
    String situ = situation;

    if (add == '') {
      verificationAlert("Address field is blank");
    } else if (pID == 0) {
      verificationAlert("Select your problem");
    } else if (des == '') {
      verificationAlert("Notes field is blank");
    } else if (photo == '') {
      verificationAlert("Photos not attached. Please attach photos.");
    } else {
      sendReportDialog();
    }
  }

  void sendReportDialog() {
    showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
          child: AlertDialog(
            title: new Text(
              "Confirm Submit",
              style: TextStyle(color: Colors.black),
            ),
            content: new Text(
              "Are you sure you want to send this report with the selected situation?",
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    child: new Text(
                      "YES",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    onPressed: () {
                      sendReportConfirm();
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: new Text(
                      "NO",
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

  void sendReportConfirm() async {
    int pID = 0;
    //String pID = '';
    String add = _textController.text;
    String des = _textController1.text;
    pID = problem_id;
    int uID = userData['id'];
    String work_code = password;
    String latitude = lat;
    String longitude = longi;
    String situ = situation;
    setState(() {
      isAddLoading = true;
    });
    var data = {
      'manager_name': 'admin',
      'reporting_person': uID,
      'work_code': work_code,
      'lat': latitude,
      'longi': longitude,
      'address': add,
      'situation': situ,
      'report_date': date + ' ' + time,
      'problem_id': '$pID',
      'notes': des,
      'admin_notes': 'undefined',
      'admin_situation': 'green',
      'status': 0,
      'show_status': 0
    };
    var res1 = await CallApi().postData(data, 'insertReport');
    var body1 = json.decode(res1.body);
    int rID = body1['id'];
    if (isImage == true && images == null) {
      sendCameraImage(rID);
    } else {
      sendPhotos(rID);
    }
    //print(body1);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ProgressPage()),
    // );
  }

  void sendPhotos(int id) async {
    print('Report id : ' + '$id');
    String rID = '$id';

    for (int i = 0; i < images.length; i++) {
      File file = new File(images[i].toString());
      List<int> imageBytes = file.readAsBytesSync();
      String image = base64.encode(imageBytes);
      image = 'data:image/png;base64,' + image;
      var data = {'report_id': rID, 'photo': image};
      var res1 = await CallApi().postData(data, 'insertReportImage');
      var body1 = json.decode(res1.body);
      print(body1);
      await Future.delayed(Duration(milliseconds: 10));
    }

    // List<int> imageBytes = fileImage.readAsBytesSync();
    // String image = base64.encode(imageBytes);
    // image = 'data:image/png;base64,' + image;
    // var data = {'report_id': rID, 'photo': image};
    // var res1 = await CallApi().postData(data, 'insertReportImage');
    // var body1 = json.decode(res1.body);
    // print(body1);
    setState(() {
      isAddLoading = false;
    });
    verificationAlert("Good o go! Report has been sent to your manager");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ProgressPage()),
    // );
  }

  void sendCameraImage(int id) async {
    print('Report id : ' + '$id');
    String rID = '$id';

    List<int> imageBytes = fileImage.readAsBytesSync();
    String image = base64.encode(imageBytes);
    image = 'data:image/png;base64,' + image;
    var data = {'report_id': rID, 'photo': image};
    var res1 = await CallApi().postData(data, 'insertReportImage');
    var body1 = json.decode(res1.body);
    print(body1);
    setState(() {
      isAddLoading = false;
    });
    verificationAlert("Good to go! Report has been sent to your manager");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ProgressPage()),
    // );
  }

  void verificationAlert(String msg) {
    showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.black),
          child: AlertDialog(
            title: new Text(
              "Alert",
              style: TextStyle(color: Colors.white),
            ),
            content: new Text(
              msg,
              style: TextStyle(color: Colors.white),
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
