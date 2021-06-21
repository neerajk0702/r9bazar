import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/AddressPage.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/database/DBHelperNew.dart';
import 'package:rbazaar/App/database/SQLiteDbProvider.dart';
import 'package:rbazaar/App/model/User.dart';
import 'package:rbazaar/App/orderplace/OrderPlacePage.dart';
import 'package:rbazaar/App/productlist/ProductListPage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/commonwidgets.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import 'ProductDetailsModel.dart';
import 'ProductListDetailsBloc.dart';

class CartListPage extends StatefulWidget {
  @override
  CartListPageState createState() => CartListPageState();

  CartListPage();
}

class CartListPageState extends State<CartListPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  DBHelper dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              _topBar(),
              Expanded(
                child: Container(
                  child:
                      /*FutureBuilder(
                    future: dbHelper.getAllProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _buildProductWidget(snapshot.data);
                      } else if (snapshot.hasError) {
                        return _buildErrorWidget(snapshot.error);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),*/
                      FutureBuilder(
                    future: dbHelper.getAllProducts(),
                    builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                      if (snapshot.hasData) {
                        List<AddTocartLocal> proListl = snapshot?.data?.isNotEmpty
                            ? snapshot.data
                                .map((c) => AddTocartLocal.fromMap(c))
                                .toList()
                            : null;
                        if (proListl == null || proListl?.length == 0) {
                          Navigator.of(context).pop();
                        }
                        return _buildProductWidget(proListl);
                      } else if (snapshot.hasError) {
                        return _buildErrorWidget(snapshot.error);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
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

  _topBar() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
      color: MyColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container( padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(child: Text(
                  "Your Cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        confirmDelete();
                      },
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete_forever, color: Colors.white),
                          ),
                          Text(
                            "Empty Cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),

                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProductWidget(List<AddTocartLocal> data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.only(bottom: 10, top: 0, left: 10, right: 8),
              child:  data!=null?ListView.builder(
                  itemCount: data?.length,
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _productItemWidget(data[index], index);
                  }):SizedBox(
                height: 10,
              ),
            ),
          ),
          Container(
              // height: 50,
              color: MyColors.lightgrey,
              child:Column( crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,children: [
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 0, top: 8, left: 0, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "SubTotal :",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        /*IconButton(
                          icon: Icon(FontAwesomeIcons.rupeeSign,
                              color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),*/
                        Text(
                          " Rs. "+getSubtotal(data),
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 0, top: 5, left: 0, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "You Saved :",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          " -Rs. "+getTotalDiscount(data),
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Divider(color: Colors.white,),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 10, top: 5, left: 0, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Total :",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          " Rs. "+getFinalAmount(data),
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),

              ],)
             ),
          InkWell(
              onTap: () async {
                SharedPref pref = SharedPref();
                var userInfo = await pref.read("userId");
                if (userInfo != null && userInfo != '') {
                  Get.to(AddressPage(phone: userInfo,screenFlag:2));
                  // Get.to(OrderPlacePage(addressSno:1));
                } else {
                  Get.to(LoginPage());
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: MyColors.lightblue,
                  child: Text(
                    "Proceed to Checkout",
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }

//calculate total amount
  String getSubtotal(List<AddTocartLocal> data) {
    double totalSaleRate = 0;
    for (var i = 0; i < data?.length; i++) {
      double tempSaleRate = double.parse(gettotalAmount(data[i].saleRate,data[i].quantityLocal));
      totalSaleRate = totalSaleRate + tempSaleRate;
    }
    return totalSaleRate.toString();
  }
  //calculate total discount amount
  String getTotalDiscount(List<AddTocartLocal> data) {
    double total = 0;
    for (var i = 0; i < data?.length; i++) {
      double totalsalerate=double.parse(gettotalAmount(data[i].saleRate,data[i].quantityLocal));
      double totaldiscountRate = (totalsalerate*data[i].discountpercent)/100;
      total = total + totaldiscountRate;
    }
    return total.toString();
  }
  String getFinalAmount(List<AddTocartLocal> data){
    double totalSaleRate = 0;
    double finalDisAmount = 0;
    double finalAmount = 0;
    for (var i = 0; i < data?.length; i++) {
      //sale amount
      double tempSaleRate = double.parse(gettotalAmount(data[i].saleRate,data[i].quantityLocal));//data[i].saleRate * data[i].totalNetweight;
      totalSaleRate = totalSaleRate + tempSaleRate;
      //discount
      double totaldiscountRate = (tempSaleRate*data[i].discountpercent)/100;
      finalDisAmount = finalDisAmount + totaldiscountRate;
    }
    finalAmount=totalSaleRate-finalDisAmount;
    return finalAmount.toString();
  }
  //calculate discount
  String getDiscount(double saleRate,double discount,double quty,AddTocartLocal data) {
    double totalsalerate=double.parse(gettotalAmount(saleRate,quty));
    double totaldiscountRate = (totalsalerate*discount)/100;
    return totaldiscountRate.toString();
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
  Widget _productItemWidget(AddTocartLocal data, index) {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 5, top: 0, left: 5, right: 5),
            child: Text(
              data?.productName,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
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
                  height: 120,
                  width: 120,
                  image: NetworkImage(data?.imagePath),
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(  margin: const EdgeInsets.only(
                      bottom: 0, top: 0, left: 5, right: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Rs "+gettotalAmount(data?.saleRate,data?.quantityLocal),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(  margin: const EdgeInsets.only(
                      bottom: 0, top: 0, left: 5, right: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "-"
                            "Rs "+getDiscount(data?.saleRate,data?.discountpercent, data?.quantityLocal,data)
                       /* "-"
                            "Rs "+data?.saleRate.toString()*/,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(
                        bottom: 3, top: 5, left: 5, right: 10),
                    child: Text(
                      "Gross wt." +
                          data?.grossweight.toString() +
                          " | Net wt." +
                          data?.netweight.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  _getProductsaveDetails(data),
                ],
              ))
            ],
          ),
        ]));
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

  Widget _getProductsaveDetails(AddTocartLocal data) {
    try {
      print('_getProductsaveDetails***********');
      if (data?.totalNetweight != null && data?.totalNetweight > 0) {
        return _addIncrementlayout(data);
      } else {
        SizedBox(
          height: 10,
        );
      }
    } catch (e) {
      // CommonUtills.flutterToast(e.toString());
    }
  }

  Widget _addIncrementlayout(AddTocartLocal data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, top: 5, left: 0, right: 0),
      alignment: Alignment.topRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () async {
              double netweightnew = data.totalNetweight + data.netweight;
              double dbQuantityLocalnew = data.quantityLocal +1;
              addValue(data, netweightnew, 3,dbQuantityLocalnew);
            },
            child: Icon(
              Icons.add_circle_outline,
              color: MyColors.darkgrey_60,
              size: 30.0,
            ),
          ),
          Padding(padding: const EdgeInsets.all(5.0)),
          Text(
            data?.totalNetweight?.toStringAsFixed(2) + " "+data?.unit??"",
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.normal),
          ),
          Padding(padding: const EdgeInsets.all(5.0)),
          InkWell(
            onTap: () async {
              double netweightnew = 0;
              if (data.totalNetweight == data.netweight) {
                addValue(data, netweightnew, 1,0);
              } else {
                netweightnew = data.totalNetweight - data.netweight;
                double dbQuantityLocalnew = data.quantityLocal -1;
                addValue(data, netweightnew, 2,dbQuantityLocalnew);
              }
            },
            child: Icon(
              Icons.remove_circle_outline,
              color: MyColors.darkgrey_60,
              size: 30.0,
            ),
          ),
          Padding(padding: const EdgeInsets.all(5.0))
        ],
      ),
    );
  }

  void addValue(AddTocartLocal data, double netweightNew, int deleteFlag,double qty) {
    var cartData = AddTocartLocal(
        dsno: data.dsno,
        productName: data.productName,
        aliasName: data.aliasName,
        saleRate: data.saleRate,
        grossweight: data.grossweight,
        netweight: data.netweight,
        totalNetweight: netweightNew,
        quantityLocal: qty,
        imagePath: data.imagePath,
        category: data.category,
        patternid:data.patternid,
        weight:data.weight,
        unit:data.unit,
        mainproductsno:data.mainproductsno,
        purchaserate:data.purchaserate,
        mrp:data.mrp,
        discountpercent:data.discountpercent
    );

    dbHelper.upsertProduct(cartData).then((value) {
      if (deleteFlag == 1) {
        //to remove
        dbHelper.deleteProduct(data.dsno); //delete last value in database
        CommonUtills.showtoast("Successfully Remove");
      } else if (deleteFlag == 2) {
        CommonUtills.showtoast("Successfully Remove");
      } else {
        CommonUtills.showtoast("Successfully Added");
      }
      setState(() {
        data.totalNetweight = netweightNew; //set new value in UI
        data.quantityLocal = qty;
      });
    });
  }

  void confirmDelete() {
    // set up the buttons
    Widget logoutButton = RaisedButton(
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ).tr(),
      shape: CommonWidgets.buttonshape(),
      onPressed: () {
        // _getStatus(myfavoritedata.id,index,list);
        // Get.back();
        dbHelper.deleteAllProduct();
        Get.offAll(HomePage());
      },
    );
    Widget CancelButton = RaisedButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ).tr(),
      shape: CommonWidgets.buttonshape(),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
          child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "Are you sure you want to remove yours all items!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            TextSpan(
                text: "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            TextSpan(
                text: "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      )

          /*Row(children: [
        Text('areyousure',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700)).tr(),
        Text(myfavoritedata.name,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight :FontWeight.w700)).tr(),
        Text('markasunfav',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight :FontWeight.w700)).tr(),

      ],)*/
          ),
      actions: [
        logoutButton,
        CancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
