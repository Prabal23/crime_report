import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as Math;
import 'package:http/http.dart' as http;
import 'package:crime_report/api/api.dart';
import 'package:crime_report/main.dart';
import 'package:crime_report/pages/login_reg.dart';
import 'package:crime_report/pages/rep_cat.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/pages/rep_cat.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:crime_report/pages/notify_det.dart';
import 'package:crime_report/pages/progress.dart';
import 'package:crime_report/pages/terms_con.dart';
import 'package:crime_report/pages/notify_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crime_report/pages/main_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final formKey = GlobalKey<FormState>();
  TextEditingController _textNameController = TextEditingController();
  TextEditingController _textSurNameController = TextEditingController();
  TextEditingController _textPassController = TextEditingController();
  TextEditingController _textrNameController = TextEditingController();
  TextEditingController _textrSurController = TextEditingController();
  TextEditingController _textrEmailController = TextEditingController();
  TextEditingController _textrNewPassController = TextEditingController();
  TextEditingController _textrConPassController = TextEditingController();
  TextEditingController _textYearController = TextEditingController();
  String name = '', surname = '', password = '', _radioGender = 'male';
  String rName = '', rSurname = '', rEmail = '', rNewpass = '', rConpass = '';
  String day = '',
      month = '',
      year = '',
      type = '',
      date = '',
      uid = '',
      proImage = '',
      m = '',
      d = '',
      image = '',
      pImg = '';
  File fileImage;
  bool isEditLoading = false;
  List _day = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31"
  ];
  List _months = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  List _user_type = [
    "Attorney",
    "Magistrate",
    "Candidate Attorney",
    "Civil Servant",
    "Government Worker",
    "Legal Aid",
    "General Public"
  ];
  //List _user_type = ["staff", "client"];
  List<DropdownMenuItem<String>> _dropDownDayItems;
  List<DropdownMenuItem<String>> _dropDownMonthItems;
  List<DropdownMenuItem<String>> _dropDownTypeItems;
  var userData;
  var profileImage;
  bool isPicked = false;
  bool isImage = false;

  clickImagefromCamera() async {
    profileImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (profileImage != null) {
      setState(() {
        fileImage = profileImage;
        isPicked = true;
        isImage = false;
        pImg = '';
      });
    }
  }

  pickImagefromGallery() async {
    profileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (profileImage != null) {
      setState(() {
        fileImage = profileImage;
        isPicked = true;
        isImage = false;
        pImg = '';
      });
    }
  }

  void _handleRadioValueChange(String value) {
    setState(() {
      _radioGender = value;

      switch (_radioGender) {
        case 'female':
          //Fluttertoast.showToast(msg: 'Male',toastLength: Toast.LENGTH_SHORT);
          break;
        case 'male':
          //Fluttertoast.showToast(msg: 'Female',toastLength: Toast.LENGTH_SHORT);
          break;
        case 'Non_binary':
          //Fluttertoast.showToast(msg: 'Female',toastLength: Toast.LENGTH_SHORT);
          break;
      }
      debugPrint(_radioGender);
    });
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
    _textrNameController.text = '${userData['first_name']}';
    _textrSurController.text = '${userData['last_name']}';
    _textrEmailController.text = '${userData['email']}';
    _textrNewPassController.text = '${userData['password_text']}';
    _radioGender = '${userData['gender']}';
    date = '${userData['dob']}';
    _textYearController.text = date.substring(0, 4);
    year = _textYearController.text;
    m = date.substring(5, 7);
    d = date.substring(8);
    // date.split("-");
    //print(date.split("-");
    for (int i = 0; i < _day.length; i++) {
      if (d == _day[i]) {
        day = _dropDownDayItems[i].value;
      }
    }
    for (int i = 0; i < _months.length; i++) {
      if (m == _months[i]) {
        month = _dropDownMonthItems[i].value;
      }
    }

    // _textYearController.text = date[0];

    type = '${userData['user_type']}';
    uid = '${userData['id']}';
    proImage = await CallApi().getURL();
    isPicked = false;
    isImage = true;

    print(proImage + '${userData['image']}');
    for (int i = 0; i < _user_type.length; i++) {
      if (type == _user_type[i]) {
        type = _dropDownTypeItems[i].value;
      }
    }
    //print("ID's : userData['id']");

    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    pImg = localStorage1.getString('pro_image');
    print("Images : " + image);
  }

  @override
  void initState() {
    _getUserInfo();
    _dropDownDayItems = getDropDowndayItems();
    day = _dropDownDayItems[0].value;

    _dropDownMonthItems = getDropDownMonthItems();
    month = _dropDownMonthItems[0].value;

    _dropDownTypeItems = getDropDownTypeItems();
    type = _dropDownTypeItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDowndayItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String days in _day) {
      items.add(new DropdownMenuItem(
          value: days,
          child: new Text(
            days,
            style: TextStyle(fontSize: 15, color: Colors.black),
          )));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMonthItems() {
    List<DropdownMenuItem<String>> items1 = new List();
    for (String month in _months) {
      items1.add(new DropdownMenuItem(
          value: month,
          child: new Text(
            month,
            style: TextStyle(fontSize: 15, color: Colors.black),
          )));
    }
    return items1;
  }

  List<DropdownMenuItem<String>> getDropDownTypeItems() {
    List<DropdownMenuItem<String>> items2 = new List();
    for (String type in _user_type) {
      items2.add(new DropdownMenuItem(
          value: type,
          child: new Text(
            type,
            style: TextStyle(fontSize: 17, color: Colors.white),
          )));
    }
    return items2;
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
      appBar: AppBar(backgroundColor: mainheader, title: Text("Crime Report")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 40,
                //   color: Colors.red,
                //   child: IconButton(
                //     onPressed: (){
                //       Drawer();
                //     },
                //     icon: Icon(Icons.wallpaper),
                //   ),
                // ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Profile",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "*Only individuals who do not work for government can edit their profile",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            pickImagefromGallery();
                          },
                          // child: ('${userData['image']}' == null ||
                          //         '${userData['image']}' == '')
                          //     ? Container(
                          //         transform:
                          //             Matrix4.translationValues(0.0, 0.0, 0.0),
                          //         padding: EdgeInsets.all(5.0),
                          //         child: CircleAvatar(
                          //           radius: 60.0,
                          //           backgroundColor: Colors.transparent,
                          //           backgroundImage:
                          //               AssetImage('assets/person.png'),
                          //         ),
                          //         decoration: new BoxDecoration(
                          //           color: subheader, // border color
                          //           shape: BoxShape.circle,
                          //         ),
                          //       )
                          //     : ('${userData['image']}' != null ||
                          //             '${userData['image']}' != '')
                          //         ? Container(
                          //             child: CircleAvatar(
                          //                 radius: 60.0,
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                       color: subheader,
                          //                       shape: BoxShape.circle,
                          //                       image: new DecorationImage(
                          //                         image: new NetworkImage(
                          //                             proImage +
                          //                                 '${userData['image']}'),
                          //                         fit: BoxFit.cover,
                          //                       )),
                          //                 )),
                          //           )
                          //         :
                          child: (isPicked == true && isImage == false)
                              ? Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 0.0, 0.0),
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundColor: Colors.transparent,
                                    // child: Image.file(
                                    //   fileImage,
                                    // ),
                                    backgroundImage: FileImage(fileImage),
                                  ),
                                  decoration: new BoxDecoration(
                                    color: subheader, // border color
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : (isPicked == false && isImage == true)
                                  ? Container(
                                      child: CircleAvatar(
                                          radius: 60.0,
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                color: subheader,
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                  image: new NetworkImage(
                                                      proImage +
                                                          '${userData['image']}'),
                                                  fit: BoxFit.cover,
                                                )),
                                          )),
                                    )
                                  : Container(
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
                                    ),
                        ),
                        // new FutureBuilder<File>(
                        //   future: fileImage,
                        //   builder: (BuildContext context,
                        //       AsyncSnapshot<File> snapshot) {
                        //     if (snapshot.connectionState ==
                        //             ConnectionState.done &&
                        //         snapshot.data != null) {
                        //       return Container(
                        //         transform:
                        //             Matrix4.translationValues(0.0, 0.0, 0.0),
                        //         padding: EdgeInsets.all(5.0),
                        //         child: CircleAvatar(
                        //           backgroundColor: Colors.transparent,
                        //           backgroundImage: FileImage(snapshot.data),
                        //           radius: 60.0,
                        //         ),
                        //         decoration: new BoxDecoration(
                        //           color: subheader, // border color
                        //           shape: BoxShape.circle,
                        //         ),
                        //       );
                        //     } else if (snapshot.error != null) {
                        //       return const Text(
                        //         'Error Picking Image',
                        //         textAlign: TextAlign.center,
                        //       );
                        //     } else {
                        //       return Container(
                        //         transform:
                        //             Matrix4.translationValues(0.0, 0.0, 0.0),
                        //         padding: EdgeInsets.all(5.0),
                        //         child: CircleAvatar(
                        //           backgroundColor: Colors.transparent,
                        //           backgroundImage:
                        //               ExactAssetImage('assets/person.png'),
                        //           radius: 60.0,
                        //         ),
                        //         decoration: new BoxDecoration(
                        //           color: subheader, // border color
                        //           shape: BoxShape.circle,
                        //         ),
                        //       );
                        //     }
                        //   },
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                pickImagefromGallery();
                              },
                              child: Container(
                                child: Icon(
                                  Icons.add_box,
                                  color: Colors.grey,
                                  size: 25,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                clickImagefromCamera();
                              },
                              child: Container(
                                child: Icon(
                                  Icons.camera_enhance,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        Text(
                          "Create a new account",
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  //color: Colors.white,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                      right: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                      left: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  //width: 155,
                                  child: TextField(
                                    autofocus: false,
                                    controller: _textrNameController,
                                    decoration: InputDecoration(
                                      hintText: "First name",
                                      border: InputBorder.none,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 20.0, 10.0),
                                    ),
                                    onChanged: (value) {
                                      rName = value;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  //color: Colors.white,
                                  //width: 155,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                      right: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                      left: BorderSide(
                                          width: 1.0, color: Colors.black26),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    autofocus: false,
                                    controller: _textrSurController,
                                    decoration: InputDecoration(
                                      hintText: "Surname",
                                      border: InputBorder.none,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 20.0, 10.0),
                                    ),
                                    onChanged: (value) {
                                      rSurname = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          //color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            border: Border(
                              top:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              right:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              left:
                                  BorderSide(width: 1.0, color: Colors.black26),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _textrEmailController,
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              border: InputBorder.none,
                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            onChanged: (value) {
                              rEmail = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          //color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            border: Border(
                              top:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              right:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              left:
                                  BorderSide(width: 1.0, color: Colors.black26),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _textrNewPassController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "New Password",
                              border: InputBorder.none,
                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            onChanged: (value) {
                              rNewpass = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          //color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            border: Border(
                              top:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              right:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              left:
                                  BorderSide(width: 1.0, color: Colors.black26),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _textrConPassController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              border: InputBorder.none,
                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            onChanged: (value) {
                              rConpass = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Text(
                        //   "You are an " + type,
                        //   style: TextStyle(),
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.only(left: 10),
                          color: Colors.black,
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                //width: 80,
                                child: Text(
                                  "Are you an? ",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                              Container(
                                //width: 50,
                                child: Theme(
                                  data: Theme.of(context)
                                      .copyWith(canvasColor: blackbutton),
                                  child: Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                        value: type,
                                        items: _dropDownTypeItems,
                                        hint: Text(type,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        iconSize: 40,
                                        iconDisabledColor: Colors.white,
                                        iconEnabledColor: Colors.white,
                                        onChanged: (String value) {
                                          setState(() {
                                            type = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Icon(
                              //   Icons.arrow_drop_down,
                              //   color: Colors.white,
                              //   size: 50,
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Birthday",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                          value: day,
                                          items: _dropDownDayItems,
                                          onChanged: (String value) {
                                            setState(() {
                                              day = value;
                                            });
                                          },
                                        ),
                                      ),
                                      // child: Row(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   children: <Widget>[
                                      //     Text(
                                      //       "9",
                                      //       style: TextStyle(fontSize: 15, color: Colors.black),
                                      //     ),
                                      //     Icon(
                                      //       Icons.arrow_drop_down,
                                      //       color: Colors.black,
                                      //       size: 20,
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                          value: month,
                                          items: _dropDownMonthItems,
                                          onChanged: (String value) {
                                            setState(() {
                                              month = value;
                                            });
                                          },
                                        ),
                                      ),

                                      // child: Row(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   children: <Widget>[
                                      //     Text(
                                      //       "Jun",
                                      //       style: TextStyle(fontSize: 15, color: Colors.black),
                                      //     ),
                                      //     Icon(
                                      //       Icons.arrow_drop_down,
                                      //       color: Colors.black,
                                      //       size: 20,
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Colors.black26),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        autofocus: false,
                                        controller: _textYearController,
                                        decoration: InputDecoration(
                                          hintText: "2019",
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                          border: InputBorder.none,
                                          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10.0, 10.0, 20.0, 10.0),
                                        ),
                                        onChanged: (value) {
                                          year = value;
                                        },
                                      ),
                                      // child: Row(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   children: <Widget>[
                                      //     Text(
                                      //       "2019",
                                      //       style: TextStyle(fontSize: 15, color: Colors.black),
                                      //     ),
                                      //     Icon(
                                      //       Icons.arrow_drop_down,
                                      //       color: Colors.black,
                                      //       size: 20,
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        width: 110,
                                        child: Text(
                                          "Why do I need to provide my date of birth?",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 12),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: <Widget>[
                                    new Radio(
                                        value: 'female',
                                        groupValue: _radioGender,
                                        //onChanged:(int e) => showDatas(e),
                                        onChanged: _handleRadioValueChange),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: Text(
                                        "Female",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          -10.0, 0.0, 0.0),
                                      child: new Radio(
                                          value: 'male',
                                          groupValue: _radioGender,
                                          //onChanged:(int e) => showDatas(e),
                                          onChanged: _handleRadioValueChange),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: Text(
                                        "Male",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          -10.0, 0.0, 0.0),
                                      child: new Radio(
                                          value: 'Non-binary',
                                          groupValue: _radioGender,
                                          //onChanged:(int e) => showDatas(e),
                                          onChanged: _handleRadioValueChange),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: Text(
                                        "Non-binary",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Text.rich(
                                  TextSpan(
                                    text:
                                        'By clicking Sign Up, you agree to our ',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black38),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Terms, Data Policy',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blueAccent,
                                          )),
                                      TextSpan(
                                          text: ' and ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black38,
                                          )),
                                      TextSpan(
                                          text: 'Cookie Policy',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blueAccent,
                                          )),
                                      TextSpan(
                                          text:
                                              '. You may receive SMS notifications from us and can opt out at any time.',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black38,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 200,
                                margin: EdgeInsets.only(left: 20),
                                child: RaisedButton(
                                  color:
                                      isEditLoading ? Colors.grey : mainheader,
                                  child: Text(
                                    isEditLoading ? "UPDATING..." : "UPDATE",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    isEditLoading ? null : handleSubmit();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
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

  void handleSubmit() async {
    String n = _textrNameController.text;
    String s = _textrSurController.text;
    String e = _textrEmailController.text;
    String p = _textrNewPassController.text;
    String cp = _textrConPassController.text;
    String dd = day, mm = month, yy = year;
    String g = _radioGender;
    String t = type;

    if (pImg == '') {
      List<int> imageBytes = fileImage.readAsBytesSync();
      image = base64.encode(imageBytes);
      image = 'data:image/png;base64,' + image;
    } else {
      image = pImg;
    }

    // List<int> imageBytes = fileImage.readAsBytesSync();
    // image = base64.encode(imageBytes);
    // image = 'data:image/png;base64,' + image;
    SharedPreferences localStorages = await SharedPreferences.getInstance();
    localStorages.setString('pro_image', image);
    //String image = base64Encode(fileImage.readAsBytesSync());
    //print(image);

    if (image == '') {
      verificationAlert("Photo not selected. Please select a photo.", 1);
    } else if (n == '') {
      verificationAlert("First Name field is blank", 1);
    } else if (s == '') {
      verificationAlert("Surname field is blank", 1);
    } else if (e == '') {
      verificationAlert("Email field is blank", 1);
    } else if (p == '') {
      verificationAlert("Password field is blank", 1);
    } else if (cp == '') {
      verificationAlert("Confirm Password field is blank", 1);
    } else if (cp != p) {
      verificationAlert("Password doesn't match", 1);
    } else if (dd == '') {
      verificationAlert("Day not chosen", 1);
    } else if (mm == '') {
      verificationAlert("Month not chosen", 1);
    } else if (yy == '') {
      verificationAlert("Year field is blank", 1);
    } else if (g == '') {
      verificationAlert("Gender not chosen", 1);
    } else if (t == '') {
      verificationAlert("Type not chosen", 1);
    } else {
      setState(() {
        isEditLoading = true;
      });
      var data = {
        'id': uid,
        'first_name': _textrNameController.text,
        'last_name': _textrSurController.text,
        'email': _textrEmailController.text,
        'password_text': _textrNewPassController.text,
        'dob': year + "-" + month + "-" + day,
        'gender': _radioGender,
        'user_type': type,
        'image': image
      };

      var res1 = await CallApi().postData(data, 'updateUser');
      var body1 = json.decode(res1.body);
      print(body1);

      setState(() {
        isEditLoading = false;
      });

      verificationAlert(
          "Your profile has been updated. Please login again to see the changes.",
          2);
    }
  }

  void verificationAlert(String msg, int numbers) {
    showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.black),
          child: AlertDialog(
            title: new Text(
              numbers == 2 ? "Success!" : "Alert",
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
                  if (numbers == 2) {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
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
}
