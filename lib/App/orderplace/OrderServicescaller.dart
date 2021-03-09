import 'package:dio/dio.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'BookingSloatModel.dart';
import 'DeliverychargeModel.dart';
import 'GenerateTokenModel.dart';
import 'OrderPlaceModel.dart';
import 'UpdateOrderPaymentStatusModel.dart';


class OrderServicescaller {
  BookingSlots(String userName) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}BookingSlots"
      );
      print('url= ' + "${Constants.AppBaseUrl}BookingSlots");
      return BookingSloatModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("BookingSlots service caller error " + message);
      throw (message);
    }
  }

  ShipmentCharge(String sloatDate, String totalAmount) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants
              .AppBaseUrl}ShipmentChargeAPI?currentdate=${sloatDate}&totalamount=${totalAmount}"
      );
      print('url= ' + "${Constants
          .AppBaseUrl}ShipmentChargeAPI?currentdate=${sloatDate}&totalamount=${totalAmount}");
      return DeliverychargeModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("ShipmentCharge service caller error " + message);
      throw (message);
    }
  }

  placeOrders(String urlwithPayload) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(urlwithPayload);
      print(response.data);
      return OrderPlaceModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("placeOrders service caller error " + message);
      throw (message);
    }
  }

//generate token for payment throough paytm gatway
  generateTokenCall(String orderID, String amount, String customerId) async {
    Dio dio = await getInterceptors();
    try {
      http://r9bazaar.com/PaytmTaxid?ORDER_ID=21443&CUST_ID=23&TXN_AMOUNT=2
      Response response = await dio.post("${Constants.AppBaseUrl}PaytmTaxid?ORDER_ID=${orderID}&CUST_ID=${customerId}&TXN_AMOUNT=${amount}"
      );
      print('response= ' + response.toString());
      return GenerateTokenModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("generateTokenCall service caller error " + message);
      throw (message);
    }
  }
  UpdateOrderPaymentStatus(String ORDER_ID, String TXNID,String TXNDATE,String RESPMSG) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants
              .AppBaseUrl}UpdateOrderPaymentStatusAPI?ORDER_ID=${ORDER_ID}&TXNID=${TXNID}&TXNDATE=${TXNDATE}&RESPMSG=${RESPMSG}"
      );
      print('url= ' + "${Constants
          .AppBaseUrl}UpdateOrderPaymentStatusAPI?ORDER_ID=${ORDER_ID}&TXNID=${TXNID}&TXNDATE=${TXNDATE}&RESPMSG=${RESPMSG}");
      return UpdateOrderPaymentStatusModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("ShipmentCharge service caller error " + message);
      throw (message);
    }
  }

}
