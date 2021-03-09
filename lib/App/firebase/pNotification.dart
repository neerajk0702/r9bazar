import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/model/DeviceInfoModel.dart';
import 'package:rbazaar/App/model/NotificationModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/Global/global.dart';

class PNotification {
  final BuildContext context;
  PNotification(this.context);
  var oldId = '';

  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future getToken() async {
    try {
      if (Platform.isIOS) {
        bool isPermited = await _messaging.requestNotificationPermissions();
        if (!isPermited) {
          return;
        }
      }

      var token = await _messaging.getToken();
      print("************FirebaseMessaging token: $token");
      SharedPref pref = SharedPref();
        pref.save("DEVICETOKEN", token);
//      var user = await db.getLogUser();
//      String userAccessToken =user != null && user.accessToken != null ? user.accessToken : '';
      // sending fmc tocken value to server
      await _postFmcToken(token, "");
    } catch (e) {
      print("Error $e");
    }
  }

  // sending fmc token value to server
  _postFmcToken(String token, String accessToken) async {
    // print('step 1');
    if (token != null && token.trim() != '') {
      // to store the device info in the model class
      DeviceInfoModel deviceModel;
      // to store the platform type
      int platformType;

      DeviceInfoPlugin info = DeviceInfoPlugin();
      if (Platform.isIOS) {
        platformType = Constants.ios;

        IosDeviceInfo iosDeviceInfo = await info.iosInfo;
        deviceModel = DeviceInfoModel(
          modelNo: iosDeviceInfo.model,
          brand: iosDeviceInfo.name,
          uniqueId: iosDeviceInfo.identifierForVendor,
          manufacturer: iosDeviceInfo.utsname.machine,
          androidversion: iosDeviceInfo.utsname.version.toString(),
        );
      } else {
        platformType = Constants.android;

        AndroidDeviceInfo androidInfo = await info.androidInfo;
        deviceModel = DeviceInfoModel(
          modelNo: androidInfo.model,
          brand: androidInfo.brand,
          uniqueId: androidInfo.androidId,
          manufacturer: androidInfo.manufacturer,
          androidversion: androidInfo.version.release,
        );
      }

      /*Dio _dio = new Dio(
        BaseOptions(
          headers: {
            "Authorization": accessToken,
            "Content-Type": 'application/json',
            "Accept": 'application/json',
          },
        ),
      );
      await _dio.post(
        "${Constants.oaouthUrl}/api/device/token/register",
        data: {
          "token": token,
          "platform_type": platformType,
          "app_type": Constants.partner,
          "unique_id": deviceModel.uniqueId,
          "meta": {
            "modelNo": deviceModel.modelNo,
            "brand": deviceModel.brand,
            "manufacturer": deviceModel.manufacturer,
            "version": deviceModel.androidversion
          },
        },
      );*/
      // print('done');
    }
  }

  getNotifications() async {
    /*_messaging.configure(onResume: (Map<String, dynamic> message) async {
      try {
        await _pushToPage(message['data'].cast<String, dynamic>());
      } catch (e) {
        print("errror onResume $e");
      }
    }, onLaunch: (Map<String, dynamic> message) async {
      try {
        await _pushToPage(message['data'].cast<String, dynamic>());
      } catch (e) {
        print("errror onLaunch $e");
      }
    });*/

    _messaging.configure(onMessage: (Map<String, dynamic> message) async {
      try {
        var data = message['data'].cast<String, dynamic>();
        showSnakeBar(data["title"], data["description"], onTap: () {
          _pushToPage(data);
        });
        print("onMessage notification - $data");
      } catch (e) {
        print("errror $e");
      }
    },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        try {
          print('on pressed resume');
          _pushToPage(message['data'].cast<String, dynamic>());
          // message.clear();
        } catch (e) {
          print("errror on resume $e");
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        try {
          print('on pressed launch');
          _pushToPage(message['data'].cast<String, dynamic>());
          // message.clear();
        } catch (e) {
          print("errror $e");
        }
      },
    );


  }
  _pushToPage(message) async {
    try {
      NotificationModel notificationDatas =
          NotificationModel.fromNotificationJson(message);

      if (notificationDatas != null && notificationDatas.id != oldId) {
        await navigatorKey.currentState.pushNamedAndRemoveUntil(
            Constants.notification, (Route<dynamic> route) => false);
        oldId = notificationDatas.id;
      }

      return;
    } catch (e) {
      print("errror $e");
      return;
    }
  }
  showSnakeBar(String title, String msg,
      {Color color = Colors.white, VoidCallback onTap}) {
    BotToast.showCustomNotification(
      toastBuilder: ((_()) {
        return GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 10,
            color: color,
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              subtitle: Text(msg,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ),
          ),
        );
      }),
      duration: Duration(seconds: 5),
    );
  }

}
