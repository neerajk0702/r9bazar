import 'package:dio/dio.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';


class MyOrderServicecaller {
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
