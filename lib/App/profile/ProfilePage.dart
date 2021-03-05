import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/CityModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/commonwidgets.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import 'ProfileController.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();

  ProfilePage();
}

class ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());
  File image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.accountDetailsSC();
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
                    child: Obx(() => Container(
                          height: Get.height,
                          margin: const EdgeInsets.only(
                              bottom: 0, top: 10, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: _userimage()),
                              Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 0, top: 10, left: 10, right: 10),
                                  child: TextField(
                                    onChanged: (text) {
                                      // When user enter text in textfield getXHelper checktext method will get called
                                      controller.changefirstname(text);
                                    },
                                    controller: TextEditingController()
                                      ..text = controller?.AccountdetailData
                                              ?.userDetail?.name ??
                                          "",
                                    // controller: email,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      // errorText: snapshot.hasError ? snapshot.error : null,
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.black),
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
                                      bottom: 0, top: 10, left: 10, right: 10),
                                  child: TextField(
                                    onChanged: (text) {
                                      // When user enter text in textfield getXHelper checktext method will get called
                                      controller.changelastname(text);
                                    },
                                    controller: TextEditingController()
                                      ..text = controller?.AccountdetailData
                                              ?.userDetail?.lname ??
                                          "",
                                    // controller: email,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      // errorText: snapshot.hasError ? snapshot.error : null,
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.black),
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
                                    controller: TextEditingController()
                                      ..text = controller?.AccountdetailData
                                              ?.userDetail?.emailId ??
                                          "",
                                    // controller: email,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      // errorText: snapshot.hasError ? snapshot.error : null,
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.black),
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
                                child: Text(
                                  "Phone",
                                  style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 0, top: 0, left: 10, right: 10),
                                  child: TextField(
                                    onChanged: (text) {
                                      // When user enter text in textfield getXHelper checktext method will get called
                                      // controller.changePhone(text);
                                    },
                                    enabled: false,
                                    controller: TextEditingController()
                                      ..text = controller?.AccountdetailData
                                              ?.userDetail?.registeredNo ??
                                          "",
                                    // controller: email,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      // errorText: snapshot.hasError ? snapshot.error : null,
                                      hintText: 'Phone',

                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.black),
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
                            ],
                          ),
                        ))),
              ),
              InkWell(
                  onTap: () async {
                    SharedPref pref = SharedPref();
                    var userInfo = await pref.read("userId");
                    if (userInfo != null && userInfo != '') {
                      if (await controller.updateProfile(image)) {
                        CommonUtills.flutterToast(controller?.errorValue);
                        setState(() async {
                          SharedPref pref = SharedPref();
                          var profileImg = await pref.read("profileImg");
                          controller.changeprofileImg(profileImg);
                          print(profileImg);
                          Get.offAll(HomePage());
                        });
                        // Get.back();
                      } else {
                        CommonUtills.flutterToast(controller?.errorValue);
                      }
                    } else {
                      Get.to(LoginPage());
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      color: MyColors.lightblue,
                      child: Text(
                        "Update",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
          Positioned(
            child: Obx(
              () => Center(
                child: controller.isProcessing
                    ? SizedBox(
                        height: 10,
                      )
                    : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                        child: CircularProgressIndicator()),
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
                    "Profile",
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

  _userimage() {
    return InkWell(
      onTap: () async {
        var image = await CommonWidgets.selectProfileImage(context);
        if (image != null) {
          _showuserProfileImage(image);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        // width:Get.width/2.78, height: Get.height/6,
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.darkgrey_60),
            borderRadius: BorderRadius.circular(200)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child:  FadeInImage(
                  image: NetworkImage(controller.profileImg ?? ""),
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.cover,
                )

        ),
      ),
    );
  }

  bool imageType() {
    bool imgFlag = false;
    if (controller.profileImg != null && controller.profileImg != '') {
      imgFlag = true;
    }
    return imgFlag;
  }

  void _showuserProfileImage(File pimage) async {
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if (userInfo != null && userInfo != '') {
        if (await controller.updateProfileImage(pimage)) {
          CommonUtills.flutterToast("Profile Image been updated successfully");
          setState(() async {
            SharedPref pref = SharedPref();
            var profileImg = await pref.read("profileImg");
            print(profileImg);
            Get.offAll(HomePage());
          });
          // Get.back();
        } else {
          CommonUtills.flutterToast(controller?.errorValue);
        }
      } else {
        Get.to(LoginPage());
      }



      /*  BehaviorSubject<UserModel> response = await bloc.updateProfilePic(image);
      if (response.value.status) {
        setState(() {

          GetStorage().write(Constants.USERIAMGE, response.value.data.avatar);
          useriamge=GetStorage().read(Constants.USERIAMGE);
        });

        CommonUtills.flutterToast("Profile picture updated successfully");
      }
      else {
        CommonUtills.flutterToast(response.value.message);
      }*/
    } catch (e) {
      print(e.toString());
    }
  }
}
