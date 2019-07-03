import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crime_report/api/api.dart';
import 'package:crime_report/main.dart';
import 'package:crime_report/pages/login_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/json_serialize/photo.dart';
import 'package:crime_report/pages/rep_cat.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:crime_report/pages/progress.dart';
import 'package:crime_report/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';

class FollowUpPage extends StatefulWidget {
  final String prob;
  final int pID;
  final String desc;
  final String situat;

  FollowUpPage(
      {Key key,
      @required this.prob,
      @required this.pID,
      @required this.desc,
      @required this.situat})
      : super(key: key);
  @override
  _FollowUpPageState createState() => new _FollowUpPageState();
}

class _FollowUpPageState extends State<FollowUpPage> {
  TextEditingController _textController = new TextEditingController();
  List images, photoIMG;
  var img = [];
  int maxImageNo = 5;
  bool selectSingleImage = false;
  String text = '',
      situation = 'green',
      prob_status = '',
      runningTime = '',
      runningdate = '',
      photo = '',
      proImage = '',
      ph = '0';
  bool green = true, yellow = false, orange = false, red = false;
  bool not_fixed = true, adeq_fixed = false;
  var userData;
  bool isAddLoading = false;
  var profileImage;
  File fileImage;
  bool isImage = false;
  bool isChosen = false;
  bool isLoading = true;
  List<Photo> prog = [];

  @override
  void initState() {
    // final DateTime curTime = DateTime.now();
    // DateFormat("hh:mm:ss").format(curTime);
    _textController.text = widget.desc;
    _getUserInfo();
    loadImageList();
    //prog.length = 0;
    //photoIMG.length = 0;
    runningTime = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    runningdate = _formatDateTime1(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getDate());
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
    String sit = widget.situat;
    if (sit == 'green') {
      situationChange(true, false, false, false, '1');
    }
    if (sit == 'yellow') {
      situationChange(false, true, false, false, '2');
    }
    if (sit == 'orange') {
      situationChange(false, false, true, false, '3');
    }
    if (sit == 'red') {
      situationChange(false, false, false, true, '4');
    }

    proImage = await CallApi().getURL();
    //print("ID's : userData['id']");
  }

  void situationChange(bool gr, bool ye, bool ora, bool re, String sit) {
    green = gr;
    yellow = ye;
    orange = ora;
    red = re;
    situation = sit;
  }

  Future loadImageList() async {
    //////   for API without json array value  /////////
    // http.Response response =
    //     await http.get("http://192.168.0.100:8000/api/getallreport/29");

    await Future.delayed(Duration(seconds: 3));

    /////    for content without json array value   ////////
    // var data = {
    //   'id': '${userData['id']}',
    // };
    String id = "${userData['id']}";
    String proid = "${widget.pID}";
    //print('${widget.pID}');
    var response = await CallApi().getData('getReportImageById/' + proid);
    var content = response.body;
    print("Content : " + content);
    List collection = json.decode(content);

    List<Photo> _list = collection.map((json) => Photo.fromJson(json)).toList();

    setState(() {
      prog = _list;
      isLoading = false;
      photo = '1';
    });
  }

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
      //isImage = false;
      photo = '1';
      //if (error == null) _platformMessage = 'No Error Dectected';
    });
  }

  clickImagefromCamera() async {
    profileImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      fileImage = profileImage;
      isImage = true;
      //images = null;
      //isChosen = false;
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
                          Text('Follow up on report Number: "#${widget.pID}"',
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
                                prob_status = '3';
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
                                prob_status = '4';
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
                          Text('Name : ${userData['first_name']}',
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
                          Text('Surname : ${userData['last_name']}',
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
                          Text('Work Code : ${userData['username']}',
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
                        children: <Widget>[
                          Text(
                              "*If Location is OFF, turn on before start reporting",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(ph + " Image/s (Long Press to delete an image)",
                              style: TextStyle(
                                  color: Colors.white,
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
                            margin: EdgeInsets.only(left: 20, right: 20),
                            color: Colors.white,
                            height: 220.0,
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
                                      // var images = proImage + '${photos.photo}';
                                      // List im = new List();
                                      // im.add('${images[index]}');
                                      // setState(() {
                                      //   photoIMG = im;
                                      // });
                                      // print(photoIMG);
                                      //images.add('${photos.photo}');
                                      ph = '${prog.length}';
                                      return Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: subheader,
                                          child: GestureDetector(
                                            child: GridTile(
                                              child: Container(
                                                padding: EdgeInsets.all(5.0),
                                                // child: Stack(
                                                //   children: <Widget>[
                                                //     Center(
                                                //         child:
                                                //             CircularProgressIndicator()),
                                                //     Center(
                                                //       child: FadeInImage
                                                //           .memoryNetwork(
                                                //         placeholder:
                                                //             kTransparentImage,
                                                //         image: proImage +
                                                //             '${photos.photo}',
                                                //             fit: BoxFit.cover
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
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
                                              deleteDialog(photos.id);
                                            },
                                            onTap: () {
                                              viewImage(photos.photo, 1);
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  )),
                    //Text(ph),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        clickImagefromCamera();
                      },
                      child: Container(
                        color: blackbutton,
                        padding: EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 10),
                        margin: EdgeInsets.only(left: 20, right: 20),
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
                      child: (isImage == true)
                          ? new Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              color: Colors.white,
                              height: 150.0,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                // color: Colors.white,
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  child: fileImage != null
                                      ? new GestureDetector(
                                          child: Image.file(fileImage),
                                          onTap: () {
                                            viewImage(fileImage, 2);
                                          },
                                        )
                                      : null,
                                ),
                              ),
                            )
                          : new Container(),
                    ),
                    (isImage == true)
                        ? SizedBox(
                            height: 10,
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          (isImage == true)
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
                        margin: EdgeInsets.only(left: 20, right: 20),
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
                              margin: EdgeInsets.only(left: 20, right: 20),
                              color: Colors.white,
                              height: 220.0,
                              width: MediaQuery.of(context).size.width,
                              // child: new ListView.builder(
                              //   scrollDirection: Axis.horizontal,
                              //   itemBuilder: (BuildContext context, int index) =>
                              //       new Padding(
                              //         padding: const EdgeInsets.all(5.0),
                              //         child: new Image.file(
                              //           new File(images[index].toString()),
                              //         ),
                              //       ),
                              //   itemCount: images.length,
                              // ),
                              child: Container(
                                child: GridView.builder(
                                  //semanticChildCount: 2,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  //crossAxisCount: 2,
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      new Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                          child: GestureDetector(
                                            child: GridTile(
                                              child: new Image.file(
                                                new File(
                                                    images[index].toString()),
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            onTap: () {
                                              viewImage(images[index], 3);
                                            },
                                          ),
                                        ),
                                      ),
                                  itemCount: images.length,
                                ),
                              ),
                            ),
                    ),
                    images == null
                        ? SizedBox(
                            height: 0,
                          )
                        : SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              //imgNum == 0 ? "No photos attached or" : "$imgNum" + " photos attached",
                              (images != null)
                                  ? "${images.length}" + " Photo attached"
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Address : " + address,
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Problem Type : " + widget.prob,
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
                          Text("Date : " + runningdate,
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MainPage()),
                        // );
                      },
                      child:
                          Text(isAddLoading ? "SENDING..." : "SEND FOLLOW UP",
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

  void sendReport() async {
    //int pID = 0;
    String pID = '';
    String des = _textController.text;
    pID = widget.prob;
    int uID = userData['id'];
    String work_code = password;
    String latitude = lat;
    String longitude = longi;
    String situ = situation;

    if (des == '') {
      verificationAlert("Notes field is blank", 1);
    } else if (add == '' && locate == '') {
      verificationAlert("Location is not ON/Detected", 1);
    } else if (photo == '') {
      verificationAlert("Photos not attached. Please attach photos.", 1);
    } else {
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
        'status': 0,
      };
      var res1 = await CallApi().postData(data, 'followUp');
      var body1 = json.decode(res1.body);
      int rID = body1['id'];

      //only camera image is available
      if (isImage == true && images == null && prog == null) {
        sendCameraImage(rID);
        nextPageRoute();
      }
      //only multi image picker is available
      if (isImage == false && images != null && prog == null) {
        sendMultiPhotos(rID);
        nextPageRoute();
      }
      //only old pictures are available
      if (isImage == false && images == null && prog != null) {
        sendOldPics(rID);
        nextPageRoute();
      }
      //camera & multi image picker is available
      if (isImage == true && images != null && prog == null) {
        sendCameraImage(rID);
        sendMultiPhotos(rID);
        nextPageRoute();
      }
      //camera & old pictures are available
      if (isImage == true && images == null && prog != null) {
        sendCameraImage(rID);
        sendOldPics(rID);
        nextPageRoute();
      }
      //multi image picker & old pictures are available
      if (isImage == false && images != null && prog != null) {
        sendMultiPhotos(rID);
        sendOldPics(rID);
        nextPageRoute();
      }
      //all 3 image sources are available
      if (isImage == true && images != null && prog != null) {
        sendCameraImage(rID);
        sendMultiPhotos(rID);
        sendOldPics(rID);
        nextPageRoute();
      }

      print(body1);
      // setState(() {
      //   isAddLoading = false;
      // });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ProgressPage()),
      // );
    }
  }

  void sendMultiPhotos(int id) async {
    print('Follow id : ' + '$id');
    String fID = '$id';

    for (int i = 0; i < images.length; i++) {
      File file = new File(images[i].toString());
      List<int> imageBytes = file.readAsBytesSync();
      String image = base64.encode(imageBytes);
      image = 'data:image/png;base64,' + image;
      var data = {'follow_id': fID, 'photo': image};
      var res1 = await CallApi().postData(data, 'insertflloupImage');
      var body1 = json.decode(res1.body);
      print(body1);
      await Future.delayed(Duration(milliseconds: 10));
    }
  }

  void sendCameraImage(int id) async {
    print('Follow id : ' + '$id');
    String fID = '$id';

    List<int> imageBytes = fileImage.readAsBytesSync();
    String image = base64.encode(imageBytes);
    image = 'data:image/png;base64,' + image;
    var data = {'follow_id': fID, 'photo': image};
    var res1 = await CallApi().postData(data, 'insertflloupImage');
    var body1 = json.decode(res1.body);
    print(body1);
    await Future.delayed(Duration(milliseconds: 10));
  }

  void sendOldPics(int id) async {
    print('Follow id : ' + '$id');
    String fID = '$id';

    for (int i = 0; i < prog.length; i++) {
      String img = proImage + prog[i].photo.toString();
      // File file = new File(img);
      // List<int> imageBytes = file.readAsBytesSync();
      // String image = base64.encode(imageBytes);
      //image = 'data:image/png;base64,' + image;
      var data = {'follow_id': fID, 'photo': img};
      var res1 = await CallApi().postData(data, 'insertflloupImage');
      var body1 = json.decode(res1.body);
      print(body1);
      await Future.delayed(Duration(milliseconds: 10));
    }
  }

  void nextPageRoute() {
    setState(() {
      isAddLoading = false;
    });
    verificationAlert("Follow Up Report has been sent to the manager.", 2);
  }

  void verificationAlert(String msg, int number) {
    showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.black),
          child: AlertDialog(
            title: new Text(
              number == 2 ? "Success!" : "Alert",
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
                  if (number == 2) {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProgressPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
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

  void deleteDialog(int id) {
    showDialog<String>(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.black),
          child: AlertDialog(
            title: new Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            content: new Text(
              "Do want to delete the photo?",
              style: TextStyle(color: Colors.white),
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
                      deleteConfirm(id);
                      Navigator.of(context).pop();
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

  void deleteConfirm(int photo_id) async {
    setState(() {
      isLoading = true;
    });
    String imgID = '$photo_id';

    var data = {'id': imgID};
    var res1 = await CallApi().postData(data, 'deleteWsImage');
    var body1 = json.decode(res1.body);
    print(body1);
    int imID = int.parse(ph);
    int phID = imID - 1;
    String phtID = '$phID';
    setState(() {
      isLoading = false;
      ph = phtID;
      loadImageList();
    });
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
                  : number == 2
                      ? PhotoView(
                          imageProvider: FileImage(photo),
                          minScale: PhotoViewComputedScale.contained * 1.2,
                          maxScale: 4.0,
                        )
                      : number == 3
                          ? PhotoView(
                              imageProvider: FileImage(new File(photo)),
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
