import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/App/orderplace/UpdateOrderPaymentStatusModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'SearchProductModel.dart';
import 'SearchProductServicecaller.dart';



class SearchProductController extends GetxController {
  final SearchProductServicecaller serviceCaller = SearchProductServicecaller();
  final _productData = SearchProductModel().obs;

  SearchProductModel get productData => this._productData.value;

  changeProductData(SearchProductModel value) => this._productData.value = value;

  final _isProcessing = false.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;

  final _error = "".obs;

  get errorValue => this._error.value;
  changeError(value) => this._error.value = value;

/*  final _productname = "".obs;

  get productname => this._productname.value;
  changeproductname(value) => this._productname.value = value;*/


  Future<bool> searchProduct(String productName) async {
    bool doneFlage=false;
    try {
        if (await CommonUtills.ConnectionStatus() == true) {
          changeProcessing(false);
          SearchProductModel data = await serviceCaller.searchProduct(productName);
          var dbHelper = DBHelper();
          // var total=getTotalItemNo();
          List<Map> ListMap = await dbHelper.getAllProducts();
          List<AddTocartLocal> productList = ListMap.isNotEmpty
              ? ListMap.map((c) => AddTocartLocal.fromMap(c)).toList()
              : null;
          if (productList != null && productList.length>0) {
            data.totalItem=productList.length;
            for (var i = 0; i <data?.products?.length; i++) {
              for (var j = 0; j < productList.length; j++) {
                if (productList[j].dsno ==data?.products[i].dsno) {
                  data?.products[i].dbnetweight =productList[j].totalNetweight;
                  data?.products[i].dbQuantityLocal =productList[j].quantityLocal;
                }
              }
            }
          }
          changeProductData(data);
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
