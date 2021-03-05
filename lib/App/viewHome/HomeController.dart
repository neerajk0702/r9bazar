import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/Home/homeservicecaller.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/model/FlashSaleReportModel.dart';
import 'package:rbazaar/App/model/HotdealModel.dart';
import 'package:rbazaar/App/orderplace/UpdateOrderPaymentStatusModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'MyOrderServicecaller.dart';



class HomeController extends GetxController {
  final servicecaller = HomeServiceCaller();
  final _HotdealModelData = HotdealModel().obs;

  HotdealModel get HotdealModelData => this._HotdealModelData.value;

  changeHotdealModel(HotdealModel value) => this._HotdealModelData.value = value;

  final _FlashSaleReportModel = FlashSaleReportModel().obs;

  FlashSaleReportModel get FlashSaleReportModelData => this._FlashSaleReportModel.value;

  changeFlashSaleReportModel(FlashSaleReportModel value) => this._FlashSaleReportModel.value = value;

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

  final _Reason = "".obs;

  get Reason => this._Reason.value;

  changeReason(value) => this._Reason.value = value;

  Future<bool> hotDealSC() async {
    bool doneFlage=false;
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
        if (await CommonUtills.ConnectionStatus() == true) {
          changeProcessing(false);
          HotdealModel hotdeal = await servicecaller.getHotDeal();
          changeHotdealModel(hotdeal);
          changeProcessing(true);
          doneFlage=true;
        }else{
          showOfflineToast1();
        }
        changeProcessing(true);
    } catch (e) {
      changeProcessing(false);
      changeError(e.toString());
    }

    return doneFlage;
  }
  Future<bool> flaseSaleSC() async {
    bool doneFlage=false;
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if (await CommonUtills.ConnectionStatus() == true) {
        changeProcessing(false);
        FlashSaleReportModel flashsale = await servicecaller.getflashsale();
        changeFlashSaleReportModel(flashsale);
        changeProcessing(true);
        doneFlage=true;
      }else{
        showOfflineToast1();
      }
      changeProcessing(true);
    } catch (e) {
      changeProcessing(false);
      changeError(e.toString());
    }

    return doneFlage;
  }
}
