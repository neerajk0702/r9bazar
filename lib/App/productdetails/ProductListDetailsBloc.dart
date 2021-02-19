import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rxdart/rxdart.dart';

import '../model/AddTocartLocal.dart';
import 'CartProductDetails.dart';
import 'ProductDetailsModel.dart';
import 'ProductListServicecaller.dart';

class ProductListDetailsBloc {
  final servicecaller = ProductListServicecaller();

  // home OBJECTS
  final ServiceSubject = BehaviorSubject<ProductDetailsModel>();

  get statusData => ServiceSubject.stream;

  /// LOADING OBJECTS
  final _isLoadingStateController = BehaviorSubject<bool>();

  get isLoading => _isLoadingStateController.stream;

  getProductListData(productsno, catId) async {
    try {
      if (await CommonUtills.ConnectionStatus() == true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
        ProductDetailsModel subcategoriesModel =
            await servicecaller.getProductList(productsno, catId);
        var dbHelper = DBHelper();
        // var total=getTotalItemNo();
        List<Map> ListMap = await dbHelper.getAllProducts();
        List<AddTocartLocal> productList = ListMap.isNotEmpty
            ? ListMap.map((c) => AddTocartLocal.fromMap(c)).toList()
            : null;
        if (productList != null && productList.length>0) {
          subcategoriesModel.totalItem=productList.length;
          for (var i = 0; i < subcategoriesModel?.subproducts.length; i++) {
            for (var j = 0; j < productList.length; j++) {
              if (productList[j].dsno ==
                  subcategoriesModel?.subproducts[i].dsno) {
                subcategoriesModel?.subproducts[i].dbnetweight =productList[j].totalNetweight;
                subcategoriesModel?.subproducts[i].dbQuantityLocal =productList[j].quantityLocal;
              }
            }
          }
        }

        ServiceSubject.sink.add(subcategoriesModel);
        _isLoadingStateController.sink.add(false);
        return ServiceSubject;
      } else {
        ProductDetailsModel response = ProductDetailsModel();
        response.status = false;
        response.message = "Network not available";
        ServiceSubject.sink.add(response);
        _isLoadingStateController.sink.add(false);
        return ServiceSubject;
      }
    } catch (error) {
      print("Product details Bloc error" + error.toString());
    }
  }

  dispose() {
    ServiceSubject.close();
    _isLoadingStateController.close();
  }

  Future<int> getTotalItemNo() async {
    int totalItem = 0;
    var dbHelper = DBHelper();
    var list = await dbHelper.getAllProduct();
    if (list != null && list.length > 0) {
      totalItem = list.length;
    }
    return totalItem;
  }
}
