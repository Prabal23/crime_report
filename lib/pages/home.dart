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
    //initOneSignal();
  }

//   void initOneSignal() {
//     // if (!mounted) return;

//     // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

//     // OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

//     // OneSignal.shared
//     //     .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//     //       print("OPENED NOTIFICATION");
//     //       print(result.notification.jsonRepresentation().replaceAll("\\n", "\n"));
//     //   this.setState(() {
//     //     _debugLabelString =
//     //     "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
//     //   });
//     // });

//     // OneSignal.shared
//     //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
//     //   print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
//     // });

//     // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//     //   print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
//     // });

//     // OneSignal.shared.setEmailSubscriptionObserver(
//     //         (OSEmailSubscriptionStateChanges changes) {
//     //       print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
//     //     });

//     // OneSignal.shared
//     //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

//     // OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

//     OneSignal.shared
//         .setNotificationReceivedHandler((OSNotification notification) {
//       // will be called whenever a notification is received
//     });

//     OneSignal.shared
//         .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//       // will be called whenever a notification is opened/button pressed.
//     });
// //  OneSignal.shared.init("your_app_id_here");
//     final app_id = "fe0695b7-f1d5-4475-bc53-083517f95589";
// // You can also pass in iOS settings as a map.
// // These settings are only applicable to iOS,
// // and will be ignored in Android

//     OneSignal.shared.init(app_id, iOSSettings: {
//       OSiOSSettings.autoPrompt: false,
//       OSiOSSettings.inAppLaunchUrl: true
//     });
//   }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    _isLoggedIn
        ? Navigator.pushReplacement(context, SlideLeftRoute(page: MainPage()))
        : Navigator.pushReplacement(
            context, SlideLeftRoute(page: LogRegPage()));
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LogRegPage()));
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
