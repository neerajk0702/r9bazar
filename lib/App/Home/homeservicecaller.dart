

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/App/model/CategoriesModel.dart';
import 'package:rbazaar/App/model/FlashSaleReportModel.dart';
import 'package:rbazaar/App/model/HotdealModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'AccountdetailModel.dart';
import 'Homemodel.dart';
import 'SliderModel.dart';


class HomeServiceCaller {
  getCategoryesList() async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}CategoryesList?status=Y"
      );
      print('url= '+"${Constants.AppBaseUrl}CategoryesList?status=Y");
      return CategoriesModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("CategoryesList service caller error "+message);
      throw (message);
    }
  }

  getHotDeal() async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}Deals?hotdeal=Y"
      );
      print('url= '+"${Constants.AppBaseUrl}Deals?hotdeal=Y");
      return HotdealModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Deals service caller error "+message);
      throw (message);
    }
  }
//  http://www.r9bazaar.com/FlashSaleReport?itemname=&Category=&SubCategory=&Group=&applicabledate=&enddate=2020-11-29&Status=Y
  getflashsale() async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}FlashSaleReport?itemname=&Category=&SubCategory=&Group=&applicabledate=&enddate=${CommonUtills.getCurentDate()}&Status=Y");
      print('url= '+"${Constants.AppBaseUrl}FlashSaleReport?itemname=&Category=&SubCategory=&Group=&applicabledate=&enddate=${CommonUtills.getCurentDate()}&Status=Y");
      return FlashSaleReportModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Deals service caller error "+message);
      throw (message);
    }
  }

  getsliderDetails() async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}CarouselLists"
      );
      print('url= '+"${Constants.AppBaseUrl}CarouselLists");
      return SliderModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Slider service caller error "+message);
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

 /* getUserDetail() async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.get(
          "${Constants.AppTestBaseUrl}api/v2/user/completion/status"
      );
      print('url= '+"${Constants.AppTestBaseUrl}api/v2/user/completion/status");
      return Homemodel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }

  getUserInfo()async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.get(
          "${Constants.AppTestBaseUrl}api/user"
      );
      print('url= '+"${Constants.AppTestBaseUrl}api/user");
      return UserModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }


  // GET TRENDING COURSE LIST
  getCourseList() async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.get(
          "${Constants.AppTestBaseUrl}api/vertical/list",queryParameters: {'counts':1,'language_id':GetStorage().read(Constants.LANGUAGEPREF)}
      );
      print('url= '+"${Constants.AppTestBaseUrl}api/vertical/list?counts=1&language_id=1");
      return CourseModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }
  // GET INPROGRESS COURSE LIST
  getINProgressCourses() async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.get(
          "${Constants.AppTestBaseUrl}api/v2/vertical/browsed"
      );
      print('url= '+"${Constants.AppTestBaseUrl}api/v2/vertical/browsed?counts=1&language_id=1");
      //Iterable l = json.decode(response.data);
      List responseJson =response.data;
      responseJson.map((m) => new InProgressModel.fromJson(m)).toList();
      return responseJson;
    } on DioError catch(error){
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }

  /// COURSE FOR YOU
getCoursesForYouList()async{
  {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.get(
          "${Constants.AppTestBaseUrl}api/v2/vertical/new"
      );
      print('url= '+"${Constants.AppTestBaseUrl}api/v2/vertical/browsed?counts=1&language_id=1");
      //Iterable l = json.decode(response.data);
      List responseJson =response.data;
      responseJson.map((m) => new CoursesForYouModel.fromJson(m)).toList();
      return responseJson;
    } on DioError catch(error){
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }
}
//update user profile after level upgrade by user
  updateUser(String name,String email,int age,int level,int language ) async{
    Dio dio=await getInterceptors();

    try{
      var response= await dio.post("${Constants.AppTestBaseUrl}api/web/profile/update",queryParameters: {
        'name':name,
        'email':email,
        'preferred_language_id':language,
        'difficulty_level':level,
        'age_segment':age
      });
//      'cache_key':"a8b591a5-cdd0-64fa-1efc-be31baee0be6",
      UpdateProfileModels apiresponse = UpdateProfileModels.fromJson(response.data);
      return apiresponse;
    }
    on DioError catch(error){
      String message = error.message;
      throw (message);
    }
  }*/

}