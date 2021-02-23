import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';

import '../commonutills.dart';

///How to use this interceptor
///In a function for any API call just call ↓
/// ``   Dio dio = await getInterceptors();``
/// This will give an dio object.
/// if required you can add retry or catching logic to this interceptor.

Future<Dio> getInterceptors() async {
  BaseOptions options = new BaseOptions();

  /// Fetch User DB and pass on user token to every api Request

  //var user = await db.getLogUser();
  String usertoken = GetStorage().read(Constants.USERTOKEN);
  String accessToken = usertoken != null ? 'Bearer ${usertoken}':'';
  print("AccessToken= "+accessToken);
  options.sendTimeout = 60000;
  options.receiveTimeout = 60000;
  options.connectTimeout = 70000;
  options.contentType = "application/json";
  options.headers = {
    "authorization": accessToken,
    "Accept": "application/json",
    "route": Get.currentRoute
  };
  Dio dio = new Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options;
      },
      onResponse: (Response response) async {
        return response; // continue
      },
      onError: (DioError e) async {
        if (e.response?.statusCode == 401) {
          /// if request is unauthorized just log user of and remove user from DB

          // await db.deleteUsers();
          GetStorage().remove(Constants.USERTOKEN);
          GetStorage().remove(Constants.USERNAME);
          GetStorage().remove(Constants.USEREMAIL);
          // Ideally it should navigate user to Login page, but if logic change navigate to splash screen
          CommonUtills.flutterToast('sessionclosed');
          // Get.offAll(LoginPage());
        }
        if(e.response?.statusCode == 422){
          return e.error;
        }
        else {
          return e.response.data['message'];
        }
      },
    ),
  );
  return dio;
}
