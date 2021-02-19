
import 'package:rbazaar/App/subCategory/subCategoryServicecaller.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rxdart/rxdart.dart';

import '../productdetails/ProductDetailsModel.dart';
import 'ProductModel.dart';
import 'ProductServicecaller.dart';



class ProductListBloc{
  final servicecaller = ProductServicecaller();
  // home OBJECTS
  final ServiceSubject = BehaviorSubject<ProductModel>();
  get statusData => ServiceSubject.stream;
  /// LOADING OBJECTS
  final _isLoadingStateController = BehaviorSubject<bool>();
  get isLoading => _isLoadingStateController.stream;

  getProductListData(subcategory,catId)async{
    try {
      if(await CommonUtills.ConnectionStatus()== true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
        ProductModel subcategoriesModel = await servicecaller.getProductList(subcategory,catId);
        ServiceSubject.sink.add(subcategoriesModel);
        return ServiceSubject;
      }else{
        ProductModel response = ProductModel();
        response.status=false;
        response.message="Network not available";
        ServiceSubject.sink.add(response);
        _isLoadingStateController.sink.add(false);
        return ServiceSubject;
      }

    }catch(error){
      print("Product list Bloc error"+error.toString());
    }
  }

  dispose() {
    ServiceSubject.close();
    _isLoadingStateController.close();
  }
}
