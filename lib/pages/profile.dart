import 'package:crime_report/pages/rep_cat.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/pages/main_page.dart';
import 'package:crime_report/pages/profile.dart';
import 'package:crime_report/pages/terms_con.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController _textNameController = TextEditingController();
  TextEditingController _textSurNameController = TextEditingController();
  TextEditingController _textPassController = TextEditingController();
  TextEditingController _textrNameController = TextEditingController();
  TextEditingController _textrSurController = TextEditingController();
  TextEditingController _textrEmailController = TextEditingController();
  TextEditingController _textrNewPassController = TextEditingController();
  TextEditingController _textrConPassController = TextEditingController();
  TextEditingController _textYearController = TextEditingController();
  String name = '', surname = '', password = '', _radioGender = '';
  String rName = '', rSurname = '', rEmail = '', rNewpass = '', rConpass = '';
  String day = '', month = '', year = '';
  List _day =
  ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
   "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22",
   "23", "24", "25", "26", "27", "28", "29", "30", "31"];
  List _months =
  ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  List<DropdownMenuItem<String>> _dropDownDayItems;
  List<DropdownMenuItem<String>> _dropDownMonthItems;

  void _handleRadioValueChange(String value) {
    setState(() {
      _radioGender = value;

      switch (_radioGender) {
        case 'Female':
          //Fluttertoast.showToast(msg: 'Male',toastLength: Toast.LENGTH_SHORT);
          break;
        case 'Male':
          //Fluttertoast.showToast(msg: 'Female',toastLength: Toast.LENGTH_SHORT); 
          break;
      }
      debugPrint(_radioGender);
    });
  }

  @override
    void initState() {
      _dropDownDayItems = getDropDowndayItems();
      day = _dropDownDayItems[0].value;

      _dropDownMonthItems = getDropDownMonthItems();
      month = _dropDownMonthItems[0].value;

      super.initState();
  }

  List<DropdownMenuItem<String>> getDropDowndayItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String days in _day) {
      items.add(new DropdownMenuItem(
          value: days,
          child: new Text(days, style: TextStyle(fontSize: 15, color: Colors.black),)
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMonthItems() {
    List<DropdownMenuItem<String>> items1 = new List();
    for (String month in _months) {
      items1.add(new DropdownMenuItem(
          value: month,
          child: new Text(month, style: TextStyle(fontSize: 15, color: Colors.black),)
      ));
    }
    return items1;
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              ),
              onTap: (){
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22
                      ),
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
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              ),
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              ),
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              ),
              //trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TnCPage()),
                  );
                },
                child: Text(
                  "Legal v1.01",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
                  ),
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
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text("Crime Report")
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
                      SizedBox(height: 20,),
                      Text(
                        "*Only individuals who do not work for government can edit their profile",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/prabal.jpg'),
                        ),
                        decoration: new BoxDecoration(
                          color: Theme.of(context).accentColor, // border color
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_box, 
                            color: Colors.grey, 
                            size: 25,
                          ),
                          Icon(
                            Icons.camera_enhance, 
                            color: Colors.grey, 
                            size: 30,
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
                        fontSize: 22
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1.0, color: Colors.black26),
                                bottom: BorderSide(width: 1.0, color: Colors.black26),
                                right: BorderSide(width: 1.0, color: Colors.black26),
                                left: BorderSide(width: 1.0, color: Colors.black26),
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white, 
                            ),
                            width: 155,
                            child: TextField(
                              autofocus: false,
                              controller: _textrNameController,
                              decoration: InputDecoration(
                                hintText: "First name",
                                border: InputBorder.none,
                                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                              ),
                              onChanged: (value) {
                                rName = value;
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            //color: Colors.white,
                            width: 155,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1.0, color: Colors.black26),
                                bottom: BorderSide(width: 1.0, color: Colors.black26),
                                right: BorderSide(width: 1.0, color: Colors.black26),
                                left: BorderSide(width: 1.0, color: Colors.black26),
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
                                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                              ),
                              onChanged: (value) {
                                rSurname = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      //color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black26),
                          bottom: BorderSide(width: 1.0, color: Colors.black26),
                          right: BorderSide(width: 1.0, color: Colors.black26),
                          left: BorderSide(width: 1.0, color: Colors.black26),
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
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                        ),
                        onChanged: (value) {
                          rEmail = value;
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      //color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black26),
                          bottom: BorderSide(width: 1.0, color: Colors.black26),
                          right: BorderSide(width: 1.0, color: Colors.black26),
                          left: BorderSide(width: 1.0, color: Colors.black26),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white, 
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: _textrNewPassController,
                        decoration: InputDecoration(
                          hintText: "New Password",
                          border: InputBorder.none,
                          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                        ),
                        onChanged: (value) {
                          rNewpass = value;
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      //color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black26),
                          bottom: BorderSide(width: 1.0, color: Colors.black26),
                          right: BorderSide(width: 1.0, color: Colors.black26),
                          left: BorderSide(width: 1.0, color: Colors.black26),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white, 
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: _textrConPassController,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: InputBorder.none,
                          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                        ),
                        onChanged: (value) {
                          rConpass = value;
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(left: 10),
                      color: Colors.black,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 250,
                            child: Text(
                              "Are you an? Attorney",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down, 
                            color: Colors.white, 
                            size: 50,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
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
                                  style: TextStyle(color: Colors.black54, fontSize: 19, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            margin: EdgeInsets.only(left: 20, right: 20),  
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: Colors.black26),
                                      bottom: BorderSide(width: 1.0, color: Colors.black26),
                                      right: BorderSide(width: 1.0, color: Colors.black26),
                                      left: BorderSide(width: 1.0, color: Colors.black26),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white, 
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                      value: day,
                                      items: _dropDownDayItems,
                                      onChanged: (String value){
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
                                SizedBox(width: 5,),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: Colors.black26),
                                      bottom: BorderSide(width: 1.0, color: Colors.black26),
                                      right: BorderSide(width: 1.0, color: Colors.black26),
                                      left: BorderSide(width: 1.0, color: Colors.black26),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white, 
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                      value: month,
                                      items: _dropDownMonthItems,
                                      onChanged: (String value){
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
                                SizedBox(width: 5,),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: Colors.black26),
                                      bottom: BorderSide(width: 1.0, color: Colors.black26),
                                      right: BorderSide(width: 1.0, color: Colors.black26),
                                      left: BorderSide(width: 1.0, color: Colors.black26),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white, 
                                  ),
                                  child: TextField(
                                    autofocus: false,
                                    controller: _textYearController,
                                    decoration: InputDecoration(
                                      hintText: "2019",
                                      hintStyle: TextStyle(fontSize: 15, color: Colors.black),
                                      border: InputBorder.none,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 10.0)),
                                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
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
                                SizedBox(width: 5,),
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Why do I need to provide my date of birth?",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 12
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0,),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: <Widget>[
                                new Radio(
                                  value: 'Female',
                                  groupValue: _radioGender,
                                  //onChanged:(int e) => showDatas(e),
                                  onChanged: _handleRadioValueChange
                                ),
                                Container(
                                  transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                                  child: Text(
                                    "Female",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                                  child: new Radio(
                                    value: 'Male',
                                    groupValue: _radioGender,
                                    //onChanged:(int e) => showDatas(e),
                                    onChanged: _handleRadioValueChange
                                  ),
                                ),
                                Container(
                                  transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
                                  child: Text(
                                    "Male",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                                  child: new Radio(
                                    value: 'Non-binary',
                                    groupValue: _radioGender,
                                    //onChanged:(int e) => showDatas(e),
                                    onChanged: _handleRadioValueChange
                                  ),
                                ),
                                Container(
                                  transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
                                  child: Text(
                                    "Non-binary",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Text.rich(
                              TextSpan(
                                text: 'By clicking Sign Up, you agree to our ',
                                style: TextStyle(fontSize: 13, color: Colors.black38),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms, Data Policy',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blueAccent,
                                    )
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black38,
                                    )
                                  ),
                                  TextSpan(
                                    text: 'Cookie Policy',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blueAccent,
                                    )
                                  ),TextSpan(
                                    text: '. You may receive SMS notifications from us and can opt out at any time.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black38,
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                RaisedButton(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 20, 
                                      color: Colors.white
                                    ),
                                  ),
                                  onPressed: (){

                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50,)
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20),
                      color: Colors.black,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => RepCatPage()),
                                // );
                              },
                              child: Icon(
                                Icons.chevron_left, 
                                color: Colors.white, 
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}