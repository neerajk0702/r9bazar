import 'package:bot_toast/bot_toast.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void showToast(String msg) {
  BotToast.showText(text: msg); //popup a text toast;
}

void showOfflineToast() {
  BotToast.showText(text: "notOnline".tr());
}

void showLoader() {
  BotToast.showLoading();
}

void closeLoader() {
  BotToast.closeAllLoading();
}
void showToast1(String msg, {double delay = 1}) {
  BotToast.showText(
    text: msg,
    duration: Duration(seconds: (2 * delay).ceil()),
    textStyle: TextStyle(fontSize: 14, color: Colors.white),
  ); //popup a text toast;
}

void showOfflineToast1({double delay = 1}) {
  BotToast.showText(
    text: "You are not connected to internet",
    duration: Duration(seconds: (2 * delay).ceil()),
    textStyle: TextStyle(fontSize: 14, color: Colors.white),
  ); //popup a text toast;
}

showOffline() {
  BotToast.showCustomNotification(
    align: const Alignment(0, 1),
    enableSlideOff: false,
    toastBuilder: ((_()) {
      return Container(
        color: Colors.red[400],
        height: 30,
        width: double.infinity,
        child: Center(
          child: Text(
            "notOnline",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ).tr(),
        ),
      );
    }),
    duration: Duration(
      hours: 1,
    ),
  );
}

showOnline() {
  BotToast.showCustomNotification(
    align: const Alignment(0, 1),
    enableSlideOff: false,
    toastBuilder: ((_()) {
      return Container(
        color: Colors.green[400],
        height: 30,
        width: double.infinity,
        padding: EdgeInsets.only(top: 5),
        child: Text(
          "online",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ).tr(),
      );
    }),
    duration: Duration(
      seconds: 1,
    ),
  );
}

closeOffline() {
  BotToast.cleanAll();
}

closeToast() {
  BotToast.showCustomNotification(
    onlyOne: true,
    align: const Alignment(0, 1),
    toastBuilder: ((_()) {
      return Container(height: 5);
    }),
    duration: Duration(milliseconds: 100),
  );
}
