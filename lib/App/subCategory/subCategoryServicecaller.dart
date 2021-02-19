
import 'package:dio/dio.dart';
import 'package:rbazaar/App/productlist/ProductModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';

import 'SubCategoryModel.dart';


class subCategoryServicecaller {

  getSubcategoryList(catId) async{
    Dio dio = await getInterceptors();
    try {
      Response response = await dio.post(
          "${Constants.AppBaseUrl}SubCategorys?column=SubCategory&conditioncolumn=Category&condition=${catId}");
      print('url= '+"${Constants.AppBaseUrl}SubCategorys?column=SubCategory&conditioncolumn=Category&condition=${catId}");
      return SubCategoryModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("SubCategorys service caller error "+message);
      throw (message);
    }
  }

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