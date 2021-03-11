import 'package:dio/dio.dart';
import 'package:rbazaar/App/Auth/LoginModel.dart';
import 'package:rbazaar/App/Auth/SignUpModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/orderplace/OrderPlaceModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'RoleModel.dart';


class AuthServicecaller {
  login(String phone,String password,String deviceId) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio
          .post("${Constants.AppBaseUrl}login?username=${phone}&password=${password}&deviceid=${deviceId}");
      print(
          'login url= ' + "${Constants.AppBaseUrl}login?username=${phone}&password=${password}&deviceid=${deviceId}");
      return LoginModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("login service caller error " + message);
      throw (message);
    }
  }
  deliveryBoylogin(String phone,String password,String deviceId) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio
          .post("${Constants.AppBaseUrl}dloginvalidationAPI?username=${phone}&password=${password}&deviceid=${deviceId}");
      print(
          'deliveryBoylogin url= ' + "${Constants.AppBaseUrl}dloginvalidationAPI?username=${phone}&password=${password}&deviceid=${deviceId}");
      return LoginModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("deliveryBoylogin service caller error " + message);
      throw (message);
    }
  }

  signUPSC(String name,String lastname,String email,String phone,String password) async {
    Dio dio = await getInterceptors();
    try {
      print("${Constants.AppBaseUrl}registration?Referral=&name=${name}&mail=${email}&phone=${phone}&pas=${password}&lname=${lastname}");
      Response response = await dio.post(
          "${Constants.AppBaseUrl}registration?Referral=&name=${name}&mail=${email}&phone=${phone}&pas=${password}&lname=${lastname}");

      SignUpModel responsedata = SignUpModel.fromJson(response.data);
      return responsedata;
    } on DioError catch (error) {
      String message = error.message;
      print("signUPSC service caller error " + message);
      throw (message);
    }
  }

  forgotPassword(String phone) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio
          .post("${Constants.AppBaseUrl}ForgetPassAPI?mobile=${phone}");
      print(
          'login url= ' + "${Constants.AppBaseUrl}ForgetPassAPI?mobile=${phone}");
      print(response.data);
      return OrderPlaceModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("forgotPassword service caller error " + message);
      throw (message);
    }
  }


  RoleSC(String phone) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio
          .post("${Constants.AppBaseUrl}RoleAPI?mobileno=${phone}");
      print(
          'RoleSC url= ' + "${Constants.AppBaseUrl}RoleAPI?mobileno=${phone}");
      return RoleModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("RoleSC service caller error " + message);
      throw (message);
    }
  }
}
