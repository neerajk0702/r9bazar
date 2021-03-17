import 'package:dio/dio.dart';
import 'package:rbazaar/App/Home/LocationModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'DeliveryOrderModel.dart';


class DeliveryServicecaller {


  getOrderList(phone) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio
          .post("${Constants.AppBaseUrl}DeliveryBoyOrderdetailAPI?couriername=&mobileno=&city=&deliverydate=&state=&courierid=0&orderby=&stateid=0&cityid=0&orderid=&orderstatus=&allotedstatus=&deliveryboy=${'1234567890'}&courierdeliveredstatus=&fromdate=&todate=");
      print(
          'url= ' + "${Constants.AppBaseUrl}DeliveryBoyOrderdetailAPI?couriername=&mobileno=&city=&deliverydate=&state=&courierid=0&orderby=&stateid=0&cityid=0&orderid=&orderstatus=&allotedstatus=&deliveryboy=${phone}&courierdeliveredstatus=&fromdate=&todate=");
      return DeliveryOrderModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("getOrderList service caller error " + message);
      throw (message);
    }
  }

/*
  getAllCitylistSC(int sno) async {
    Dio dio = await getInterceptors();
    try {
      Response response =
      await dio.post("${Constants.AppBaseUrl}StateWiseCity?stateid=${sno}");

      CityModel responsedata = CityModel.fromJson(response.data);
      print("getAllCitylistSC  ");
      return responsedata;
    } on DioError catch (error) {
      String message = error.message;
      print("getAllCitylistSC service caller error " + message);
      throw (message);
    }
  }*/


}
