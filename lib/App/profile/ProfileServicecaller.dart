import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';


class ProfileServicecaller {
  /*updateProfile(File image, ) async {
    Dio dio = await getInterceptors();

    String fileName = image.path.split("/").last;
    try {
      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: fileName)
      });
      var response = await dio.post("${Constants.AppTestBaseUrl}api/user/avatar/update", data: formData);

      return CommonModels.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }*/

  updateProfileSC(String userName,String fname,String lname,String emailid,File image,String phone) async {
    Dio dio = await getInterceptors();
    try {
      print("${Constants.AppBaseUrl}UpdateProfileAPI?username=${userName}&fname=${fname}&lname=${lname}&emailid=${emailid}&gender=${"Male"}&mobile=${phone}");
      Response response = await dio.post(
          "${Constants.AppBaseUrl}UpdateProfileAPI?username=${userName}&fname=${fname}&lname=${lname}&emailid=${emailid}&gender=${"M"}&mobile=${userName}");

      return AccountdetailModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("updateProfileSC service caller error " + message);
      throw (message);
    }
  }


  updateProfileImage(String userName,File image) async {
    Dio dio = await getInterceptors();
    try {
      print("${Constants.AppBaseUrl}UpdateProfileImageAPI?username=${userName}&file=${""}");
      FormData formData=null;
      if(image!=null){
        print("ggfgf"+image.toString());
        String fileName = image?.path?.split("/")?.last??"";
        formData = new FormData.fromMap({
          "file": await MultipartFile.fromFile(image.path??"", filename: fileName)
        });
      }
      Response response = await dio.post(
          "${Constants.AppBaseUrl}UpdateProfileImageAPI?username=${userName}&file=${""}", data: formData);
print(response.data);
      return AccountdetailModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("updateProfileImage service caller error " + message);
      throw (message);
    }
  }
  myaccountdetailData(String userName) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}myaccountdetail?username=${userName}"
      );
      print('url= '+"${Constants.AppBaseUrl}myaccountdetail?username=${userName}");
      return AccountdetailModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("myaccountdetailData service caller error "+message);
      throw (message);
    }
  }
}
