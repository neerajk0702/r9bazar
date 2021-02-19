import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';

// import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:location/location.dart' as locationP;

class Common extends ChangeNotifier {
  SharedPreferences sharedPreferences;
  String currentLocation = 'All';
  int selectedLanguageId = 0;
  int selectedRating;

  int notificationBadge;
  bool isCheckedLocation = false;
  List<String> cities = ['All'];
  final Dio _dio = Dio();
  List<int> selectedCategary = [];
  List<int> selectedService = [];

  // locationP.Location locationdata = new locationP.Location();


  getSelectedLanguage() {
    return selectedLanguageId;
  }

  setSelectedLanguage(int data) {
    selectedLanguageId = data;
    notifyListeners();
  }

  getSelectedRating() {
    return selectedRating;
  }

  setSelectedRating(int data) {
    selectedRating = data;
    notifyListeners();
  }

  getSelectedLocation() {
    return currentLocation;
  }

  setSelectedLocation(String data) {
    currentLocation = data;
    sharedPreferences.setString("current_city", data);
    notifyListeners();
  }

  getSelectedCategory() {
    return selectedCategary;
  }

  setSelectedCategory(List<int> data) {
    // List<String> _changeData = [];
    // for (int i = 0; i < data.length; i++) {
    //   _changeData.add(data[i].toString());
    // }
    // print('===================>>>>>');
    // sharedPreferences.setStringList("selected_Service", _changeData);
    selectedCategary = data;
    notifyListeners();
  }

  getSelectedNotiBadge() {
    if (selectedCategary == null) {
      notificationBadge = sharedPreferences.getInt('notification_Batch');
    }

    return notificationBadge;
  }

  setSelectedNotiBadge(int data) {
    sharedPreferences.setInt("notification_Batch", data);
    notificationBadge = data;
    notifyListeners();
  }

  getSelectedService() {
    return selectedService;
  }

  setSelectedService(List<int> data) {
    // List<String> _changeData = [];
    // if (data != null) {
    //   for (int i = 0; i < data.length; i++) {
    //     _changeData.add(data[i].toString());
    //   }
    // }
    // for (int i = 0; i < data.length; i++) {
    //   _changeData.add(data[i].toString());
    // }
    // print('===================>>>>>');
    // sharedPreferences.setStringList("selected_category", _changeData);
    selectedService = data;
    notifyListeners();
  }

  removeFilters() {
    selectedService = [];
    selectedCategary = [];
    selectedLanguageId = 0;
    selectedRating = 0;
    notifyListeners();
  }

  getCities() {
    return cities;
  }

  setCities(data) {
    cities = data;
    notifyListeners();
  }

  getLocationStatus() {
    return isCheckedLocation;
  }

  setLocationStatus(data) {
    isCheckedLocation = data;
    sharedPreferences.setBool("isCheckedLocation", data);
    notifyListeners();
  }

  void initialCurrentCity() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String city = sharedPreferences.getString("current_city");
    if (city != null) {
      setSelectedLocation(city);
    }
    List<String> datas = ['All'];
    List<String> citiesData = sharedPreferences.getStringList("localcities");
    bool isChecked = sharedPreferences.getBool("isCheckedLocation");

    if (citiesData != null) {
      datas.addAll(citiesData);
    }

    if (isChecked != null) {
      setLocationStatus(isChecked);
    }
    setCities(datas);

    return;
  }



  /*checkPermission() async {
    try {
      bool isValid = false;
      bool isEnable = await locationdata.serviceEnabled();
      if (isEnable) {
        locationP.PermissionStatus isGranted =
        await locationdata.hasPermission();
        if (isGranted == locationP.PermissionStatus.granted) {
          isValid = true;
        } else {
          locationP.PermissionStatus isGranted =
          await locationdata.requestPermission();
          if (isGranted == locationP.PermissionStatus.granted) {
            isValid = true;
          }
        }
      } else {
        bool isEnabled = await locationdata.requestService();
        if (isEnabled) {
          locationP.PermissionStatus isGranted =
          await locationdata.hasPermission();
          if (isGranted == locationP.PermissionStatus.granted) {
            isValid = true;
          } else {
            locationP.PermissionStatus isGranted =
            await locationdata.requestPermission();
            if (isGranted == locationP.PermissionStatus.granted) {
              isValid = true;
            }
          }
        }
      }
      return isValid;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }*/

  Future<bool> checkCameraPermission(context) async {
    try {
      var permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.camera);
      if (permission.value == 0) {
        enableServicePopUp(
            context, Constants.cameraTitle, Constants.cameraDesc);
        return false;
      } else {
        return true;
      }
    } catch (e) {
      enableServicePopUp(context, Constants.cameraTitle, Constants.cameraDesc);
      return false;
    }
  }

  Future<bool> checkMediaPermission(context) async {
    try {
      var permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.photos);
      if (permission.value == 0) {
        enableServicePopUp(context, Constants.mediaTitle, Constants.mediaDesc);
        return false;
      } else {
        return true;
      }
    } catch (e) {
      enableServicePopUp(context, Constants.mediaTitle, Constants.mediaDesc);
      return false;
    }
  }





  Future<Null> enableServicePopUp(context, title, desc) async {
    return showCupertinoDialog<Null>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            padding: EdgeInsets.only(top: 25, bottom: 15, left: 15, right: 15),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // SvgPicture.asset(
                //   'assets/images/logout.svg',
                //   height: 140.0,
                //   width: 140.0,
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,

                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  desc,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),

                !Platform.isIOS
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: const Text(
                        'Cancel',
                        style:
                        TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();

                        // Navigator.of(context).pop();
                        //  bool isEnabled = await location.requestService();
                      },
                    ),
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: const Text(
                        'Cancel',
                        style:
                        TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();

                        // Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: const Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 16, color: Color(0xffFF4401)),
                      ),
                      onPressed: () async {
                        try {
                          // await LocationPermissions().openAppSettings();
                          await PermissionHandler().openAppSettings();
                          Navigator.of(context).pop();

                          // Navigator.of(context).pop();
                        } catch (e) {
                          Navigator.of(context).pop();

                          // Navigator.of(context).pop();
                        }

                        // Navigator.pushReplacementNamed(
                        //     context, Constants.logout);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
