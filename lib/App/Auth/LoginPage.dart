import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/SignupPage.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/App/deliveryboy/DeliveryBoyHomePage.dart';
import 'package:rbazaar/utils/commonutills.dart';

import 'package:rbazaar/utils/mycolors.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'LoginController.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
  String phone;

  LoginPage({this.phone});
}

class LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());

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
                    margin: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 0, top: 40, left: 0, right: 0),
                          alignment: Alignment.center,
                          width: 200,
                          height: 200,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.asset(
                                'assets/images/logo.png',
                              )),
                        ),

                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 50, left: 10, right: 10),
                            child: TextField(
                              onChanged: (text) {
                                // When user enter text in textfield getXHelper checktext method will get called
                                controller.changeusername(text);
                              },
                              // controller: email,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                // errorText: snapshot.hasError ? snapshot.error : null,
                                hintText: 'Enter phone No',
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
                                bottom: 0, top: 20, left: 10, right: 10),
                            child: TextField(
                              onChanged: (text) {
                                // When user enter text in textfield getXHelper checktext method will get called
                                controller.changePassword(text);
                              },
                              // controller: email,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                // errorText: snapshot.hasError ? snapshot.error : null,
                                hintText: 'Enter Password',
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
                        InkWell(
                            onTap: () async {
                              if (await CommonUtills.ConnectionStatus() == true) {
                              if (await controller.forgotPassword()) {
                              CommonUtills.flutterToast(controller.errorValue);
                              } else {
                              CommonUtills.flutterToast(controller.errorValue);
                              }
                              } else {
                              showOfflineToast1();
                              }
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(
                                    bottom: 0, top: 30, left: 0, right: 10),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ))),
                        submitButton(),
                        InkWell(
                          onTap: () {
                            Get.to(SignupPage());
                          },
                          child: Center(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 0, top: 40, left: 0, right: 0),
                                child: Text(
                                  "Don't have an account? Sign UP",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
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
                    : SizedBox(
                        height: 10,
                      ),
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
                    "Login",
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
          if (await controller.loginSC()) {
            CommonUtills.flutterToast(controller.errorValue);
            if(controller.deliveryLogin=='0'){
              Get.offAll(HomePage());
            }else{
              Get.offAll(DeliveryBoyHomePage());
            }
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
        height: height45,
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
          "Login",
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
