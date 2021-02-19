import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CommonUtills {
  static Future<bool> ConnectionStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery
        .of(context)
        .size
        .toString());
    return MediaQuery
        .of(context)
        .size;
  }

  static double displayHeight(BuildContext context) {
    debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  static double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  static String timesagofeacture(String fromdate) {
    try {
      var updatedatefrom = new DateFormat('yyyy-MM-dd HH:mm:ss').parse(
          fromdate);
// with a defined format
      // var newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse("10/02/2000 15:13:09");
      final now = new DateTime.now();
      String timemsg;
      var locale = 'en';
      //DateTime dateTime = DateTime.tryParse(fromdate);
      final difference = now.difference(updatedatefrom);
      timemsg = timeago.format(now.subtract(difference), locale: locale);
      return timemsg;
    }
    catch (e) {
      print(e);
    }
  }

  static flutterToast(String msg) {
    return Fluttertoast.showToast(
        msg: tr(msg).tr(),

        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,

        fontSize: 16.0
    );
  }

  static String parseHtmlString(String htmlString) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlString.replaceAll(exp, '');
  }

  static String gethtmltitle(String htmlString) {
    var document = parse(htmlString);
    String id = document.body.outerHtml;

    return id;
  }

  static String getupdateDateTime(String datetimeStr) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(
        datetimeStr);
//   "updated_at":"2020-05-15 16:34:11",
    final DateFormat formatter = DateFormat('yMMMd');
    final String formatted = formatter.format(tempDate);
    print(formatted);
    return formatted;
  }

  static String getCurentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25
    return formattedDate;
  }

  static showtoast(String string) {
    Fluttertoast.showToast(
        msg: "$string",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0);
  }

}