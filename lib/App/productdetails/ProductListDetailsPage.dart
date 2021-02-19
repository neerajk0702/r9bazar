import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/database/DBHelperNew.dart';
import 'package:rbazaar/App/database/SQLiteDbProvider.dart';
import 'package:rbazaar/App/model/User.dart';
import 'package:rbazaar/App/productlist/ProductListPage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import '../model/AddTocartLocal.dart';
import 'CartListPage.dart';
import 'ProductDetailsModel.dart';
import 'ProductListDetailsBloc.dart';

class ProductListDetailsPage extends StatefulWidget {
  @override
  ProductListDetailsPageState createState() => ProductListDetailsPageState();
  int catId;
  int productsno;
  String imagePath;
  var productName;
  var productTitle;
  int mainproductsno;

  ProductListDetailsPage(
      {this.productName,
      this.catId,
      this.imagePath,
      this.productTitle,
      this.productsno,
      this.mainproductsno});
}

class ProductListDetailsPageState extends State<ProductListDetailsPage> {
  ProductListDetailsBloc bloc = ProductListDetailsBloc();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool insertItem = false;
  bool insertItem1 = false;
  int totalItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getProductListData(widget.productsno, widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
        key: _scaffoldkey,
        body: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            child: Stack(
              children: [
              Container(height: double.infinity,
              width: double.infinity,
              color: Colors.transparent,
                child:  SingleChildScrollView(
                    // scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StreamBuilder<ProductDetailsModel>(
                          stream: bloc.ServiceSubject.stream,
                          builder: (context,
                              AsyncSnapshot<ProductDetailsModel> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.error == null &&
                                  snapshot.data.status == false) {
                                return _buildErrorWidget(snapshot.data.message);
                              } else if (snapshot.error == null &&
                                  snapshot.data.isNull) {
                                return _buildErrorWidget("No Data Found");
                              } else if (snapshot.error != null ||
                                  snapshot.data.isNull) {
                                return _buildErrorWidget(snapshot.error);
                              }
                              return _buildProductWidget(snapshot.data);
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget(snapshot.error);
                            } else {
                              return _buildLoadingWidget();
                            }
                          },
                        )
                      ],
                    )),)

              ],
            ))),);
  }

  Widget loadingIndicator(ProductListDetailsBloc bloc) => StreamBuilder<bool>(
        stream: bloc.isLoading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? CircularProgressIndicator()
                : null,
          );
        },
      );

  Widget _buildLoadingWidget() {
    return Positioned(
        child: Center(
      child: loadingIndicator(bloc),
    ));
  }

  Widget _buildErrorWidget(String message) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
      ],
    ));
  }

  _topBar(ProductDetailsModel data) {
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
                    widget.productTitle,
                    maxLines: 2,
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
                    Get.off(CartListPage());
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
                          Container(
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
                            child: Text(
                              data?.totalItem.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )))

              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProductWidget(ProductDetailsModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _topBar(data),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: FadeInImage(
            height: 230,
            width: Get.width,
            image: NetworkImage(widget.imagePath ?? ""),
            placeholder: AssetImage('assets/images/placeholder.png'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin:
              const EdgeInsets.only(bottom: 0, top: 10.0, left: 10, right: 10),
          child: Text(
            widget.productName,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 0, left: 5, right: 5),
          child: ListView.builder(
              itemCount: data?.subproducts?.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _productItemWidget(data?.subproducts[index], index,data);
              }),
        )

      ],
    );
  }

  Widget _productItemWidget(Subproducts data, index,ProductDetailsModel prodata) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.only(bottom: 5, top: 5.0, left: 5, right: 5),
              child: Text(
                data?.productName,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  child: FadeInImage(
                    height: 150,
                    width: 150,
                    image: NetworkImage(Constants.imageUrl +
                            data?.folderName +
                            data?.fileName ??
                        ""),
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                  ],
                ))
              ],
            ),
          ])),
    );
  }

  /* checkAddtoCart(Subproducts data) async {
    CartProductDetails productDetails = null;
    SharedPref pref = SharedPref();
    var details = await pref.read("ProductDetails");
    if (details != null) {
      productDetails = CartProductDetails.fromJson(details);
    }
    print("**" + productDetails.dsno.toString());
    if (data.dsno == productDetails.dsno) {
      insertItem1 = true;
    } else {
      insertItem1 = false;
    }
  }*/

  Widget _getProductsaveDetails(Subproducts data,ProductDetailsModel prodata) {
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

  Widget _addIncrementlayout(Subproducts data,ProductDetailsModel prodata) {
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

  Widget _addLayout(Subproducts data,ProductDetailsModel prodata) {
    return Container(
        alignment: Alignment.centerRight,
        child: InkWell(
            onTap: () async {
              addValue(data, data.weight, 3,prodata,1);
            },
            child: Container(
              height: 42.0,
              width: 130,
              margin: EdgeInsets.only(top: 16, bottom: 2, left: 5),
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

  void addValue(Subproducts data, double netweightNew, int deleteFlag,ProductDetailsModel prodata,double qty) {
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
  //calculate total amount
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
