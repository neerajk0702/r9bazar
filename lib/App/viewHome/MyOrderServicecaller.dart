import 'package:dio/dio.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/orderplace/UpdateOrderPaymentStatusModel.dart';
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

  //http://r9bazaar.com/CancelOrderAPI?psno=44&saleid=31&orderid=20210214100534778_0031&reason=testing content&username=7905594742

  CancelOrderSC(int sno,int saleID,String orderID,String reason,String userID) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}CancelOrderAPI?psno=${sno}&saleid=${saleID}&orderid=${orderID}&reason=${reason}&username=${userID}"
      );
      print('url= '+"${Constants.AppBaseUrl}CancelOrderAPI?psno=${sno}&saleid=${saleID}&orderid=${orderID}&reason=${reason}&username=${userID}");
      return UpdateOrderPaymentStatusModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("CancelOrderSC service caller error "+message);
      throw (message);
    }
  }
}
