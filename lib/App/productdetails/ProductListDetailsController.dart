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

import 'ProductDetailsModel.dart';
import 'ProductListServicecaller.dart';


class ProductListDetailsController extends GetxController {
  final ProductListServicecaller serviceCaller = ProductListServicecaller();
  final _productData = ProductDetailsModel().obs;

  ProductDetailsModel get productData => this._productData.value;

  changeProductData(ProductDetailsModel value) => this._productData.value = value;

  final _isProcessing = false.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;

  final _error = "".obs;

  get errorValue => this._error.value;
  changeError(value) => this._error.value = value;



  Future<bool> getProductListData(productsno, catId) async {
    bool doneFlage=false;
    try {
      if (await CommonUtills.ConnectionStatus() == true) {
        changeProcessing(false);

        ProductDetailsModel subcategoriesModel =await serviceCaller.getProductList(productsno, catId);
        var dbHelper = DBHelper();
        // var total=getTotalItemNo();
        List<Map> ListMap = await dbHelper.getAllProducts();
        List<AddTocartLocal> productList = ListMap.isNotEmpty
            ? ListMap.map((c) => AddTocartLocal.fromMap(c)).toList()
            : null;
        if (productList != null && productList.length>0) {
          subcategoriesModel.totalItem=productList.length;
          for (var i = 0; i < subcategoriesModel?.subproducts.length; i++) {
            for (var j = 0; j < productList.length; j++) {
              if (productList[j].dsno ==subcategoriesModel?.subproducts[i].dsno) {
                subcategoriesModel?.subproducts[i].dbnetweight =productList[j].totalNetweight;
                subcategoriesModel?.subproducts[i].dbQuantityLocal =productList[j].quantityLocal;
              }
            }
          }
        }
        changeProductData(subcategoriesModel);
      }else{
        showOfflineToast1();
      }
      changeProcessing(true);
    } catch (e) {
      changeProcessing(true);
      changeError(e.toString());
    }

    return doneFlage;
  }

  Future<int> getTotalItemNo() async {
    int totalItem = 0;
    var dbHelper = DBHelper();
    var list = await dbHelper.getAllProduct();
    if (list != null && list.length > 0) {
      totalItem = list.length;
    }
    return totalItem;
  }
}
