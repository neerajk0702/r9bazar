import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/productdetails/ProductListDetailsPage.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/commonwidgets.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';

import 'DeliveryOrderModel.dart';


class DeliveryOrderDetailsPage extends StatefulWidget {
  @override
  DeliveryOrderDetailsPageState createState() => DeliveryOrderDetailsPageState();
  Orders product;

  DeliveryOrderDetailsPage({this.product});
}

class DeliveryOrderDetailsPageState extends State<DeliveryOrderDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  // final MyOrdersController controller = Get.put(MyOrdersController());

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
            color: MyColors.lightblue1,
            child: Stack(
              children: [
               /* SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
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
                              image: NetworkImage(Constants.imageUrl +
                                  widget.product?.subfoldername +
                                  widget.product?.subfilename ??
                                  ""),
                              placeholder:
                              AssetImage('assets/images/placeholder.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 10, left: 10, right: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 10, left: 5, right: 5),
                                    child: Text(
                                      widget.product?.productName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 5, left: 5, right: 5),
                                    child: Text(
                                      widget.product?.subproductname,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ]),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 15, left: 10, right: 5),
                            child: Text(
                              "DELIVERY SLOT",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 10, left: 10, right: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(
                                            bottom: 0, top: 3, left: 5, right: 5),
                                        child: Text(
                                          widget.product?.bookingDateTime,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(
                                            bottom: 0, top: 3, left: 5, right: 5),
                                        child: Text(
                                          widget.product?.bookingtime,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              bottom: 0, top: 3, left: 5, right: 5),
                                          child: Text(
                                            "Order Status:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(
                                            bottom: 0, top: 3, left: 5, right: 5),
                                        child: Text(
                                          getOrderStatus(
                                              widget.product?.orderStatus),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ]),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 5, left: 10, right: 5),
                            child: Text(
                              "ADDRESS",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 10, left: 10, right: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 5, right: 5),
                                    child: Text(
                                      widget.product?.addressFullname,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 5, left: 5, right: 5),
                                    child: Text(
                                      widget.product?.address,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 5, right: 5),
                                    child: Text(
                                      widget.product?.landmark,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 5, right: 5),
                                    child: Text(
                                      widget.product?.city +
                                          " " +
                                          widget.product?.state,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 5, right: 5),
                                    child: Text(
                                      widget.product?.pincode,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ]),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 5, left: 10, right: 5),
                            child: Text(
                              "PAYMENT DETAILS",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 10, left: 10, right: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              bottom: 0, top: 3, left: 5, right: 5),
                                          child: Text(
                                            "Order No:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(
                                            bottom: 0, top: 3, left: 5, right: 5),
                                        child: Text(
                                          widget.product?.itemOrderId,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              bottom: 0, top: 3, left: 5, right: 5),
                                          child: Text(
                                            "Bill No:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(
                                            bottom: 0, top: 3, left: 5, right: 5),
                                        child: Text(
                                          widget.product?.billno,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              bottom: 0, top: 3, left: 5, right: 5),
                                          child: Text(
                                            "Weight:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(
                                            bottom: 0, top: 3, left: 5, right: 5),
                                        child: Text(
                                          "Gross wt." +
                                              widget.product?.grossweight.toString() +
                                              " | Net wt." +
                                              widget.product?.netweight.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              bottom: 0, top: 3, left: 5, right: 5),
                                          child: Text(
                                            "Total:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(
                                            bottom: 0, top: 3, left: 5, right: 5),
                                        child: Text(
                                          "Rs " +
                                              widget.product?.grossAmount
                                                  .toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  getOrderStatusShow(
                                      widget.product?.orderStatus)?
                                  InkWell(
                                      onTap: () async {
                                        confirmDelete();
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          color: MyColors.lightblue,
                                          child: Text(
                                            "Cancel Order",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ))): SizedBox(
                                    height: 10,
                                  )
                                ]),
                          )
                        ],
                      )),
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
                          margin:
                          EdgeInsets.only(top: 10, left: 0, right: 0),
                          child: CircularProgressIndicator()),
                    ),
                  ),
                )*/
              ],
            )));
  }

  getOrderStatus(String orderStatus) {
    if (orderStatus == 'P') {
      return 'Pending';
    } else if (orderStatus == 'C') {
      return 'Complete';
    } else if (orderStatus == 'CC') {
      return 'Cancel';
    } else {
      return 'Pending';
    }
  }
  getOrderStatusShow(String orderStatus) {
    if (orderStatus == 'P') {
      return true;
    } else if (orderStatus == 'C') {
      return false;
    } else if (orderStatus == 'CC') {
      return false;
    } else {
      return false;
    }
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
                    Text(
                      "Order Details",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

/*  void confirmDelete() {
    // set up the buttons
    Widget logoutButton = RaisedButton(
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ).tr(),
      shape: CommonWidgets.buttonshape(),
      onPressed: () async {
        SharedPref pref = SharedPref();
        var userInfo = await pref.read("userId");
        if (userInfo != null && userInfo != '') {
          if(await controller.CancelOrder(
              widget.product?.sno,
              widget.product?.saleId,
              widget.product?.itemOrderId,
              controller.Reason,
              userInfo)){
            CommonUtills.flutterToast(controller.errorValue);
            Get.offAll(HomePage());
          }else{
            CommonUtills.flutterToast(controller.errorValue);
          }

        }
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
      content:  Container(
          margin: const EdgeInsets.only(
              bottom: 0, top: 0, left: 10, right: 10),
          child: TextField(
            onChanged: (text) {
              // When user enter text in textfield getXHelper checktext method will get called
              controller.changeReason(text);
            },
            enabled: true,

            // controller: email,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              // errorText: snapshot.hasError ? snapshot.error : null,
              hintText: 'Reason for cancel order',

              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                new BorderRadius.circular(10.0),
                borderSide:
                BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  new BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: MyColors.primaryColor,
                  )),
              isDense: true,
              // Added this
              contentPadding:
              EdgeInsets.fromLTRB(10, 20, 10, 10),
            ),
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
          )),
      title: Container(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "Are you sure you want to cancel yours order!",
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

        *//*Row(children: [
        Text('areyousure',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700)).tr(),
        Text(myfavoritedata.name,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight :FontWeight.w700)).tr(),
        Text('markasunfav',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight :FontWeight.w700)).tr(),

      ],)*//*
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
  }*/
}
