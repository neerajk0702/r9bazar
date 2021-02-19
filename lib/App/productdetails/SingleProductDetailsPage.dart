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
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import 'CartListPage.dart';
import 'ProductDetailsModel.dart';
import 'ProductListDetailsBloc.dart';

class SingleProductDetailsPage extends StatefulWidget {
  @override
  SingleProductDetailsPageState createState() => SingleProductDetailsPageState();
 /* int productsno;
  String imagePath;
  var productName;
  var productTitle;
  double saleRate;
  double netweight;
  double grossweight;*/
  bool addFlag=false;
 /* String aliasName;
  String category;*/
  var product;
  SingleProductDetailsPage({this.product});

  /*SingleProductDetailsPage(
      {this.productName,
        this.imagePath,
        this.productTitle,
        this.productsno,
        this.netweight,
        this.saleRate,
        this.grossweight,
        this.aliasName,
        this.category
});*/
}

class SingleProductDetailsPageState extends State<SingleProductDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool insertItem = false;
  bool insertItem1 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldkey,
        body: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            child: Stack(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _topBar(),
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
                            image: NetworkImage(widget.product?.imagePath ?? ""),
                            placeholder:
                            AssetImage('assets/images/placeholder.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              bottom: 0, top: 10.0, left: 10, right: 10),
                          child: Text(
                            widget.product?.productName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              bottom: 10, top: 5.0, left: 10, right: 10),
                          child: Text(
                            widget.product?.aliasName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        _productItemWidget()
                      ],
                    )),
              ],
            )));
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
                    Expanded(child:  Text(
                      widget.product?.aliasName,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),),
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        Get.to(CartListPage());
                      },
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }



  Widget _productItemWidget() {
    return Container( margin: const EdgeInsets.only(
        bottom: 10, top: 5.0, left: 10, right: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                      image: NetworkImage( widget.product?.imagePath),
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
                              widget.product?.saleRate?.toString(),
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
                                  widget.product?.grossweight?.toString() +
                                  " | Net wt." +
                                  widget.product?.netweight?.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          _getProductsaveDetails(),
                        ],
                      ))
                ],
              ),
            ]));
  }



  Widget _getProductsaveDetails() {
    try {
      if (widget.product?.totalNetweight>0) {
        return _addIncrementlayout();
      } else {
        return _addLayout();
      }
      // return _addLayout();
    } catch (e) {
      // CommonUtills.flutterToast(e.toString());
    }
  }

  Widget _addIncrementlayout() {
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
              double netweightnew = widget.product?.totalNetweight + widget.product?.netweight;
              addValue(netweightnew, 4);
            },
            child: Icon(
              Icons.add_circle_outline,
              color: MyColors.darkgrey_60,
              size: 40.0,
            ),
          ),
          Padding(padding: const EdgeInsets.all(5.0)),
          Text(
    widget.product?.totalNetweight?.toString() + " Kg",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
          ),
          Padding(padding: const EdgeInsets.all(5.0)),
          InkWell(
            onTap: () async {
              double netweightnew = 0;
              if (widget.product?.totalNetweight == widget.product?.netweight) {
                addValue(netweightnew, 1);
              }else{
                netweightnew = widget.product?.totalNetweight - widget.product?.netweight;
                addValue(netweightnew, 2);
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

  Widget _addLayout() {
    return Container(
        alignment: Alignment.centerRight,
        child: InkWell(
            onTap: () async {
              addValue(widget.product?.netweight,3);
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

  void addValue(double netweightNew,int deleteFlag) {
    var dbHelper = DBHelper();
    /*var cartData = AddTocartLocal(
        dsno: widget.productsno,
        productName: widget.productName,
        aliasName: widget.aliasName,
        saleRate: widget.saleRate,
        grossweight: widget.grossweight,
        netweight: widget.netweight,
        totalNetweight: netweightNew,
        quantityLocal: 5.6,
        imagePath: widget.imagePath,
        category: widget.category);*/
    widget.product?.totalNetweight=netweightNew;
    dbHelper.upsertProduct(widget.product).then((value) {
      if (deleteFlag==1) {
        //to remove
        dbHelper.deleteProduct( widget.product?.dsno); //delete last value in database
        CommonUtills.showtoast("Successfully Remove");
      }else if(deleteFlag==2){
        CommonUtills.showtoast("Successfully Remove");
      }
      else{
        CommonUtills.showtoast("Successfully Added");
      }
      setState(() {
        widget.product?.totalNetweight=netweightNew; //set new value in UI
        insertItem = true;
      });
    });
  }
}
