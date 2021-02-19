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


class LoginController extends GetxController {
  LoginController();
  final AuthServicecaller serviceCaller = AuthServicecaller();
  final _loginData = LoginModel().obs;

  LoginModel get LoginData => this._loginData.value;

  changeLoginData(LoginModel value) => this._loginData.value = value;

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



  Future<bool> loginSC() async {
    bool doneFlage=false;

    if (usernameValue == null || usernameValue == '') {
      changeError("Please enter user name");
      return doneFlage;
    }
    if (passwordValue == null || passwordValue == '') {
      changeError("Please enter your password");
      return doneFlage;
    }
      try {
        changeProcessing(true);
        LoginModel data = await serviceCaller.login(usernameValue, passwordValue);
        if (data != null && data.status=='success') {
          SharedPref pref = SharedPref();
          if(data.userDetail!=null){
            pref.save("name", data.userDetail.name);
            pref.save("password", data.userDetail.password);
            pref.save("phone", data.userDetail.registeredNo);
            pref.save("email", data.userDetail.emailId);
            pref.save("lname", data.userDetail.lname);
            pref.save("userId", data.userDetail.userId);
            changeLoginData(data);
            changeProcessing(false);
            print('loginSC done');
            doneFlage=true;
            changeError("You have been login successfully");
          }else{
            changeError("You have not been login successfully!");
            doneFlage=false;
            changeProcessing(false);
          }
        }else{
          changeError("You have not been login successfully!");
          doneFlage=false;
          changeProcessing(false);
        }
      } catch (e) {
        changeProcessing(false);
        changeError(e.toString());
        doneFlage=false;
        changeProcessing(false);
      }

    return doneFlage;
  }



}
