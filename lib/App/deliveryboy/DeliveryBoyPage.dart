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
                                bottom: 10, top: 0, left: 5, right: 5),
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
                      icon: Icon(Icons.arrow_back_ios,  color: MyColors.primaryColor,),
                      onPressed: () {
                        // Get.offAll(HomePage());
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Orders",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
      margin: const EdgeInsets.only(bottom: 10, top: 0, left: 5, right: 5),
      child: controller?.deliveryOrderData?.orders != null
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
          "No data found",
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
        Get.to(DeliveryOrderDetailsPage(product: data));
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                bottom: 0, top: 5, left: 5, right: 5),
                            child: Text(
                              "Order ID: "+data?.orderid,
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
                              data?.contactpersonName,
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
                              data?.contactpersonMobile,
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
                              data?.deliveryAllottedDate ,
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
                              "Rs " +data?.totalValue.toString() ,
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
                              data?.address,
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
                              data?.city+" "+data?.state+" "+data?.pinCode,
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
                              "Order Status: "+getOrderStatus(data?.orderStatus),
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
                              "Delivered status: "+getOrderStatus(data?.deliveredstatus),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          // _getProductsaveDetails(data),
                        ],
                      ))
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
    } else {
      return 'Pending';
    }
  }
}
