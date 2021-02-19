import 'package:dio/dio.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'AddressModel.dart';
import 'CityModel.dart';
import 'SaveAddressModel.dart';

class AddressServicecaller {
  getAddressList(phone) async {
    Dio dio = await getInterceptors();
    try {
      // print('neeraj');
      Response response = await dio
          .post("${Constants.AppBaseUrl}UserAddressList?username=${phone}");
      print(
          'url= ' + "${Constants.AppBaseUrl}UserAddressList?username=${phone}");
      print('neeraj');
      return AddressModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("getAddressList service caller error " + message);
      throw (message);
    }
  }

  getAllstatelistSC() async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post("${Constants.AppBaseUrl}Allstatelist");

      StateModel responsedata = StateModel.fromJson(response.data);
      print("getAllstatelistSC  ");
      return responsedata;
    } on DioError catch (error) {
      String message = error.message;
      print("getAllstatelistSC service caller error " + message);
      throw (message);
    }
  }

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
  }

  saveAddressSC(String userName,String address,String landmarkValue,String pinkcodeValue,String fullnameValue,String phoneValue,String location,States selectedStateData,Citys selectedCityData) async {
    Dio dio = await getInterceptors();
    try {
      print("${Constants.AppBaseUrl}AddUpdateUserAddress?username=${userName}&pincode=${pinkcodeValue}&acity=${selectedCityData.sno}&astate=${selectedStateData.sno}&alandmark=${landmarkValue}&aaddress=${address}&contactno=${phoneValue}&statename=${selectedStateData.stateName}&cityname=${selectedCityData.cityName}&Location=${location}&fullname=${fullnameValue}&sno=0");
      Response response = await dio.post(
          "${Constants.AppBaseUrl}AddUpdateUserAddress?username=${userName}&pincode=${pinkcodeValue}&acity=${selectedCityData.sno.toString()}&astate=${selectedStateData.sno.toString()}&alandmark=${landmarkValue}&aaddress=${address}&contactno=${phoneValue}&statename=${selectedStateData.stateName}&cityname=${selectedCityData.cityName}&Location=${location}&fullname=${fullnameValue}&sno=0");

      SaveAddressModel responsedata = SaveAddressModel.fromJson(response.data);
      return responsedata;
    } on DioError catch (error) {
      String message = error.message;
      print("saveAddressSC service caller error " + message);
      throw (message);
    }
  }
}
