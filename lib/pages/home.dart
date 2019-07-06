import 'package:crime_report/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:crime_report/pages/login_reg.dart';
import 'package:crime_report/pages/routeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:onesignal/onesignal.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  bool _isLoggedIn = false;
  String _debugLabelString = "";
  bool _requireConsent = false;

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    CircularProgressIndicator();
    _checkIfLoggedIn();

    OneSignal.shared.init("fe0695b7-f1d5-4475-bc53-083517f95589");
    oneUserID();
//in case of iOS --- see below
//OneSignal.shared.init("your_app_id_here", {
//	OSiOSSettings.autoPrompt: false,
    // OSiOSSettings.inAppLaunchUrl : true
//});

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      //String userId= OneSignal.shared.getUserId()
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });

// For each of the above functions, you can also pass in a
// reference to a function as well:

    //_handleGetPermissionSubscriptionState();
    super.initState();

    //loadData();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 250).animate(controller)
      ..addListener(() {
        setState(() {
          loadData();
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    _isLoggedIn
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainPage()))
        : Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LogRegPage()));
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LogRegPage()));
    //_isLoggedIn ? Navigator.of(context).pop() : null;
  }

  void oneUserID() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

// the user's ID with OneSignal
    String onesignalUserId = status.subscriptionStatus.userId;
    playerID = onesignalUserId;
    print("Player ID : " + playerID);
// the user's APNS or FCM/GCM push token
    String token = status.subscriptionStatus.pushToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //backgroundColor: Theme.of(context).secondaryHeaderColor,
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
                  //color: Theme.of(context).accentColor,
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
                  height: 350,
                  color: mainheader,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Loading...",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
