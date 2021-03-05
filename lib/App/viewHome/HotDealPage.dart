import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/CityModel.dart';
import 'package:rbazaar/App/productdetails/ProductListDetailsPage.dart';
import 'package:rbazaar/utils/StrikeThroughWidget.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import 'HomeController.dart';

class HotDealPage extends StatefulWidget {
  @override
  HotDealPageState createState() => HotDealPageState();

  HotDealPage();
}

class HotDealPageState extends State<HotDealPage> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.hotDealSC();
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
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Text(
                    "Best Selling",
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
      margin: const EdgeInsets.only(bottom: 10, top: 0, left: 5, right: 5),
      child: controller?.HotdealModelData?.deals != null
          ? ListView.builder(
              itemCount: controller?.HotdealModelData?.deals?.length,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return new InkWell(
                    onTap: () async {
                      Get.to(ProductListDetailsPage(
                          productName:  controller?.HotdealModelData?.deals[index]?.productName,
                          catId: int.parse(controller?.HotdealModelData?.deals[index].category),
                          imagePath: Constants.imageUrl +
                              controller?.HotdealModelData?.deals[index]?.folderName +
                              controller?.HotdealModelData?.deals[index]?.fileName ??
                              "",
                          productTitle: controller?.HotdealModelData?.deals[index]?.productName,
                          productsno: controller?.HotdealModelData?.deals[index]?.productid,
                          mainproductsno: controller?.HotdealModelData?.deals[index]?.productid,
                          aliasName:controller?.HotdealModelData?.deals[index]?.aliasName));
                    },
                    child: Container(
                      width: Get.width,
                      color: MyColors.lightblue1,
                      padding: EdgeInsets.only(
                          top: 3, bottom: 3, left: 2, right: 2),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0))),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container( height:
                            CommonUtills.displayHeight(context) / 3.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                                child: FadeInImage(
                                  // height: 100,
                                  image: NetworkImage(Constants.imageUrl +
                                      controller?.HotdealModelData?.deals[index]?.folderName +
                                      controller?.HotdealModelData?.deals[index]?.fileName ??
                                      ""),
                                  placeholder: AssetImage(
                                      'assets/images/placeholder.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                    bottom: 0, top: 10, left: 7, right: 3),
                                child: Text(
                                  controller?.HotdealModelData?.deals[index]?.productName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal),
                                ).tr()),
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 3,
                                        top: 7,
                                        left: 7,
                                        right: 3),
                                    child: StrikeThroughWidget(
                                      child: Text(
                                          'Rs ' +
                                              controller?.HotdealModelData?.deals[index].mrps
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
                                        controller?.HotdealModelData?.deals[index].saleRate
                                            .toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  bottom: 15, top: 2, left: 7, right: 3),
                              child: Text(
                                controller?.HotdealModelData?.deals[index]?.aliasName,
                                maxLines: 3,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                ),
                              ).tr(),
                            )
                          ],
                        ),
                      ),
                    ));
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

}
