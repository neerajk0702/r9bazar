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

class DeliveryBoyPage extends StatefulWidget {
  @override
  DeliveryBoyPageState createState() => DeliveryBoyPageState();
  String orderId;
  DeliveryBoyPage({this.orderId});
}

class DeliveryBoyPageState extends State<DeliveryBoyPage> {
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
                          Container(
                              margin:
                              EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
                              alignment: Alignment.center,
                              child: Text(
                                'Coming soon........',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              )),
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

}
