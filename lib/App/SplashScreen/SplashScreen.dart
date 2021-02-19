
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/App/Test/testHome.dart';
import 'package:rbazaar/App/orderplace/OrderPlacePage.dart';
import 'package:rbazaar/App/profile/ProfilePage.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/commonwidgets.dart';
import 'package:rbazaar/utils/mycolors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) => Get.off(HomePage()));
    // Get.to(OrderPlacePage(addressSno:4));
    // Get.to(ProfilePage());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: Center( child: Container(width: 400, height: 400,
            child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(
                  'assets/images/launcher.jpg',
                )),
          ),)),
    );
  }
}

