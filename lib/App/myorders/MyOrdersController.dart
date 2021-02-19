import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'MyOrderServicecaller.dart';



class MyOrdersController extends GetxController {
  final MyOrderServicecaller serviceCaller = MyOrderServicecaller();
  final _AccountdetailData = AccountdetailModel().obs;

  AccountdetailModel get AccountdetailData => this._AccountdetailData.value;

  changeAccountdetailData(AccountdetailModel value) => this._AccountdetailData.value = value;

  final _isProcessing = false.obs;

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

  Future<bool> accountDetailsSC() async {
    bool doneFlage=false;
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if(userInfo!=null && userInfo!='') {
        if (await CommonUtills.ConnectionStatus() == true) {
          changeProcessing(false);
          AccountdetailModel data = await serviceCaller.myaccountdetailData(userInfo);
          changeAccountdetailData(data);
         /* if(data.userDetail!=null){
            pref.save("name", data.userDetail.name);
            pref.save("password", data.userDetail.password);
            pref.save("phone", data.userDetail.registeredNo);
            pref.save("email", data.userDetail.emailId);
            pref.save("lname", data.userDetail.lname);
            pref.save("userId", data.userDetail.userId);
            changeAccountdetailData(data);
            doneFlage=true;
          }else{
            changeError("No data found!");
          }*/
          changeProcessing(true);
        }else{
          showOfflineToast1();
        }
        changeProcessing(true);
      }
    } catch (e) {
      changeProcessing(false);
      changeError(e.toString());
    }

    return doneFlage;
  }
}
