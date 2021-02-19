import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/AddEditAddressPage.dart';
import 'package:rbazaar/App/address/AddressController.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/database/DBHelperNew.dart';
import 'package:rbazaar/App/database/SQLiteDbProvider.dart';
import 'package:rbazaar/App/model/User.dart';
import 'package:rbazaar/App/orderplace/OrderPlacePage.dart';
import 'package:rbazaar/App/productlist/ProductListPage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import 'AddressModel.dart';

class AddressPage extends StatefulWidget {
  @override
  AddressPageState createState() => AddressPageState();
  String phone;
  int selectPosition;
  int addressSno=0;

  AddressPage({this.phone});
}

class AddressPageState extends State<AddressPage> {
  // AddressListBloc bloc = AddressListBloc();
  final AddressController controller = Get.put(AddressController());
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloc.getAddressListData(widget.phone);
    controller.getAddressListData(widget.phone);
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
                                  bottom: 10, top: 10, left: 0, right: 0),
                              child: _buildAddressWidget(),
                            ))),
                  ),
                  Container(
                      height: 50,
                      child: InkWell(
                          onTap: () async {
                            SharedPref pref = SharedPref();
                            var userInfo = await pref.read("userId");
                            if (userInfo != null && userInfo != '') {
                              if(widget.addressSno>0){
                                Get.to(OrderPlacePage(addressSno:widget.addressSno));
                              }else{
                                CommonUtills.flutterToast("Please select anyone deliver address!");
                              }
                            } else {
                              Get.to(LoginPage());
                            }
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              color: MyColors.lightblue,
                              child: Text(
                                "Continue",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ))))
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
                    "Deliverry Address",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon:
                        Icon(FontAwesomeIcons.plusCircle, color: Colors.white),
                    onPressed: () {
                      Get.to(AddEditAddressPage());
                    },
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAddressWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          controller?.AddressListData?.userAddress!=null
              ? Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                        bottom: 10, top: 0, left: 5, right: 5),
                    child: ListView.builder(
                        itemCount:
                            controller?.AddressListData?.userAddress.length,
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _ItemWidget(
                              controller?.AddressListData?.userAddress[index],
                              index);
                        }),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      bottom: 0, top: 5, left: 5, right: 5),
                  child: Text(
                    "No data found",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),


        ],
      ),
    );
  }

  Widget _ItemWidget(UserAddress data, index) {
    return InkWell(
        onTap: () {
          setState(() {
            widget.selectPosition = index;
            widget.addressSno=data.sno;
          });
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.addressCard,
                        color: MyColors.lightgreenprogress),
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              bottom: 0, top: 5, left: 0, right: 5),
                          child: Text(
                            data?.fullName ?? "",
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
                              bottom: 0, top: 3, left: 0, right: 5),
                          child: Text(
                            data?.mobileno2 ?? "",
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
                              bottom: 0, top: 3, left: 0, right: 5),
                          child: Text(
                            data?.address ?? "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  bottom: 0, top: 3, left: 0, right: 5),
                              child: Text(
                                data?.city ?? "",
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
                                  bottom: 0, top: 3, left: 0, right: 5),
                              child: Text(
                                data?.state ?? "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              bottom: 0, top: 3, left: 0, right: 5),
                          child: Text(
                            data?.pinCode ?? "",
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
                              bottom: 0, top: 3, left: 0, right: 5),
                          child: Text(
                            data?.landMark ?? "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ]),
                ),
                widget.selectPosition == index
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.checkCircle,
                              color: MyColors.lightgreenprogress),
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                        ),
                      )
                    : SizedBox()
              ],
            ),
            Divider(), //
          ],
        ));
  }
}
