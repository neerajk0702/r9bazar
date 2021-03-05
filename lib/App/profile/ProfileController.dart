import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'ProfileServicecaller.dart';


class ProfileController extends GetxController {
  final ProfileServicecaller serviceCaller = ProfileServicecaller();
  final _AccountdetailData = AccountdetailModel().obs;

  AccountdetailModel get AccountdetailData => this._AccountdetailData.value;

  changeAccountdetailData(AccountdetailModel value) => this._AccountdetailData.value = value;

  final _isProcessing = true.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;

  final _error = "".obs;

  get errorValue => this._error.value;
  changeError(value) => this._error.value = value;

  final _firstname = "".obs;

  get firstname => this._firstname.value;

  changefirstname(value) => this._firstname.value = value;

  final _lastname = "".obs;

  get lastnamevalue => this._lastname.value;

  changelastname(value) => this._lastname.value = value;

  final _email = "".obs;

  get emailValue => this._email.value;

  changeemail(value) => this._email.value = value;

  final _phone = "".obs;

  get phoneValue => this._phone.value;

  changephone(value) => this._phone.value = value;

  final _profileImg = "".obs;

  get profileImg => this._profileImg.value;

  changeprofileImg(value) => this._profileImg.value = value;


  Future<bool> accountDetailsSC() async {
    bool doneFlage=false;
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if(userInfo!=null && userInfo!='') {
        if (await CommonUtills.ConnectionStatus() == true) {
          changeProcessing(false);
          AccountdetailModel data = await serviceCaller.myaccountdetailData(userInfo);
          if(data.userDetail!=null){
            pref.save("name", data.userDetail.name);
            pref.save("password", data.userDetail.password);
            pref.save("phone", data.userDetail.registeredNo);
            pref.save("email", data.userDetail.emailId);
            pref.save("lname", data.userDetail.lname);
            pref.save("userId", data.userDetail.userId);
            changefirstname(data.userDetail.name);
            changelastname(data.userDetail.lname);
            changeemail(data.userDetail.emailId);
            String profileImg=Constants.imageUrl+data.userDetail?.folderName+data.userDetail?.filename;
            changeprofileImg(profileImg);
            changeAccountdetailData(data);
            doneFlage=true;
          }else{
            changeError("No data found!");
          }
          changeProcessing(true);
        }else{
          showOfflineToast1();
        }
      }
    } catch (e) {
      changeProcessing(true);
      changeError(e.toString());
    }

    return doneFlage;
  }

  Future<bool> updateProfile(File image) async {
    bool doneFlage=false;

    if (firstname == null || firstname == '') {
      changeError("Please enter first name");
      return doneFlage;
    }
    if (lastnamevalue == null || lastnamevalue == '') {
      changeError("Please enter last name");
      return doneFlage;
    }
    if (emailValue == null || emailValue == '') {
      changeError("Please enter your email id!");
      return doneFlage;
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailValue);
    if (!emailValid) {
      changeError("Please enter valid email id!");
      return doneFlage;
    }
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      var phone = await pref.read("phone");
        if (await CommonUtills.ConnectionStatus() == true) {
          changeProcessing(false);
          AccountdetailModel data = await serviceCaller.updateProfileSC(userInfo,firstname,lastnamevalue,emailValue,image,phone);
          if(data.userDetail!=null){
            pref.save("name", data.userDetail.name);
            pref.save("password", data.userDetail.password);
            pref.save("phone", data.userDetail.registeredNo);
            pref.save("email", data.userDetail.emailId);
            pref.save("lname", data.userDetail.lname);
            String profileImg='';
            if(data.userDetail?.filename!=null && data.userDetail?.filename!=''){
               profileImg=Constants.imageUrl+data.userDetail?.folderName+data.userDetail?.filename;
               changeprofileImg(profileImg);
            }
            pref.save("profileImg", profileImg);
            pref.save("userId", data.userDetail.userId);
            doneFlage=true;
            changeError("Profile has been updated successfully");
          }else{
            changeError("Profile has not been update!");
          }
          changeProcessing(true);
        }else{
          showOfflineToast1();
        }
    } catch (e) {
      changeProcessing(true);
      changeError(e.toString());
    }

    return doneFlage;
  }


  Future<bool> updateProfileImage(File image) async {
    bool doneFlage=false;

    if (image == null || image == '') {
      changeError("Please select profile image");
      return doneFlage;
    }
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if (await CommonUtills.ConnectionStatus() == true) {
        changeProcessing(false);
        AccountdetailModel data = await serviceCaller.updateProfileImage(userInfo,image);
        if(data.userDetail!=null){
          // pref.save("name", data.userDetail.name);
          // pref.save("password", data.userDetail.password);
          // pref.save("phone", data.userDetail.registeredNo);
          // pref.save("email", data.userDetail.emailId);
          // pref.save("lname", data.userDetail.lname);
          String profileImg='';
          if(data.userDetail?.filename!=null && data.userDetail?.filename!=''){
            profileImg=Constants.imageUrl+data.userDetail?.folderName+data.userDetail?.filename;
            changeprofileImg(profileImg);
          }
          pref.save("profileImg", profileImg);
          // pref.save("userId", data.userDetail.userId);
          doneFlage=true;
          changeError("Profile image has been updated successfully");
        }else{
          changeError("Profile image has not been update!");
        }
        changeProcessing(true);
      }else{
        showOfflineToast1();
      }
    } catch (e) {
      changeProcessing(true);
      changeError(e.toString());
    }

    return doneFlage;
  }
}
