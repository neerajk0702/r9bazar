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


class SignupController extends GetxController {
  SignupController();
  final AuthServicecaller serviceCaller = AuthServicecaller();
  final _loginData = SignUpModel().obs;

  SignUpModel get signupData => this._loginData.value;

  changeSignupData(SignUpModel value) => this._loginData.value = value;

  final _isProcessing = false.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;


  final _password = "".obs;

  String get passwordValue => this._password.value;

  changePassword(String value) => this._password.value = value;
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





  Future<bool> signup() async {
    bool doneFlage=false;

    if (firstname == null || firstname == '') {
      changeError("Please enter your first name!");
      return doneFlage;
    }
    if (lastnamevalue == null || lastnamevalue == '') {
      changeError("Please enter your last name!");
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
    if (phoneValue == null || phoneValue == '') {
      changeError("Please enter your phone number!");
      return doneFlage;
    }
    if (passwordValue == null || passwordValue == '') {
      changeError("Please enter your password");
      return doneFlage;
    }
    try {
      changeProcessing(true);
      SignUpModel data = await serviceCaller.signUPSC(firstname, lastnamevalue,emailValue,phoneValue,passwordValue);
      if (data != null && data.status=='success') {
        changeSignupData(data);
        changeProcessing(false);
        print('signup done');
        doneFlage=true;
        changeError("You have been Register successfully");
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


/*  Future<bool> saveAddress() async {
    if (await CommonUtills.ConnectionStatus() == true) {
      try {
        // changeProcessing(false);
        if (fullnameValue == null || fullnameValue == '') {
          changeError("Enter Full Name");
          return false;
        } if (phoneValue == null || phoneValue == '') {
          changeError("Enter Phone");
          return false;
        }
        if (flatNoValue == null || flatNoValue == '') {
          changeError("Enter House/Flat No");
          return false;
        }
        if (towerValue == null || towerValue == '') {
          changeError("Enter Building Name/Tower");
          return false;
        }
        if (streetValue == null || streetValue == '') {
          changeError("Enter Street");
          return false;
        }
        if (sectorValue == null || sectorValue == '') {
          changeError("Enter Locality/Sector");
          return false;
        }
        if (landmarkValue == null || landmarkValue == '') {
          changeError("Enter Landmark");
          return false;
        }
        if (pinkcodeValue == null || pinkcodeValue == '') {
          changeError("Enter Pincode");
          return false;
        }
        if (selectedStateData == null ) {
          changeError("Select State");
          return false;
        }
        if (selectedCityData == null ) {
          changeError("Select city");
          return false;
        }
        String address=flatNoValue+" "+towerValue+" "+streetValue+" "+sectorValue;
        String location="";
        String userName="7905594742";
        SaveAddressModel data = await serviceCaller.saveAddressSC(userName,address,landmarkValue,pinkcodeValue,fullnameValue,phoneValue,location,selectedStateData,selectedCityData);
        if (data != null && data?.status!=null && data?.status=='Saved Successfully') {
          changeProcessing(true);
           CommonUtills.flutterToast(data?.status);
          changeIsSaveAddress(true);

          return true;
        }else{
          changeProcessing(true);
           CommonUtills.flutterToast("data?.status");
          changeIsSaveAddress(false);
          return false;
        }
      } catch (e) {
        changeIsSaveAddress(false);
        changeProcessing(true);
         CommonUtills.flutterToast(e.toString());
        return false;
      }
    } else {
      showOfflineToast1();
    }
  }*/
}
