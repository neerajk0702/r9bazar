import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/SignupController.dart';
import 'package:rbazaar/utils/commonutills.dart';

import 'package:rbazaar/utils/mycolors.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'LoginController.dart';

class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
  String phone;

  SignupPage({this.phone});
}

class SignupPageState extends State<SignupPage> {
  final SignupController controller = Get.put(SignupController());

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
                    margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                    height: Get.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(alignment: Alignment.center, width: 200, height: 200,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.asset(
                                'assets/images/logonew.png',
                              )),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 10, left: 10, right: 10),
                            child: TextField(
                              onChanged: (text) {
                                // When user enter text in textfield getXHelper checktext method will get called
                                controller.changefirstname(text);
                              },
                              // controller: email,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                // errorText: snapshot.hasError ? snapshot.error : null,
                                hintText: 'First Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: MyColors.primaryColor,
                                    )),
                                isDense: true,
                                // Added this
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 20, 10, 10),
                              ),
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 15, left: 10, right: 10),
                            child: TextField(
                              onChanged: (text) {
                                // When user enter text in textfield getXHelper checktext method will get called
                                controller.changelastname(text);
                              },
                              // controller: email,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                // errorText: snapshot.hasError ? snapshot.error : null,
                                hintText: 'Last Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: MyColors.primaryColor,
                                    )),
                                isDense: true,
                                // Added this
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 20, 10, 10),
                              ),
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 15, left: 10, right: 10),
                            child: TextField(
                              onChanged: (text) {
                                // When user enter text in textfield getXHelper checktext method will get called
                                controller.changeemail(text);
                              },
                              // controller: email,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                // errorText: snapshot.hasError ? snapshot.error : null,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: MyColors.primaryColor,
                                    )),
                                isDense: true,
                                // Added this
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 20, 10, 10),
                              ),
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 15, left: 10, right: 10),
                            child: TextField(
                              onChanged: (text) {
                                // When user enter text in textfield getXHelper checktext method will get called
                                controller.changephone(text);
                              },
                              // controller: email,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                // errorText: snapshot.hasError ? snapshot.error : null,
                                hintText: 'Phone',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: MyColors.primaryColor,
                                    )),
                                isDense: true,
                                // Added this
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 20, 10, 10),
                              ),
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 15, left: 10, right: 10),
                            child: passwordField()),
                        submitButton()
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
                    "Sign up",
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

  bool passwordVisible = true;

  Widget passwordField() {
    return TextField(
      obscureText: passwordVisible,
      onChanged: (text) {
        // When user enter text in textfield getXHelper checktext method will get called
        controller.changePassword(text);
      },
      decoration: InputDecoration(
        // errorText: snapshot.hasError ? snapshot.error : null,
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.grey),
       /* hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: Colors.grey,
        ),*/
        suffixIcon: IconButton(
          icon: passwordVisible
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
              passwordVisible
                  ? passwordVisible = false
                  : passwordVisible = true;
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

  Widget submitButton() {
    double height45 = MediaQuery.of(context).size.height * 0.05656804733;
    double width230 = MediaQuery.of(context).size.width * 0.54;
    return FlatButton(
      onPressed: () async {

        if (await CommonUtills.ConnectionStatus() == true) {
          if (await controller.signup()) {
            CommonUtills.flutterToast(controller.errorValue);
            Navigator.pop(context);
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
        margin: const EdgeInsets.only(bottom: 0, top: 40, left: 15, right: 15),
        height: height45,
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
          "Sign Up",
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
