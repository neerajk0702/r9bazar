
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/App/model/CategoriesModel.dart';
import 'package:rbazaar/App/model/FlashSaleReportModel.dart';
import 'package:rbazaar/App/model/HotdealModel.dart';
import 'package:rbazaar/App/productlist/ProductModel.dart';
import 'package:rbazaar/App/subCategory/subCategoryServicecaller.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rxdart/rxdart.dart';

import 'SubCategoryModel.dart';



class SubCategoryBloc{
  final servicecaller = subCategoryServicecaller();
  // home OBJECTS
  final homeServiceSubject = BehaviorSubject<SubCategoryModel>();
  get statusData => homeServiceSubject.stream;
  /// LOADING OBJECTS
  final _isLoadingStateController = BehaviorSubject<bool>();
  get isLoading => _isLoadingStateController.stream;


  getSubcategoryListData(catId)async{
    try {
      if(await CommonUtills.ConnectionStatus()== true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
        SubCategoryModel subcategoriesModel = await servicecaller.getSubcategoryList(catId);
        homeServiceSubject.sink.add(subcategoriesModel);
        _isLoadingStateController.sink.add(false);
        return homeServiceSubject;
      }else{
        SubCategoryModel response = SubCategoryModel();
        response.status=false;
        response.message="Network not available";
        homeServiceSubject.sink.add(response);
        _isLoadingStateController.sink.add(false);
        return homeServiceSubject;
      }

    }catch(error){
      print("topic Bloc error"+error.toString());
    }
  }
  Future<ProductModel> getProductListData(subcategory,catId)async{
    try {
      if(await CommonUtills.ConnectionStatus()== true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
        ProductModel productModel = await servicecaller.getProductList(subcategory,catId);
        _isLoadingStateController.sink.add(false);
        return productModel;
      }else{
        ProductModel response = ProductModel();
        response.status=false;
        response.message="Network not available";
        _isLoadingStateController.sink.add(false);
        return response;
      }

    }catch(error){
      print("Product list Bloc error"+error.toString());
    }
  }
  dispose() {
    homeServiceSubject.close();
    _isLoadingStateController.close();
  }
}
