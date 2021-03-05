import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/SignupPage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/utils/commonutills.dart';

import 'package:rbazaar/utils/mycolors.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'ChangePasswordController.dart';


class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
  String phone;

  ChangePasswordPage();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final ChangePasswordController controller = Get.put(ChangePasswordController());

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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _topBar(),

                    Container(
                        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                        height: Get.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(alignment: Alignment.center, width: 200, height: 200,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                  )),
                            ),

                            oldpasswordField(),
                            SizedBox(
                              height: 20,
                            ),
                            newpasswordField(),
                            submitButton(),


                          ],
                        ))
                  ],
                ),
              ),
              Positioned(
                child: Obx(
                      () => Center(
                    child: controller.isProcessing
                        ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                        child: CircularProgressIndicator())
                        :SizedBox(
                      height: 10,
                    ) ,
                  ),
                ),
              )
            ],
          ),
        ));
  }
  bool oldpasswordVisible = true;
  Widget oldpasswordField() {
    return TextField(
      obscureText: oldpasswordVisible,
      onChanged: (text) {
        // When user enter text in textfield getXHelper checktext method will get called
        controller.changeOldPassword(text);
      },
      decoration: InputDecoration(
        // errorText: snapshot.hasError ? snapshot.error : null,
        hintText: 'Enter your old Password',
        hintStyle: TextStyle(color: Colors.grey),
        /* hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: Colors.grey,
        ),*/
        suffixIcon: IconButton(
          icon: oldpasswordVisible
              ? Icon(
            FontAwesomeIcons.eyeSlash,
            color: Colors.grey,
            size: 22,
          )
              : Icon(
            FontAwesomeIcons.eye,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: () async {
            setState(() {
              oldpasswordVisible
                  ? oldpasswordVisible = false
                  : oldpasswordVisible = true;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: MyColors.primaryColor,
            )),
        isDense: true,
        // Added this
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      ),
    );
  }
  bool newpasswordVisible = true;
  Widget newpasswordField() {
    return TextField(
      obscureText: newpasswordVisible,
      onChanged: (text) {
        // When user enter text in textfield getXHelper checktext method will get called
        controller.changenewPassword(text);
      },
      decoration: InputDecoration(
        // errorText: snapshot.hasError ? snapshot.error : null,
        hintText: 'Enter your new Password',
        hintStyle: TextStyle(color: Colors.grey),
        /* hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: Colors.grey,
        ),*/
        suffixIcon: IconButton(
          icon: newpasswordVisible
              ? Icon(
            FontAwesomeIcons.eyeSlash,
            color: Colors.grey,
            size: 22,
          )
              : Icon(
            FontAwesomeIcons.eye,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: () async {
            setState(() {
              newpasswordVisible
                  ? newpasswordVisible = false
                  : newpasswordVisible = true;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: MyColors.primaryColor,
            )),
        isDense: true,
        // Added this
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      ),
    );
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
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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

  Widget submitButton() {
    double height45 = MediaQuery.of(context).size.height * 0.05656804733;
    double width230 = MediaQuery.of(context).size.width * 0.54;
    return FlatButton(
      onPressed: () async {
        if (await CommonUtills.ConnectionStatus() == true) {
          SharedPref pref = SharedPref();
          var userInfo = await pref.read("userId");
          if (await controller.ChangePassword(userInfo)) {
            CommonUtills.flutterToast(controller.errorValue);
            Get.back();
          } else {
            CommonUtills.flutterToast(controller.errorValue);
          }
        } else {
          showOfflineToast1();
        }
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height:height45 ,
        margin: const EdgeInsets.only(bottom: 0, top: 40, left: 15, right: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(5.0),
              bottomRight: const Radius.circular(5.0),
              bottomLeft: const Radius.circular(5.0),
              topLeft: const Radius.circular(5.0)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7],
            colors: [
              Color(0xFF25306a),
              Color(0xFF25306a),
            ],
          ),
          color: Color(0xff312E32),
        ),
        child: Center(
            child: Text(
              "Submit",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                // color: Colors.white,
              ),
            )),
      ),
    );
  }
}
