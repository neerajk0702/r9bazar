import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Auth/AuthServicecaller.dart';
import 'package:rbazaar/App/Auth/LoginModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'AccountdetailModel.dart';
import 'homeservicecaller.dart';


class MyAccountDetailsController extends GetxController {
  MyAccountDetailsController();
  final servicecaller = HomeServiceCaller();
  final _AccountdetailData = AccountdetailModel().obs;

  AccountdetailModel get AccountdetailData => this._AccountdetailData.value;

  changeAccountdetailData(AccountdetailModel value) => this._AccountdetailData.value = value;

  final _isProcessing = false.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;
  final _username = "".obs;

  String get usernameValue => this._username.value;

  changeusername(String value) => this._username.value = value;

  final _password = "".obs;

  String get passwordValue => this._password.value;

  changePassword(String value) => this._password.value = value;
  final _error = "".obs;

  get errorValue => this._error.value;

  changeError(value) => this._error.value = value;



  Future<bool> accountDetailsSC() async {
    bool doneFlage=false;
    try {
      changeProcessing(true);
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if(userInfo!=null && userInfo!='') {
        if (await CommonUtills.ConnectionStatus() == true) {
          AccountdetailModel data = await servicecaller.myaccountdetailData(userInfo);
          if(data.userDetail!=null){
            pref.save("name", data.userDetail.name);
            pref.save("password", data.userDetail.password);
            pref.save("phone", data.userDetail.registeredNo);
            pref.save("email", data.userDetail.emailId);
            pref.save("lname", data.userDetail.lname);
            pref.save("userId", data.userDetail.userId);
            print('myaccountdetail done');
            changeAccountdetailData(data);
            changeProcessing(false);
            doneFlage=true;
          }else{
            changeError("You have not been login successfully!");
          }
        }else{
          changeError("Network not available!");
        }
      }
    } catch (e) {
      changeProcessing(false);
      changeError(e.toString());
    }

    return doneFlage;
  }



}
