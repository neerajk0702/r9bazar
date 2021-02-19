import 'package:dio/dio.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'BookingSloatModel.dart';
import 'DeliverychargeModel.dart';
import 'OrderPlaceModel.dart';


class OrderServicescaller {
  BookingSlots(String userName) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}BookingSlots"
      );
      print('url= '+"${Constants.AppBaseUrl}BookingSlots");
      return BookingSloatModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("BookingSlots service caller error "+message);
      throw (message);
    }
  }
  ShipmentCharge(String sloatDate,String totalAmount) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}ShipmentChargeAPI?currentdate=${sloatDate}&totalamount=${totalAmount}"
      );
      print('url= '+"${Constants.AppBaseUrl}ShipmentChargeAPI?currentdate=${sloatDate}&totalamount=${totalAmount}");
      return DeliverychargeModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("ShipmentCharge service caller error "+message);
      throw (message);
    }
  }
  placeOrders(String urlwithPayload) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(urlwithPayload);
      return OrderPlaceModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("placeOrders service caller error "+message);
      throw (message);
    }
  }
}
