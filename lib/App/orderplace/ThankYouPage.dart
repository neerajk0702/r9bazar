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

class ThankYouPage extends StatefulWidget {
  @override
  ThankYouPageState createState() => ThankYouPageState();
String orderId;
  ThankYouPage({this.orderId});
}

class ThankYouPageState extends State<ThankYouPage> {
  final MyOrdersController controller = Get.put(MyOrdersController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.accountDetailsSC();
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
                    child:Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 200,margin: EdgeInsets.only(top: 30, bottom: 0, left: 0, right: 0),alignment:Alignment.topCenter,
                            child:  FittedBox(
                              fit: BoxFit.cover,
                              child: SvgPicture.asset(
                                'assets/images/undrawhappybirthday.svg',
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
                            alignment: Alignment.topCenter,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SvgPicture.asset(
                                'assets/images/congratulations.svg',
                              ),
                            ),
                          ),
                          Container(
                              margin:
                              EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
                              alignment: Alignment.center,
                              child: Text(
                                'Congratulations your order has been placed successfully',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              )),
                          Container(
                              margin:
                              EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
                              alignment: Alignment.center,
                              child: Text(
                                'ORDERID : '+widget.orderId??"",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              )),
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 20),
                            child: RaisedButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal),
                              ).tr(),
                              shape: CommonWidgets.buttonshape(),
                              onPressed: () async {
                                Get.offAll(HomePage());
                              },
                            ),
                          ),
                          /*Container(
                margin: EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 20),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Notnow',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ).tr()))*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                        Get.offAll(HomePage());
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Order Confirm",
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

}
