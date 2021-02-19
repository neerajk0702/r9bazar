import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/CityModel.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/orderplace/ThankYouPage.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import 'BookingSloatModel.dart';
import 'OrderController.dart';

class OrderPlacePage extends StatefulWidget {
  @override
  OrderPlacePageState createState() => OrderPlacePageState();
  int addressSno;

  OrderPlacePage({this.addressSno});
}

enum paymentMode { COD, ONLINE }

class OrderPlacePageState extends State<OrderPlacePage> {
  final OrderController controller = Get.put(OrderController());
  Slotdate slotdate;
  Slottime slottime;
  paymentMode _site = paymentMode.COD;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrderDetails();
    controller.BookingSlots();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white,
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
                              bottom: 0, top: 10, left: 10, right: 10),
                          child: _buildProductWidget(),
                        ))),
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
                    "Your Checkout",
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
        margin: const EdgeInsets.only(bottom: 0, top: 0, left: 0, right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getDropdownDate(),
            getDropdownTime(),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 8, left: 10, right: 10),
              child: Text(
                "Payment Details",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(bottom: 0, top: 8, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                    " Rs. " + controller.subtotal,
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
              margin:
                  const EdgeInsets.only(bottom: 0, top: 8, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Delivery :",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    " Rs. " + controller.deliverycharge,
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
              margin:
                  const EdgeInsets.only(bottom: 0, top: 5, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "You Saved :",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    " -Rs. " + controller.discountAmount,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(
                  bottom: 10, top: 5, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Total :",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    " Rs. " + controller.totalAmount,
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
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 8, left: 10, right: 10),
              child: Text(
                "Have a coupon/referral code? Apply",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    bottom: 0, top: 5, left: 10, right: 10),
                child: TextField(
                  onChanged: (text) {
                    // When user enter text in textfield getXHelper checktext method will get called
                    controller.changepromoCode(text);
                  },
                  // controller: email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    // errorText: snapshot.hasError ? snapshot.error : null,
                    hintText: 'Type your code here',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
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
                    EdgeInsets.fromLTRB(10, 10, 10, 10),
                  ),
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                )),
            Divider(
              color: Colors.white,
            ),
            Row(children: [
              Expanded(child:  ListTile(
                title: Text(
                  "COD",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: paymentMode.COD,
                  groupValue: _site,
                  onChanged: (paymentMode value) {
                    setState(() {
                      _site = value;
                    });
                  },
                ),
              ),),
              Expanded(child:  ListTile(
                title: Text(
                  "Pay Now",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: paymentMode.ONLINE,
                  groupValue: _site,
                  onChanged: (paymentMode value) {
                    setState(() {
                      _site = value;
                    });
                  },
                ),
              ),)

            ],),
            submitButton()

          ],
        ));
  }
  Widget submitButton() {
    double height45 = MediaQuery.of(context).size.height * 0.05656804733;
    double width230 = MediaQuery.of(context).size.width * 0.54;
    return FlatButton(
      onPressed: () async {
        SharedPref pref = SharedPref();
        var userInfo = await pref.read("userId");
        if(userInfo!=null && userInfo!='') {
          if (await controller.placeOrder(widget.addressSno, slotdate?.slotdate??"", slottime?.sno??0, userInfo, controller.deliverycharge,_site.toString())) {
            DBHelper dbHelper = DBHelper();
            dbHelper.deleteAllProduct();
            Get.offAll(HomePage());
            CommonUtills.flutterToast(controller.errorValue);
          }else{
            CommonUtills.flutterToast(controller.errorValue);
          }
        }else{
          Get.to(LoginPage());
        }
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height:height45 ,
        margin: const EdgeInsets.only(bottom: 0, top: 40, left: 15, right: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(5.0),
              bottomRight: const Radius.circular(5.0),
              bottomLeft: const Radius.circular(5.0),
              topLeft: const Radius.circular(5.0)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7],
            colors: [
              Color(0xFF25306a),
              Color(0xFF25306a),
            ],
          ),
          color: Color(0xff312E32),
        ),
        child: Center(
            child: Text(
              "Place Your Order",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                // color: Colors.white,
              ),
            )),
      ),
    );
  }
  getDropdownDate() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: (controller?.BookingSloat != null)
          ? Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.0,
                  ),
                  isDense: true,
                  isExpanded: true,
                  items: controller?.BookingSloat?.slotdate?.map((Slotdate item) {
                        return new DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              item.slot1,
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          value: item,
                        );
                      })?.toList() ??
                      [],
                  hint: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Select Slot Date",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  onChanged: (newVal) {
                    setState(() {
                      slotdate = newVal;
                      setState(() {});
                    });
                  },
                  value: slotdate,
                ),
              ),
            )
          : Container(
              child: Center(
                child: Text(
                  "Loading Booking Sloat...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor,
                  ),
                ),
              ),
            ),
    );
  }

  getDropdownTime() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: (controller?.BookingSloat != null)
          ? Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.0,
                  ),
                  isDense: true,
                  isExpanded: true,
                  items:
                      controller?.BookingSloat?.slottime?.map((Slottime item) {
                            return new DropdownMenuItem(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: new Text(
                                  item.slottime,
                                  style: TextStyle(fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              value: item,
                            );
                          })?.toList() ??
                          [],
                  hint: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Select Slot Time",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  onChanged: (newVal) {
                    setState(() {
                      slottime = newVal;
                      setState(() {});
                    });
                  },
                  value: slottime,
                ),
              ),
            )
          : Container(
              child: Center(
                child: Text(
                  "Loading Booking Sloal Time...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor,
                  ),
                ),
              ),
            ),
    );
  }
}
