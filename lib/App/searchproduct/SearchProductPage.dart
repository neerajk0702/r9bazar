import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/CityModel.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/App/productdetails/CartListPage.dart';
import 'package:rbazaar/utils/StrikeThroughWidget.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SearchProductController.dart';
import 'SearchProductModel.dart';

class SearchProductPage extends StatefulWidget {
  @override
  SearchProductPageState createState() => SearchProductPageState();
  String productName;

  SearchProductPage({this.productName});
}

class SearchProductPageState extends State<SearchProductPage> {
  final SearchProductController controller = Get.put(SearchProductController());
  int totalItem = 0;
  bool insertItem = false;
  bool insertItem1 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.searchProduct(widget.productName);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          color: MyColors.lightblue1,
          child:Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _topBar(),
                  Expanded(
                    child: Container(
                        child: Obx(() => Container(
                            height: Get.height,
                            margin: const EdgeInsets.only(
                                bottom: 10, top: 0, left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildProductWidget(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )))),
                  ),
                ],
              ),
              Positioned(
                child: Obx(
                      () => Center(
                    child: controller.isProcessing
                        ? SizedBox(
                      height: 10,
                    )
                        : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                        child: CircularProgressIndicator()),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _topBar() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
      color: MyColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Products",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(onTap: () async {
                      DBHelper dbHelper = DBHelper();
                      var list = await dbHelper.getAllProduct();
                      if (list == null || list.length == 0) {
                        CommonUtills.flutterToast(
                            "Any Item did not found in your cart");
                      } else {
                        // Get.to(CartListPage());
                        Get.to(CartListPage()).then((value){
                          setState(() {
                            controller.searchProduct(widget.productName);});
                        });
                      }
                    },
                        child:   Container(
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 0, left: 5, right: 10),
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 30,
                                  height: 30,
                                  child: IconButton(
                                    icon:
                                    Icon(Icons.shopping_cart, color: Colors.white),
                                  ),
                                ),
                            Obx(() =>  Container(
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0),
                                shape: BoxShape.circle,
                                // You can use like this way or like the below line
                                //borderRadius: new BorderRadius.circular(30.0),
                                color: Colors.red,
                              ),
                              child:
                              Text(
                                controller.productData?.totalItem.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))

                              ],
                            )))
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildProductWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, top: 0, left: 0, right: 0),
      child: ListView.builder(
          itemCount: controller?.productData?.products?.length==null?0:controller?.productData?.products.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _productItemWidget( controller?.productData?.products[index], index,controller?.productData);
          }),
    );
  }

  Widget _productItemWidget(Products data, index, SearchProductModel prodata) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container( margin: const EdgeInsets.only(bottom: 5, top: 0, left: 0, right: 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  child: FadeInImage(
                    height: 160,
                    image: NetworkImage(Constants.imageUrl +
                        data?.folderName +
                        data?.fileName ??
                        ""),
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                  const EdgeInsets.only(bottom: 5, top: 5.0, left: 5, right: 5),
                  child: Text(
                    data?.aliasName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),

                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 3,
                            top: 4,
                            left:5,
                            right: 3),
                        child: StrikeThroughWidget(
                          child: Text(
                              'Rs ' +
                                  data?.mrps
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 0,
                          top: 5.0,
                          left: 3,
                          right: 3),
                      child: Text(
                        "Rs " +
                            data?.saleRate
                                .toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(
                      bottom: 3, top: 0, left: 5, right: 10),
                  child: Text(
                    "Rs "+gettotalAmount(data?.saleRate,data?.dbQuantityLocal),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(
                      bottom: 3, top: 0, left: 5, right: 10),
                  child: Text(
                    "Gross wt." +
                        data?.grossweight.toString() +
                        " | Net wt." +
                        data?.netweight.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                _getProductsaveDetails(data,prodata),
              ])),
    );
  }
  Widget _getProductsaveDetails(Products data,SearchProductModel prodata) {
    try {
      // checkAddtoCart(data);
      // print(prodactFlag);
      print('reset again***********');
      if (data?.dbnetweight != null && data?.dbnetweight > 0) {
        return _addIncrementlayout(data,prodata);
      } else {
        return _addLayout(data,prodata);
      }
      // return _addLayout(data);

      /* var dbHelper = DBHelper();
      // Subproducts subproducts = SQLiteDbProvider.db.getProductById(data?.dsno) as Subproducts;
        return FutureBuilder(
            future: dbHelper.getUser(data?.dsno),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Center(
                  child: Text('${snapshot.data?.dsno}'),
                );
              } else {
                return _addLayout(data);
              }
            });*/

    } catch (e) {
      // CommonUtills.flutterToast(e.toString());
    }
  }

  Widget _addIncrementlayout(Products data,SearchProductModel prodata) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, top: 10, left: 0, right: 0),
      alignment: Alignment.topRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () async {
              double netweightnew = data.dbnetweight + data.weight;
              double dbQuantityLocalnew = data.dbQuantityLocal +1;
              addValue(data, netweightnew, 4,prodata,dbQuantityLocalnew);
            },
            child: Icon(
              Icons.add_circle_outline,
              color: MyColors.darkgrey_60,
              size: 40.0,
            ),
          ),
          Padding(padding: const EdgeInsets.all(5.0)),
          Text(
            data?.dbnetweight?.toStringAsFixed(2) + " "+ data?.unit??"",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
          ),
          Padding(padding: const EdgeInsets.all(5.0)),
          InkWell(
            onTap: () async {
              double netweightnew = 0;
              if (data.dbnetweight == data.weight) {
                addValue(data, netweightnew, 1,prodata,0);
              } else {
                netweightnew = data.dbnetweight - data.weight;
                double dbQuantityLocalnew = data.dbQuantityLocal -1;
                addValue(data, netweightnew, 2,prodata,dbQuantityLocalnew);
              }
            },
            child: Icon(
              Icons.remove_circle_outline,
              color: MyColors.darkgrey_60,
              size: 40.0,
            ),
          ),
          Padding(padding: const EdgeInsets.all(5.0))
        ],
      ),
    );
  }

  Widget _addLayout(Products data,SearchProductModel prodata) {
    return Container(
        alignment: Alignment.centerRight,
        child: InkWell(
            onTap: () async {
              addValue(data, data.weight, 3,prodata,1);
            },
            child: Container(
              height: 42.0,
              width: 130,
              margin: EdgeInsets.only(top: 16, bottom: 2, left: 5,right: 5),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                border: new Border.all(
                  color: MyColors.primaryColor,
                  width: 1.0,
                ),
              ),
              child: Text(
                "ADD",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
            )));
  }
  void addValue(Products data, double netweightNew, int deleteFlag,SearchProductModel prodata,double qty) {
    var dbHelper = DBHelper();
    var cartData = AddTocartLocal(
        dsno: data.dsno,
        productName: data.productName,
        aliasName: data.aliasName,
        saleRate: data.saleRate,
        grossweight: data.grossweight,
        netweight: data.netweight,
        totalNetweight: netweightNew,
        quantityLocal:qty,
        imagePath: Constants.imageUrl + data?.folderName + data?.fileName,
        category: data.category,
        patternid:data.patternid,
        weight:data.weight,
        unit:data.unit,
        mainproductsno:data.productid,
        purchaserate:data.purchaseRate,
        mrp:double.parse(data.mrps.toString()),
        discountpercent:double.parse(data.discount.toString())
    );

    dbHelper.upsertProduct(cartData).then((value) async {
      if (deleteFlag == 1) {
        //to remove
        dbHelper.deleteProduct(data.dsno); //delete last value in database
        CommonUtills.showtoast("Successfully Remove");
      } else if (deleteFlag == 2) {
        CommonUtills.showtoast("Successfully Remove");
      } else {
        CommonUtills.showtoast("Successfully Added");
      }
      var list = await dbHelper.getAllProduct();
      if (list != null && list.length > 0) {
        // totalItem = list.length;
        print("totalItem" + totalItem.toString());
        prodata.totalItem=list.length;
      }
      setState(() {
        data.dbnetweight = netweightNew; //s
        data.dbQuantityLocal = qty; // et new value in UI
        insertItem = true;
      });
    });
  }
  String gettotalAmount(double saleRate,double quty) {
    double totalsalerate=0;
    if(quty!=null && quty>1){
      for(int i=0;i<quty;i++){
        totalsalerate=totalsalerate+saleRate;
      }
    }else{
      totalsalerate=saleRate;
    }

    return totalsalerate.toString();
  }
}
