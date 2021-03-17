import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/orderplace/UpdateOrderPaymentStatusModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'DeliveryOrderModel.dart';
import 'DeliveryServicecaller.dart';




class DeliveryController extends GetxController {
  final DeliveryServicecaller serviceCaller = DeliveryServicecaller();
  final _DeliveryOrder = DeliveryOrderModel().obs;

  DeliveryOrderModel get deliveryOrderData => this._DeliveryOrder.value;

  changeDeliveryOrderData(DeliveryOrderModel value) => this._DeliveryOrder.value = value;

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

  Future<bool> orderlistSC() async {
    bool doneFlage=false;
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if(userInfo!=null && userInfo!='') {
        if (await CommonUtills.ConnectionStatus() == true) {
          changeProcessing(false);
          DeliveryOrderModel data = await serviceCaller.getOrderList(userInfo);
          changeDeliveryOrderData(data);
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

  /*Future<bool> CancelOrder(int sno,int saleID,String orderID,String reason,String userID) async {
    bool doneFlage=false;
    try {
      if(reason.length<=10){
        changeError("Please enter reason for cancel your order more then 10 words!");
        return doneFlage;
      }
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if(userInfo!=null && userInfo!='') {
        if (await CommonUtills.ConnectionStatus() == true) {
          changeProcessing(false);
          UpdateOrderPaymentStatusModel data = await serviceCaller.CancelOrderSC( sno, saleID, orderID, reason, userID);
          if(data!=null && data.status=='true'){
            doneFlage=true;
            changeReason("");
            changeError("Your order has been Canceled successfully");
          }else{
            changeError("Your order has not been Canceled!");
          }
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
  }*/
}
