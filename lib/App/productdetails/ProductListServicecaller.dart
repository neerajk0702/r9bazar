
import 'package:dio/dio.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'ProductDetailsModel.dart';


class ProductListServicecaller {

  /*getProductList(subcategory,catId) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}SubCategoriesWiseProduct?subcategory=${subcategory}&category=${catId}&group=&subgroup=&productsno=0&productcode=&brand=&barcode=&itemcode=");
      print('url= '+"${Constants.AppBaseUrl}FlashSaleReport?");
      http://www.r9bazaar.com/SubCategoriesWiseProduct?subcategory=Marine Fish&category=1&group=&subgroup=&productsno=0&productcode=&brand=&barcode=&itemcode=
      print('url= '+"${Constants.AppBaseUrl}SubCategorys?column=SubCategory&conditioncolumn=Category&condition=${catId}");
      return ProductModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("SubCategorys service caller error "+message);
      throw (message);
    }
  }*/

  getProductList(productsno,catId) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}ShowSubProductList?productsno=${productsno}&category=${catId}");
      print('url= '+ "${Constants.AppBaseUrl}ShowSubProductList?productsno=${productsno}&category=${catId}");
      return ProductDetailsModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("ShowSubProductList service caller error "+message);
      throw (message);
    }
  }
}