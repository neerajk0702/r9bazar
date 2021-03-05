import 'package:dio/dio.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/App/orderplace/UpdateOrderPaymentStatusModel.dart';
import 'package:rbazaar/App/productdetails/ProductDetailsModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'SearchProductModel.dart';


class SearchProductServicecaller {
  searchProduct(String productname) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}SearchAPI?content=${productname}"
      );
      print('url= ' +
          "${Constants.AppBaseUrl}SearchAPI?content=${productname}");
      return SearchProductModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("searchProduct service caller error " + message);
      throw (message);
    }
  }
}
