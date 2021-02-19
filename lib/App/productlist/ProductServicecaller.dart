
import 'package:dio/dio.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'ProductModel.dart';



class ProductServicecaller {

  getProductList(subcategory,catId) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}SubCategoriesWiseProduct?subcategory=${subcategory}&category=${catId}&group=&subgroup=&productsno=0&productcode=&brand=&barcode=&itemcode=");
      print('url= '+"${Constants.AppBaseUrl}SubCategoriesWiseProduct?subcategory=${subcategory}&category=${catId}&group=&subgroup=&productsno=0&productcode=&brand=&barcode=&itemcode=");
      return ProductModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("SubCategoriesWiseProduct service caller error "+message);
      throw (message);
    }
  }
}