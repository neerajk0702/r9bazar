import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/CityModel.dart';
import 'package:rbazaar/App/webview/WebPage.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';

class SettingPage extends StatefulWidget {
  @override
  SettingPageState createState() => SettingPageState();

  SettingPage();
}

class SettingPageState extends State<SettingPage> {
  // final MyOrdersController controller = Get.put(MyOrdersController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _topBar(),
                  Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:Container(
                            height: Get.height,
                            margin: const EdgeInsets.only(
                                bottom: 10, top: 20, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.to(WebPage(url:'https://www.r9bazaar.com/resources/page/contact.html',title:'Contact us'));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 15, right: 10),
                                      child: Row(
                                        children: [
                                         /* Icon(
                                            Icons.call,
                                            color: MyColors.lightblue,
                                            size: 28,
                                          ),*/
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Contact Us',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )),
                                Divider(),
                                InkWell(
                                    onTap: () {
                                      Get.to(WebPage(url:'https://www.r9bazaar.com/resources/page/faq.html',title:'FAQs'));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 15, right: 10),
                                      child: Row(
                                        children: [
                                          /*   Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'FAQs',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )),
                                Divider(),
                                InkWell(
                                    onTap: () {
                                      Get.to(WebPage(url:'https://www.r9bazaar.com/resources/page/termscondition.html',title:'Terms and Conditions'));

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 15, right: 10),
                                      child: Row(
                                        children: [
                                          /*Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Terms and Conditions',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )),
                                Divider(),
                                InkWell(
                                    onTap: () {
                                      Get.to(WebPage(url:'https://www.r9bazaar.com/resources/page/privacypolicy.html',title:'Privacy Policy'));

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 15, right: 10),
                                      child: Row(
                                        children: [
                                          /*Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Privacy Policy',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )),
                                Divider(),
                                InkWell(
                                    onTap: () {
                                      Get.to(WebPage(url:'https://www.r9bazaar.com/resources/page/refundpolicy.html',title:'Refund Return Cancellation Policy'));

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 15, right: 10),
                                      child: Row(
                                        children: [
                                          /*Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Refund Policy',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 90,
                                ),
                              ],
                            ))),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _topBar() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
      color: MyColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Setting",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

}
