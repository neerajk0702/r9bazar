// import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/firebase/pNotification.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/Routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppEntry extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  const AppEntry({Key key, this.analytics, this.observer}) : super(key: key);
  @override
  _AppEntryState createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {

  isFirstRun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      bool _seen = preferences.getBool("seen") ?? false;
      if (_seen) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(Routes.SPLASHSCREEN);

          // Navigator.of(context).pushNamedAndRemoveUntil(
          //   Constants.loginPage,
          //   ModalRoute.withName(Constants.loginPage),
          // );
        });
      } else {
        preferences.setBool("seen", true);
        Get.offAllNamed(Routes.SPLASHSCREEN);

        // Navigator.pushNamedAndRemoveUntil(
        //     context, Constants.apptour, ModalRoute.withName(Constants.apptour));
      }
    } catch (e) {
      preferences.setBool("seen", false);
      Get.offAllNamed(Routes.SPLASHSCREEN);

      // Navigator.pushNamedAndRemoveUntil(
      //     context, Constants.apptour, ModalRoute.withName(Constants.apptour));
    }
  }

  _checkUser() async {
    PNotification _pNotification = PNotification(context);
    await _pNotification?.getNotifications();

//    var user = await db.getLogUser();
    var user=null;
    if (user != null) {
      /*UserResponse userModel = await serviceCaller.fetchuserData();
      userModel.accessToken = user.accessToken;
      db.updateUser(userModel);
      AllowCreate(
        allowCreateClass: userModel.allowCreateClass,
        allowCreateEvent: userModel.allowCreateEvent,
        allowCreateLiveClass: userModel.allowCreateLiveClass,
        allowCreateWorkshop: userModel.allowCreateWorkshop,
      ).addToSharedPref();*/

      await _pNotification?.getToken();
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        if (widget.analytics != null) {
          _currentScreen();
          _sendAnalytics();
        }
      });
    /*  if (user?.vendorVerified == true) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(Constants.homeRoute);

          // Navigator.of(context).pushNamedAndRemoveUntil(Constants.homeRoute,
          //     ModalRoute.withName(Constants.dashboardPage));
        });
      } else if (user?.vendorVerified == false) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(Constants.myaccount);

          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     Constants.myaccount, ModalRoute.withName(Constants.myaccount));
        });
      }*/
    }
    else {
      isFirstRun();
    }
  }

  Future<Null> _currentScreen() async {
    try {
      await widget.analytics.setCurrentScreen(
          screenName: 'Dashboard', screenClassOverride: 'Authenticated');
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _sendAnalytics() async {
    try {
      var user =null;// await db.getLogUser();
      await widget.analytics.logEvent(
          name: 'logged_in', parameters: <String, dynamic>{'userId': user.id});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
     var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
