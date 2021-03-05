import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Auth/AuthServicecaller.dart';
import 'package:rbazaar/App/Auth/LoginModel.dart';
import 'package:rbazaar/App/Auth/SignUpModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'ChangePasswordServicecaller.dart';


class ChangePasswordController extends GetxController {
  ChangePasswordController();
  final ChangePasswordServicecaller serviceCaller = ChangePasswordServicecaller();
  final _loginData = LoginModel().obs;

  LoginModel get passwordData => this._loginData.value;

  changepasswordData(LoginModel value) => this._loginData.value = value;

  final _isProcessing = false.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;


  final _oldpassword = "".obs;

  String get oldpasswordValue => this._oldpassword.value;

  changeOldPassword(String value) => this._oldpassword.value = value;
  final _error = "".obs;

  get errorValue => this._error.value;

  changeError(value) => this._error.value = value;

  final _newPassword = "".obs;

  get newPassword => this._newPassword.value;

  changenewPassword(value) => this._newPassword.value = value;


  Future<bool> ChangePassword(String userName) async {
    bool doneFlage=false;

    if (oldpasswordValue == null || oldpasswordValue == '') {
      changeError("Please enter your old password!");
      return doneFlage;
    }
    if (newPassword == null || newPassword == '') {
      changeError("Please enter your new password!");
      return doneFlage;
    }
  /*  if (oldpasswordValue!=newPassword) {
      changeError("Your old password and new password dose not match!");
      return doneFlage;
    }*/
    try {
      changeProcessing(true);
      LoginModel data = await serviceCaller.changePasswordSC(userName, oldpasswordValue,newPassword);
      if (data != null ) {
        changepasswordData(data);
        changeProcessing(false);
        doneFlage=true;
        changeError("Your new password changed successfully");
      }else{
        changeError(data?.status);
        changeProcessing(false);
        doneFlage=false;
      }
    } catch (e) {
      changeProcessing(false);
      doneFlage=false;
      changeError(e.toString());
    }

    return doneFlage;
  }

}
