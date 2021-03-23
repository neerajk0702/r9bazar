import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Auth/AuthServicecaller.dart';
import 'package:rbazaar/App/Auth/LoginModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/orderplace/OrderPlaceModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'DeliveryLoginModel.dart';
import 'RoleModel.dart';


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

  final _deliveryLogin = "".obs;

  get deliveryLogin => this._deliveryLogin.value;

  changedeliveryLogin(value) => this._deliveryLogin.value = value;

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
        SharedPref pref = SharedPref();
        var deviceId = await pref.read("DEVICETOKEN");
        RoleModel roledata = await serviceCaller.RoleSC(usernameValue);
        if(roledata!=null && roledata?.role!=null){
          if(roledata?.role?.role=='1' && roledata?.role?.role1=="") { //delivery boy login
            DeliveryLoginModel data = await serviceCaller.deliveryBoylogin(usernameValue, passwordValue,deviceId);
            if (data != null && data.status=='success') {
              SharedPref pref = SharedPref();
              if(data.deliveryBoyDetail!=null){
                pref.save("name", data.deliveryBoyDetail.deliveryBoyName);
                pref.save("password", data.deliveryBoyDetail.deliveryBoypassword);
                pref.save("phone", data.deliveryBoyDetail.deliveryBoyMobile);
                pref.save("deliveryLogin", '1');
                // pref.save("email", data.deliveryBoyDetail.emailId);
                // pref.save("lname", data.deliveryBoyDetail.lname);
                pref.save("userId", data.deliveryBoyDetail.deliveryBoyUsername);
                // changeLoginData(data);
                changeProcessing(false);
                changedeliveryLogin('1');
                print('loginSC done');
                doneFlage=true;
                changeError("You have been login successfully");
              }else{
                changeError("User name or password incorrect !");
                doneFlage=false;
                changeProcessing(false);
              }
            }else{
              changeError("You have not been login successfully!");
              doneFlage=false;
              changeProcessing(false);
            }
          }
          else { //user login
            LoginModel data = await serviceCaller.login(usernameValue, passwordValue,deviceId);
            if (data != null && data.status=='success') {
              SharedPref pref = SharedPref();
              if(data.userDetail!=null){
                pref.save("name", data.userDetail.name);
                pref.save("password", data.userDetail.password);
                pref.save("phone", data.userDetail.registeredNo);
                pref.save("email", data.userDetail.emailId);
                pref.save("lname", data.userDetail.lname);
                pref.save("userId", data.userDetail.userId);
                pref.save("deliveryLogin", '0');
                changeLoginData(data);
                changeProcessing(false);
                changedeliveryLogin('0');
                print('loginSC done');
                doneFlage=true;
                changeError("You have been login successfully");
              }else{
                changeError("User name or password incorrect !");
                doneFlage=false;
                changeProcessing(false);
              }
            }else{
              changeError("You have not been login successfully!");
              doneFlage=false;
              changeProcessing(false);
            }
          }
        }else{
          changeError("Role API issue contact to support team!");
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

  Future<bool> forgotPassword() async {
    bool doneFlage=false;

    if (usernameValue == null || usernameValue == '') {
      changeError("Please enter your phone number");
      return doneFlage;
    }
    if (usernameValue.length<10) {
      changeError("Please enter valid phone number");
      return doneFlage;
    }
    try {
      changeProcessing(true);
      OrderPlaceModel data = await serviceCaller.forgotPassword(usernameValue);
      if (data != null && data.status=='true') {
        changeProcessing(false);
        doneFlage=true;
        changeError(data.message);
      }else{
        changeError("Somthing wrong with this phone number!");
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
