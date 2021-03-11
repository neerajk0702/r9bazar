import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import '../model/AddTocartLocal.dart';
import 'BookingSloatModel.dart';
import 'DeliverychargeModel.dart';
import 'GenerateTokenModel.dart';
import 'OrderPlaceModel.dart';
import 'OrderServicescaller.dart';
import 'UpdateOrderPaymentStatusModel.dart';

class OrderController extends GetxController {
  final OrderServicescaller serviceCaller = OrderServicescaller();
  final _BookingSloat = BookingSloatModel().obs;

  BookingSloatModel get BookingSloat => this._BookingSloat.value;

  changeBookingSloatData(BookingSloatModel value) =>
      this._BookingSloat.value = value;

  final _orderList = List<AddTocartLocal>().obs;

  List<AddTocartLocal> get orderList => this._orderList.value;

  changeorderListData(List<AddTocartLocal> value) =>
      this._orderList.assignAll(value);

  final _isProcessing = false.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;

  final _error = "".obs;

  get errorValue => this._error.value;

  changeError(value) => this._error.value = value;

  final _subtotal = "".obs;

  get subtotal => this._subtotal.value;

  changesubtotal(value) => this._subtotal.value = value;

  final _discountAmount = "".obs;

  get discountAmount => this._discountAmount.value;

  changediscountAmount(value) => this._discountAmount.value = value;

  final _totalAmount = "".obs;

  get totalAmount => this._totalAmount.value;

  changetotalAmount(value) => this._totalAmount.value = value;

  final _Deliverycharge = "0".obs;

  get deliverycharge => this._Deliverycharge.value;

  changedeliverycharge(value) => this._Deliverycharge.value = value;

  final _promoCode = "".obs;

  get promoCode => this._promoCode.value;

  changepromoCode(value) => this._promoCode.value = value;

  final _orderID = "".obs;

  get orderID => this._orderID.value;

  changeorderID(value) => this._orderID.value = value;
  final _txnToken = "".obs;

  get txnToken => this._txnToken.value;

  changetxnToken(value) => this._txnToken.value = value;



  final _TXNID = "".obs;

  get TXNID => this._TXNID.value;

  changeTXNID(value) => this._TXNID.value = value;

  final _TXNDATE = "".obs;

  get TXNDATE => this._TXNDATE.value;

  changeTXNDATE(value) => this._TXNDATE.value = value;

  final _RESPMSG = "".obs;

  get RESPMSG => this._RESPMSG.value;

  changeRESPMSG(value) => this._RESPMSG.value = value;


  bool isStaging = true;
  bool restrictAppInvoke = true;



  BookingSlots() async {
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if (await CommonUtills.ConnectionStatus() == true) {
        changeProcessing(false);
        BookingSloatModel data = await serviceCaller.BookingSlots(userInfo);
        changeBookingSloatData(data);
      } else {
        showOfflineToast1();
      }
      changeProcessing(true);
    } catch (e) {
      changeProcessing(false);
      changeError(e.toString());
    }
  }

  String result;

/*  http://localhost:8080/Ecommerce/checkoutAPI?addressid=&slotdate=&slottime=&username=&shipping=&qty[]
  // =&saleRate[]=&patternid[]=&productsno[]=&productName[]=&weight[]=&unit[]=&mainproductsno[]=
  // &grossweight[]=&netweight[]=&Categorysno[]=&purchaserate[]=&mrp[]=&paymentmode=&subtotal
  // =&grandtotal=&promocode=&discountpercent[]=&discountamount[]=*/
  Future<bool> placeOrder(int addressSno, String slotdate, int slottimeSno,
      String username, String shippingAmt, String paymentMode) async {
    bool doneFlage = false;
    try {
      if (await CommonUtills.ConnectionStatus() == true) {
        if (slotdate == null || slotdate == '') {
          changeError("Please select delivery date slot");
          return doneFlage;
        }
        print(slottimeSno);
        if (slottimeSno == 0) {
          changeError("Please select delivery time slot");
          return doneFlage;
        }
        changeProcessing(false);
        List<String> qty = [];
        List<String> saleRate = [];
        List<String> patternid = [];
        List<String> productsno = [];
        List<String> productName = [];
        List<String> weight = [];
        List<String> unit = [];
        List<String> mainproductsno = [];
        List<String> grossweight = [];
        List<String> netweight = [];
        List<String> Categorysno = [];
        List<String> purchaserate = [];
        List<String> mrp = [];
        List<String> discountpercent = [];
        List<String> discountamount = [];

        DBHelper dbHelper = DBHelper();
        List<Map> ListMap = await dbHelper.getAllProducts();
        List<AddTocartLocal> productList = ListMap.isNotEmpty
            ? ListMap.map((c) => AddTocartLocal.fromMap(c)).toList()
            : null;
        if (productList != null) {
          for (var i = 0; i < productList?.length; i++) {
            qty.add(productList[i].quantityLocal.toString());
            saleRate.add(productList[i].saleRate.toString());
            patternid.add(productList[i].patternid.toString());
            productsno.add(productList[i].dsno.toString());
            productName.add(productList[i].productName.toString());
            weight.add(productList[i].weight.toString());
            unit.add(productList[i].unit.toString());
            mainproductsno.add(productList[i].mainproductsno.toString());
            grossweight.add(productList[i].grossweight.toString());
            netweight.add(productList[i].netweight.toString());
            Categorysno.add(productList[i].category.toString());
            purchaserate.add(productList[i].purchaserate.toString());
            discountpercent.add(productList[i].discountpercent.toString());
            String discountAmt = getDiscount(
                productList[i].saleRate,
                productList[i].discountpercent,
                productList[i].quantityLocal,
                productList[i]);
            if (discountAmt != null) {
              discountamount.add(discountAmt);
            } else {
              discountamount.add('0');
            }
            mrp.add(productList[i].mrp.toString());
          }
        }
        String subtotal = getSubtotal(productList);
        // String discount = getTotalDiscount(productList);
        String grandtotal = getFinalAmount(productList);

        String url =
            "${Constants.AppBaseUrl}checkoutAPI?addressid=${addressSno}&slotdate=${slotdate}&slottime=${slottimeSno}&username=${username}&shipping=${shippingAmt}&qty[]=${qty.join(', ')}&saleRate[]=${saleRate.join(', ')}&patternid[]=${patternid.join(', ')}&productsno[]=${productsno.join(', ')}&productName[]=${productName.join(', ')}&weight[]=${weight.join(', ')}&unit[]=${unit.join(', ')}&mainproductsno[]=${mainproductsno.join(', ')}&grossweight[]=${grossweight.join(', ')}&netweight[]=${netweight.join(', ')}&Categorysno[]=${Categorysno.join(', ')}&purchaserate[]=${purchaserate.join(', ')}&mrp[]=${mrp.join(', ')}&paymentmode=${paymentMode}&subtotal=${subtotal}&grandtotal=${grandtotal}&promocode=${promoCode}&discountpercent[]=${discountpercent.join(', ')}&discountamount[]=${discountamount.join(', ')}";
        print(url);
        OrderPlaceModel placedata = await serviceCaller.placeOrders(url);
        if (placedata != null && placedata.status == "true") {
          changeorderID(placedata.orderno);
          changetotalAmount(grandtotal);
          if (await generateToken(username)) {
            doneFlage = true;
            changeProcessing(true);
          } else {
            doneFlage = false;
            changeProcessing(true);
          }
        }
        else {
          changeError(placedata.message);
          print("placedata.message");
          changeProcessing(true);
        }
      } else {
        showOfflineToast1();
      }
    } catch (e) {
      changeProcessing(true);
      changeError(e.toString());
    }
    return doneFlage;
  }
  //genrate tnx token
  Future<bool> generateToken(String username) async {
    bool doneFlage = false;
    try {
      GenerateTokenModel tokendata =
      await serviceCaller.generateTokenCall(orderID, totalAmount, username);
      if (tokendata != null && tokendata.body.resultInfo.resultStatus == 'S') {
        changetxnToken(tokendata.body.txnToken);
        doneFlage = true;
      } else {
        changeError("txn Token not found");
        print("body.resultInfo.resultStatus");
      }
    }catch (e) {
      changeError(e.toString());
    }
    return doneFlage;
  }

  Future<bool> UpdateOrderPaymentStatus()async{
    bool doneFlage = false;
    try {
      UpdateOrderPaymentStatusModel updateOrder = await serviceCaller
          .UpdateOrderPaymentStatus(orderID, TXNID, TXNDATE, RESPMSG);
      if (updateOrder != null && updateOrder.status == "true") {
        changeError("Your order has been placed successfully");
        doneFlage = true;
        print("Your order has been placed successfully");
        changeProcessing(true);
      } else {
        changeError("Something went wrong with Update Order Payment Status!");
        print("Something went wrong with Update Order Payment Status!");
        changeProcessing(true);
      }
    }catch (e) {
      changeError(e.toString());
    }
    return doneFlage;
  }

  Future<bool> placeOrderCOD(int addressSno, String slotdate, int slottimeSno,
      String username, String shippingAmt, String paymentMode) async {
    bool doneFlage = false;
    try {
      if (await CommonUtills.ConnectionStatus() == true) {
        if (slotdate == null || slotdate == '') {
          changeError("Please select delivery date slot");
          return doneFlage;
        }
        print(slottimeSno);
        if (slottimeSno == 0) {
          changeError("Please select delivery time slot");
          return doneFlage;
        }
        changeProcessing(false);
        List<String> qty = [];
        List<String> saleRate = [];
        List<String> patternid = [];
        List<String> productsno = [];
        List<String> productName = [];
        List<String> weight = [];
        List<String> unit = [];
        List<String> mainproductsno = [];
        List<String> grossweight = [];
        List<String> netweight = [];
        List<String> Categorysno = [];
        List<String> purchaserate = [];
        List<String> mrp = [];
        List<String> discountpercent = [];
        List<String> discountamount = [];

        DBHelper dbHelper = DBHelper();
        List<Map> ListMap = await dbHelper.getAllProducts();
        List<AddTocartLocal> productList = ListMap.isNotEmpty
            ? ListMap.map((c) => AddTocartLocal.fromMap(c)).toList()
            : null;
        if (productList != null) {
          for (var i = 0; i < productList?.length; i++) {
            qty.add(productList[i].quantityLocal.toString());
            saleRate.add(productList[i].saleRate.toString());
            patternid.add(productList[i].patternid.toString());
            productsno.add(productList[i].dsno.toString());
            productName.add(productList[i].productName.toString());
            weight.add(productList[i].weight.toString());
            unit.add(productList[i].unit.toString());
            mainproductsno.add(productList[i].mainproductsno.toString());
            grossweight.add(productList[i].grossweight.toString());
            netweight.add(productList[i].netweight.toString());
            Categorysno.add(productList[i].category.toString());
            purchaserate.add(productList[i].purchaserate.toString());
            discountpercent.add(productList[i].discountpercent.toString());
            String discountAmt = getDiscount(
                productList[i].saleRate,
                productList[i].discountpercent,
                productList[i].quantityLocal,
                productList[i]);
            if (discountAmt != null) {
              discountamount.add(discountAmt);
            } else {
              discountamount.add('0');
            }
            mrp.add(productList[i].mrp.toString());
          }
        }
        String subtotal = getSubtotal(productList);
        // String discount = getTotalDiscount(productList);
        String grandtotal = getFinalAmount(productList);

        String url =
            "${Constants.AppBaseUrl}checkoutAPI?addressid=${addressSno}&slotdate=${slotdate}&slottime=${slottimeSno}&username=${username}&shipping=${shippingAmt}&qty[]=${qty.join(', ')}&saleRate[]=${saleRate.join(', ')}&patternid[]=${patternid.join(', ')}&productsno[]=${productsno.join(', ')}&productName[]=${productName.join(', ')}&weight[]=${weight.join(', ')}&unit[]=${unit.join(', ')}&mainproductsno[]=${mainproductsno.join(', ')}&grossweight[]=${grossweight.join(', ')}&netweight[]=${netweight.join(', ')}&Categorysno[]=${Categorysno.join(', ')}&purchaserate[]=${purchaserate.join(', ')}&mrp[]=${mrp.join(', ')}&paymentmode=${paymentMode}&subtotal=${subtotal}&grandtotal=${grandtotal}&promocode=${promoCode}&discountpercent[]=${discountpercent.join(', ')}&discountamount[]=${discountamount.join(', ')}";
        print(url);
        OrderPlaceModel placedata = await serviceCaller.placeOrders(url);
        if (placedata != null && placedata.status == "true") {
          changeorderID(placedata?.orderno);
          doneFlage = true;
          changeError("Your order has been placed successfully");
        } else {
          changeError(placedata.message);
        }
        changeProcessing(true);
      } else {
        showOfflineToast1();
      }
    } catch (e) {
      changeProcessing(true);
      changeError(e.toString());
    }
    return doneFlage;
  }

  ShipmentCharge(String subtotal, List<AddTocartLocal> productList) async {
    try {
      if (await CommonUtills.ConnectionStatus() == true) {
        String currentDate = CommonUtills.getCurentDate();
        DeliverychargeModel data =
            await serviceCaller.ShipmentCharge(currentDate, subtotal);
        changedeliverycharge(data.deliverycharge.toString());
        String totalAmount = getFinalAmount(productList);
        changetotalAmount(totalAmount);
      } else {
        showOfflineToast1();
      }
    } catch (e) {
      changeError(e.toString());
    }
  }

  getOrderDetails() async {
    try {
      DBHelper dbHelper = DBHelper();
      // List<AddTocartLocal> productList=(await dbHelper.getAllProduct()).cast<AddTocartLocal>();
      List<Map> ListMap = await dbHelper.getAllProducts();
      List<AddTocartLocal> productList = ListMap.isNotEmpty
          ? ListMap.map((c) => AddTocartLocal.fromMap(c)).toList()
          : null;
      String subtotal = getSubtotal(productList);
      String discount = getTotalDiscount(productList);
      changesubtotal(subtotal);
      changediscountAmount(discount);
      changeorderListData(productList);
      ShipmentCharge(subtotal, productList);
    } catch (e) {
      changeError(e.toString());
    }
  }

  //calculate total amount
  String getSubtotal(List<AddTocartLocal> data) {
    double totalSaleRate = 0;
    for (var i = 0; i < data?.length; i++) {
      double tempSaleRate =
          double.parse(gettotalAmount(data[i].saleRate, data[i].quantityLocal));
      totalSaleRate = totalSaleRate + tempSaleRate;
    }
    return totalSaleRate.toString();
  }

  //calculate total discount amount
  String getTotalDiscount(List<AddTocartLocal> data) {
    double total = 0;
    for (var i = 0; i < data?.length; i++) {
      double totalsalerate =
          double.parse(gettotalAmount(data[i].saleRate, data[i].quantityLocal));
      double totaldiscountRate =
          (totalsalerate * data[i].discountpercent) / 100;
      total = total + totaldiscountRate;
    }
    return total.toString();
  }

  String getFinalAmount(List<AddTocartLocal> data) {
    double totalSaleRate = 0;
    double finalDisAmount = 0;
    double finalAmount = 0;
    for (var i = 0; i < data?.length; i++) {
      //sale amount
      double tempSaleRate = double.parse(gettotalAmount(data[i].saleRate,
          data[i].quantityLocal)); //data[i].saleRate * data[i].totalNetweight;
      totalSaleRate = totalSaleRate + tempSaleRate;
      //discount
      double totaldiscountRate = (tempSaleRate * data[i].discountpercent) / 100;
      finalDisAmount = finalDisAmount + totaldiscountRate;
    }
    finalAmount = totalSaleRate - finalDisAmount - int.parse(deliverycharge);
    return finalAmount.toString();
  }

  //calculate discount
  String getDiscount(
      double saleRate, double discount, double quty, AddTocartLocal data) {
    double totalsalerate = double.parse(gettotalAmount(saleRate, quty));
    double totaldiscountRate = (totalsalerate * discount) / 100;
    return totaldiscountRate.toString();
  }

  //calculate total amount
  String gettotalAmount(double saleRate, double quty) {
    double totalsalerate = 0;
    if (quty != null && quty > 1) {
      for (int i = 0; i < quty; i++) {
        totalsalerate = totalsalerate + saleRate;
      }
    } else {
      totalsalerate = saleRate;
    }

    return totalsalerate.toString();
  }
}
