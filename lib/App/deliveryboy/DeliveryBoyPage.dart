import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/CityModel.dart';
import 'package:rbazaar/App/myorders/MyOrdersController.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/commonwidgets.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'DeliveryController.dart';
import 'DeliveryOrderDetailsPage.dart';
import 'DeliveryOrderModel.dart';
import 'DeliveryServicecaller.dart';

class DeliveryBoyPage extends StatefulWidget {
  @override
  DeliveryBoyPageState createState() => DeliveryBoyPageState();
  String orderId;

  DeliveryBoyPage({this.orderId});
}

class DeliveryBoyPageState extends State<DeliveryBoyPage> {
  final DeliveryController controller = Get.put(DeliveryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.orderlistSC();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      color: MyColors.lightblue1,
      child: Stack(
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
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Obx(() => Container(
                        height: Get.height,
                        margin: const EdgeInsets.only(
                            bottom: 10, top: 0, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildProductWidget(),
                            ),
                            SizedBox(
                              height: 90,
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
                  icon: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
                  onPressed: () {
                    // Get.offAll(HomePage());
                  },
                ),
                Expanded(
                  child: Text(
                    "Orders",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProductWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 0, left: 0, right: 0),
      child: controller?.deliveryOrderData?.orders?.length >0
          ? ListView.builder(
              itemCount: controller?.deliveryOrderData?.orders?.length,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _productItemWidget(
                    controller?.deliveryOrderData?.orders[index], index);
              })
          : Container(
              alignment: Alignment.center,
              margin:
                  const EdgeInsets.only(bottom: 0, top: 5, left: 5, right: 5),
              child: Text(
                "No order found",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  Widget _productItemWidget(Orders data, index) {
    return InkWell(
      onTap: () {
        // Get.to(DeliveryOrderDetailsPage(product: data));
        if(data?.deliveredstatus=='P'){
          confirm(data);
        }else{
          CommonUtills.flutterToast('This order has been '+data?.orderFullstatus);
        }

      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Container(
            margin: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 5, left: 5, right: 5),
                            child: Text(
                              "Order ID: " + data?.orderid,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 5, left: 5, right: 5),
                            child: Text(
                              "Name: "+data?.contactpersonName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 3, top: 5, left: 5, right: 10),
                            child: Text(
                              "Mobile: "+data?.contactpersonMobile,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 3, top: 0, left: 5, right: 10),
                            child: Text(
                              "Delivery Date: "+data?.deliveryAllottedDate,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 3, top: 0, left: 5, right: 10),
                            child: Text(
                              "Rs " + data?.totalValue.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 3, top: 0, left: 5, right: 10),
                            child: Text(
                              "Address :"+data?.address,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 3, top: 0, left: 5, right: 10),
                            child: Text(
                              data?.city +
                                  " " +
                                  data?.state +
                                  " " +
                                  data?.pinCode,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                bottom: 3, top: 0, left: 5, right: 10),
                            child: Text(
                              "Order Status: " +
                                  getOrderStatus(data?.orderStatus),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                bottom: 3, top: 0, left: 5, right: 10),
                            child: Text(
                              "Delivered status: " +
                                  getOrderStatus(data?.deliveredstatus),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          // _getProductsaveDetails(data),
                        ],
                      )
                    ],
                  ),
                ])),
      ),
    );
  }

  getOrderStatus(String orderStatus) {
    if (orderStatus == 'P') {
      return 'Pending';
    } else if (orderStatus == 'C') {
      return 'Complete';
    } else if (orderStatus == 'CC') {
      return 'Cancel';
    } else if (orderStatus == 'D') {
      return 'Delivered';
    } else {
      return 'Pending';
    }
  }

  showSpamAlertDialog(BuildContext context, Orders data) {
    // set up the buttons
    Widget logoutButton = Container(
        width: 100,
        child: RaisedButton(
          child: Text(
            "Deliver",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ).tr(),
          shape: CommonWidgets.buttonshape(),
          onPressed: () {
            CommonUtills.flutterToast(
                "This order has been deliver successfully");
            Navigator.of(context).pop();
          },
        ));
    Widget CancelButton = Container(
        width: 100,
        child: RaisedButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ).tr(),
          shape: CommonWidgets.buttonshape(),
          onPressed: () {
            Navigator.pop(context);
          },
        ));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to deliver this order ID: " +
              data?.orderid)
          .tr(),
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

  void confirm(Orders data) {
    // set up the buttons

    Widget logoutButton = Container(
        width: 100,
        child: RaisedButton(
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ).tr(),
          shape: CommonWidgets.buttonshape(),
          onPressed: () async {
            SharedPref pref = SharedPref();
            var userInfo = await pref.read("userId");
            if (userInfo != null && userInfo != '') {
              if (await controller.deliverOrder(data?.orderid,
                  data?.productDispatchedSno, controller.Reason)) {
                CommonUtills.flutterToast(controller.errorValue);
                controller.orderlistSC();
              } else {
                CommonUtills.flutterToast(controller.errorValue);
              }
            }
            Navigator.of(context).pop();
          },
        ));

    Widget CancelButton = Container(
        width: 100,
        child: RaisedButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ).tr(),
          shape: CommonWidgets.buttonshape(),
          onPressed: () {
            Navigator.pop(context);
          },
        ));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
          margin: const EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
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
              hintText: 'Enter remarks',

              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: MyColors.primaryColor,
                  )),
              isDense: true,
              // Added this
              contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            ),
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
          )),
      title: Container(
          child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "Are you sure you want to deliver this order ID: " +
                    data?.orderid,
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
