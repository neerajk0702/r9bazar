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

class FlashSalePage extends StatefulWidget {
  @override
  FlashSalePageState createState() => FlashSalePageState();

  FlashSalePage();
}

class FlashSalePageState extends State<FlashSalePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.flaseSaleSC();
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
                        "Flash Sale",
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
      child: controller?.FlashSaleReportModelData?.flashSaleList != null
          ? ListView.builder(
          itemCount: controller?.FlashSaleReportModelData?.flashSaleList.length,
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () async {
                  Get.to(ProductListDetailsPage(
                      productName:
                      controller?.FlashSaleReportModelData?.flashSaleList[index]?.productName,
                      catId: int.parse(
                          controller?.FlashSaleReportModelData?.flashSaleList[index].category),
                      imagePath: Constants.imageUrl +
                          controller?.FlashSaleReportModelData?.flashSaleList[index]?.folderName +
                          controller?.FlashSaleReportModelData?.flashSaleList[index]
                              ?.image1Filename ??
                          "",
                      productTitle:
                      controller?.FlashSaleReportModelData?.flashSaleList[index]?.productName,
                      productsno: controller?.FlashSaleReportModelData?.flashSaleList[index]?.sno,
                      mainproductsno: controller?.FlashSaleReportModelData?.flashSaleList[index]?.sno,
                      aliasName:controller?.FlashSaleReportModelData?.flashSaleList[index]?.aliasName));
                },
                child: Container(
                  width: Get.width,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      top: 0, bottom: 5, left: 0, right: 0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container( height:
                        CommonUtills.displayHeight(context) / 3.5,
                          child:  ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            child: FadeInImage(
                              image: NetworkImage(Constants.imageUrl +
                                  controller?.FlashSaleReportModelData?.flashSaleList[index]
                                      ?.folderName +
                                  controller?.FlashSaleReportModelData?.flashSaleList[index]
                                      ?.image1Filename ??
                                  ""),
                              placeholder: AssetImage(
                                  'assets/images/placeholder.png'),
                              fit: BoxFit.fill,
                            ),
                          ),),

                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 3, top: 5.0, left: 5, right: 3),
                          child: Text(
                            "Rs " +
                                controller?.FlashSaleReportModelData?.flashSaleList[index]?.saleRate
                                    .toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                bottom: 15, top: 0, left: 5, right: 3),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  controller?.FlashSaleReportModelData?.flashSaleList[index]
                                      ?.productName,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ).tr(),
                              ],
                            )),
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
