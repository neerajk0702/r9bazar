import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/address/CityModel.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/database/DBHelperNew.dart';
import 'package:rbazaar/App/database/SQLiteDbProvider.dart';
import 'package:rbazaar/App/model/User.dart';
import 'package:rbazaar/App/productlist/ProductListPage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AddTocartLocal.dart';
import 'AddressController.dart';
import 'AddressModel.dart';
import 'StateModel.dart';

class AddEditAddressPage extends StatefulWidget {
  @override
  AddEditAddressPageState createState() => AddEditAddressPageState();

  AddEditAddressPage();
}

class AddEditAddressPageState extends State<AddEditAddressPage> {
  bool isLoading;
  String path;
  final AddressController controller = Get.put(AddressController());
  States _selectedState;
  Citys _selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    isLoading = true;
    super.initState();
    controller.getAllState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
          Obx(() =>Center(child:controller.isProcessing? SizedBox(
            height: 10,
          ):Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10, left: 0, right: 0),
              child: CircularProgressIndicator()),),),
          Expanded(child:  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:  Obx(() =>
                   Container(   height: Get.height,
                margin: const EdgeInsets.only(
                    bottom: 0, top: 10, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changeFullname(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            // errorText: snapshot.hasError ? snapshot.error : null,
                            hintText: 'Full Name',
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
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changePhone(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // errorText: snapshot.hasError ? snapshot.error : null,
                            hintText: 'Phone',

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
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changeFlatNo(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            // errorText: snapshot.hasError ? snapshot.error : null,
                            hintText: 'House/Flat No',
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
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changeTower(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Building Name/Towers',
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
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changestreet(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Street',
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
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changeSector(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Locality/Sector',
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
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changeLandmark(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Landmark',
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
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 10, left: 0, right: 0),
                        child: TextField(
                          onChanged: (text) {
                            // When user enter text in textfield getXHelper checktext method will get called
                            controller.changePincode(text);
                          },
                          // controller: email,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // errorText: snapshot.hasError ? snapshot.error : null,
                            hintText: 'Pincode',
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
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, top: 10, left: 0, right: 0),
                      child: Text(
                        "Select a state",
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 60,
                      child:  InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(5.0))),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _selectedState,
                              items: controller.StateDropdownMenuData,
                              onChanged: onChangeStateDropdownItem,
                            )),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, top: 10, left: 0, right: 0),
                      child: Text(
                        "Select a City",
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 60,
                      child:  InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    5.0))),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _selectedCity,
                              items:
                              controller?.CityDropdownMenuData,
                              onChanged: onChangeCityDropdownItem,
                            )),
                      ),
                    )
                  ],
                ),
              )
                   )),),

          InkWell(
              onTap: () async {
                SharedPref pref = SharedPref();
                var userInfo = await pref.read("userId");
                if(userInfo!=null && userInfo!=''){
                  if (await controller.saveAddress(userInfo)) {
                    CommonUtills.flutterToast(controller?.errorValue);
                    Get.back();
                  } else {
                    CommonUtills.flutterToast(controller?.errorValue);
                  }
                }else{
                  Get.to(LoginPage());
                }

              },
              child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: MyColors.lightblue,
                  child: Text(
                    "Save Address",
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )))
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
                    "Add New Address",
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

  onChangeStateDropdownItem(States selected) {
    setState(() {
      _selectedState = selected;
      if (selected != null) {
        controller.changeselectedStateData(selected);
        print('city call');
        controller.getAllCity(selected?.sno);
      }
    });
  }

  onChangeCityDropdownItem(Citys selected) {
    setState(() {
      _selectedCity = selected;
      controller.changeselectedCityData(selected);
    });
  }

  Widget _buildAddressWidget(AddressModel data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.only(bottom: 10, top: 0, left: 5, right: 5),
              child: ListView.builder(
                  itemCount: data?.userAddress?.length,
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _ItemWidget(data.userAddress[index], index);
                  }),
            ),
          ),
          InkWell(
              onTap: () async {
                SharedPref pref = SharedPref();
                var userInfo = await pref.read("ProductDetails");
                if (userInfo != null) {
                } else {}
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: MyColors.lightblue,
                  child: Text(
                    "Continue",
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

  Widget _ItemWidget(UserAddress data, index) {
    return InkWell(
        onTap: () {
          setState(() {
            data.selectFlag = true;
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
                              bottom: 0, top: 10, left: 0, right: 5),
                          child: Text(
                            data?.address,
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
                            data?.city +
                                " " +
                                data?.state +
                                " " +
                                data?.pinCode,
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
                            data?.landMark,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ]),
                ),
                data?.selectFlag
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
