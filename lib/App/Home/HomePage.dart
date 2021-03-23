import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/Test/PDFViewerFromUrl.dart';
import 'package:rbazaar/App/changepassword/ChangePasswordPage.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/deliveryboy/DeliveryBoyHomePage.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/App/myorders/MyOrdersPage.dart';
import 'package:rbazaar/App/orderplace/ThankYouPage.dart';
import 'package:rbazaar/App/productdetails/CartListPage.dart';
import 'package:rbazaar/App/productdetails/ProductListDetailsPage.dart';
import 'package:rbazaar/App/productdetails/SingleProductDetailsPage.dart';
import 'package:rbazaar/App/profile/ProfilePage.dart';
import 'package:rbazaar/App/searchproduct/SearchProductPage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryPage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryTabPage.dart';
import 'package:rbazaar/App/viewHome/FlashSalePage.dart';
import 'package:rbazaar/App/viewHome/HotDealPage.dart';
import 'package:rbazaar/App/webview/WebPage.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/StrikeThroughWidget.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/commonwidgets.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'Homemodel.dart';
import 'MyAccountDetailsController.dart';
import 'SliderModel.dart';
import 'homebloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  HomeBloc bloc = HomeBloc();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  String username = "", useremail = "", userimage = "", phone = "";
  int difficultyLevel, ageSegment;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final MyAccountDetailsController controller =Get.put(MyAccountDetailsController());
  String cuttentLocation = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval((1 / 9) * 1, 1.0, curve: Curves.fastOutSlowIn)));
    gettingCurrentLocationSave();
    controller.accountDetailsSC();
    bloc.getHomeData();

    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            key: _scaffoldState,
            drawer: Drawer(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Obx(() => createDrawerHeader()),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.offAll(HomePage());
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 0, left: 15, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.home,
                                color: MyColors.lightblue,
                                size: 28,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () async {
                          SharedPref pref = SharedPref();
                          var userInfo = await pref.read("userId");
                          if (userInfo != null && userInfo != '') {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProfilePage()));
                          } else {
                            Get.to(LoginPage());
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 0, left: 15, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: MyColors.lightblue,
                                size: 28,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'My Account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () async {
                          SharedPref pref = SharedPref();
                          var userInfo = await pref.read("userId");
                          if (userInfo != null && userInfo != '') {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyOrdersPage()));
                          } else {
                            Get.to(LoginPage());
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_basket_sharp,
                                color: MyColors.lightblue,
                                size: 28,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'My Orders',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () async {
                          SharedPref pref = SharedPref();
                          var userInfo = await pref.read("userId");
                          if (userInfo != null && userInfo != '') {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChangePasswordPage()));
                          } else {
                            Get.to(LoginPage());
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                color: MyColors.lightblue,
                                size: 28,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => WebPage(
                                  url:
                                      'https://www.r9bazaar.com/resources/page/contact.html',
                                  title: 'Contact us')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.call,
                                color: MyColors.lightblue,
                                size: 28,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () {
                          showSpamAlertDialog(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 0, bottom: 15, left: 15, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: MyColors.lightblue,
                                size: 28,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ).tr(),
                            ],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          top: 5, bottom: 5, left: 15, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(color: Colors.black),
                          ),
                          Text(
                            'Other Link',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Expanded(
                            child: Divider(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          // showCourseCompleteDialog();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => WebPage(
                                  url:
                                      'https://www.r9bazaar.com/resources/page/faq.html',
                                  title: 'FAQs')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                              /*   Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'FAQs',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => WebPage(
                                  url:
                                      'https://www.r9bazaar.com/resources/page/termscondition.html',
                                  title: 'Terms and Conditions')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                              /*Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => WebPage(
                                  url:
                                      'https://www.r9bazaar.com/resources/page/privacypolicy.html',
                                  title: 'Privacy Policy')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                              /*Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    Divider(),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => WebPage(
                                  url:
                                      'https://www.r9bazaar.com/resources/page/refundpolicy.html',
                                  title: 'Refund Return Cancellation Policy')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                              /*Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Refund Policy',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),

                    /* Divider(),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => WebPage(url:'https://r9bazaar.com/aboutus',title:'About us')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 10),
                          child: Row(
                            children: [
                             */ /* Icon(
                                Icons.question_answer_rounded,
                                color: MyColors.lightblue,
                                size: 28,
                              ),*/ /*
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'About us',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),*/

                    Container(
                      padding: EdgeInsets.only(top: 10, left: 0, right: 10),
                      alignment: Alignment.centerRight,
                      child: Text('App version 1.0.0'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              height: Get.height,
              width: Get.width,
              color: MyColors.lightblue1,
              padding: EdgeInsets.only(top: 0, left: 0, right: 0),
              child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                            child: StreamBuilder<Homemodel>(
                          stream: bloc.homeServiceSubject.stream,
                          builder:
                              (context, AsyncSnapshot<Homemodel> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.error == null &&
                                  snapshot.data.status == false) {
                                return _buildErrorWidget(snapshot.data.message);
                              } else if (snapshot.error == null &&
                                  snapshot.data.isNull) {
                                return _buildErrorWidget("No Data Found");
                              } else if (snapshot.error != null ||
                                  snapshot.data.isNull) {
                                return _buildErrorWidget(snapshot.error);
                              }
                              return _buildUserWidget(snapshot.data);
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget(snapshot.error);
                            } else {
                              return Positioned(
                                  child: Center(child: _buildLoadingWidget()));
                            }
                          },
                        )),
                        /*Positioned(
                            child:
                                Center(child: _buildLoadingWidgetForComment())),*/
                      ],
                    ),

                    ////
                  )),
            )));
  }

  Widget _topBar(Homemodel data) {
    return Container(
      color: MyColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Row(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () =>
                          _scaffoldState.currentState.openDrawer())),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 0, left: 0, right: 0),
                                  child: Text(
                                    'Choose delivery location',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              InkWell(
                                  onTap: () {
                                    getlocation();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 10, left: 5, right: 55),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: const Radius.circular(5.0),
                                          bottomRight:
                                              const Radius.circular(5.0),
                                          bottomLeft:
                                              const Radius.circular(5.0),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_location,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Use my location',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ).tr(),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                          content: setupAlertDialoadContainer(data),
                        );
                      });
                },
                child: Container(
                  child: RichText(
                    maxLines: 1,
                    text: TextSpan(children: [
                      TextSpan(
                          text: cuttentLocation == ''
                              ? "Select your location"
                              : cuttentLocation,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                      WidgetSpan(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          )),
          /* Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () => Get.to(SearchProductPage())))),*/
          InkWell(
              onTap: () async {
                DBHelper dbHelper = DBHelper();
                var list = await dbHelper.getAllProduct();
                if (list == null || list.length == 0) {
                  CommonUtills.flutterToast(
                      "Any Item did not found in your cart");
                } else {
                  // Get.to(CartListPage());
                  Get.to(CartListPage()).then((value) {
                    setState(() {
                      controller.accountDetailsSC();
                      bloc.getHomeData();
                    });
                  });
                }
              },
              child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 0, top: 0, left: 5, right: 10),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        height: 30,
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart, color: Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0),
                          shape: BoxShape.circle,
                          // You can use like this way or like the below line
                          //borderRadius: new BorderRadius.circular(30.0),
                          color: Colors.red,
                        ),
                        child: Text(
                          data?.totalItem.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }

  Widget _buildUserWidget(Homemodel data) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _topBar(data),
        /*_name(data),
      _userScore(data),
      data.trendingcourserdata.length>0? _trendingCourse(data):SizedBox(),
      data.courseforyoudata.length>0? _courseForYou(data):SizedBox(),
      data.inProgressListData.length>0? _courseInProgress(data):SizedBox()*/
        Container(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                        bottom: 0, top: 10, left: 10, right: 10),
                    child: TextField(
                      onChanged: (text) {
                        // When user enter text in textfield getXHelper checktext method will get called
                        controller.changeproductname(text);
                      },
                      // controller: email,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // errorText: snapshot.hasError ? snapshot.error : null,
                        hintText: 'Search for product',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0),
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
              ),
              Container(
                  margin: const EdgeInsets.only(
                      bottom: 0, top: 5, left: 0, right: 5),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      iconSize: 35,
                      icon: Icon(Icons.search, color: MyColors.primaryColor),
                      onPressed: () {
                        if (controller.productname == null ||
                            controller.productname == '') {
                          CommonUtills.flutterToast(
                              "Please enter product name");
                        } else {
                          Get.to(SearchProductPage(
                              productName: controller.productname));
                        }
                      }))
            ],
          ),
        ),
        bottomMenu(data),
        topImge(data),
        _hotDeal(data),
        data?.flashSaleList.length > 0
            ? _FlashSale(data)
            : SizedBox(
                height: 10,
              ),
        Container(
            margin: EdgeInsets.only(top: 20, left: 0, right: 0),
            color: Colors.white,
            alignment: Alignment.center,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin:
                        EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
                    child: Text(
                      'Why R9bazaar ?',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 0, left: 20, right: 0),
                          child: Row(
                            children: [
                              Center(
                                child: Container(
                                  height: 40,
                                  child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.asset(
                                        'assets/images/car.png',
                                      )),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 0, left: 5, right: 10),
                                  width: 80,
                                  child: Text(
                                    'Fast And Free Delivery',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          )),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 0, left: 10, right: 20),
                        child: Row(
                          children: [
                            Center(
                              child: Container(
                                height: 50,
                                child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.asset(
                                      'assets/images/organic.png',
                                    )),
                              ),
                            ),
                            Container(
                                margin:
                                    EdgeInsets.only(top: 0, left: 5, right: 5),
                                width: 80,
                                child: Text(
                                  '100% Organic 100% Fresh',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ))
                          ],
                        ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 15, left: 20, right: 0),
                          child: Row(
                            children: [
                              Center(
                                child: Container(
                                  height: 40,
                                  child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.asset(
                                        'assets/images/netweight.png',
                                      )),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 0, left: 5, right: 10),
                                  width: 80,
                                  child: Text(
                                    'Pay Only For NET WEIGHT',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 10, right: 20, bottom: 0),
                        child: Row(
                          children: [
                            Center(
                              child: Container(
                                height: 50,
                                child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.asset(
                                      'assets/images/nowestage.png',
                                    )),
                              ),
                            ),
                            Container(
                                margin:
                                    EdgeInsets.only(top: 0, left: 5, right: 5),
                                width: 80,
                                child: Text(
                                  'No Wastage',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ))
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                )
              ],
            )),
        _category(data),
        Container(
            margin: EdgeInsets.only(top: 20, left: 0, right: 0),
            color: Colors.white,
            alignment: Alignment.center,
            width: double.infinity,
            child: Center(
              child: Container(
                height: 200,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      'assets/images/demo2.jpg',
                    )),
              ),
            )),
      ],
    ));
  }

  Widget topImge(Homemodel data) {
    return SizedBox(
        height: 200,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 0, left: 0, right: 5),
          child: Container(
              height: 200,
              child: ListView.builder(
                  itemCount: data.sliderList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _topImageWidget(data.sliderList[index]);
                  })),
        ));
  }

  Widget bottomMenu(Homemodel data) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 6,
        // width: CommonUtills.displayWidth(context),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 5, left: 0, right: 5),
          child: Container(
              child: ListView.builder(
                  itemCount: data.categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        // width: CommonUtills.displayWidth(context),
                        color: MyColors.lightblue1,
                        padding: EdgeInsets.only(
                            top: 3, bottom: 0, left: 2, right: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: FadeInImage(
                                image: NetworkImage(Constants.imageUrl +
                                        data?.categories[index]?.folderName +
                                        data?.categories[index]?.iconFileName ??
                                    ""),
                                placeholder:
                                    AssetImage('assets/images/placeholder.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 3, top: 10.0, left: 3, right: 3),
                                child: Text(
                                  data?.categories[index]?.menuName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        String bannerImage = Constants.imageUrl +
                            data?.categories[index]?.folderName +
                            data?.categories[index]?.bannerFileName;
                        Get.to(SubCategoryTabPage(
                            catName: data?.categories[index]?.menuName,
                            catId: data?.categories[index]?.sno,
                            catImagePath: bannerImage));
                      },
                    );
                  })),
        ));
  }

  Widget _hotDeal(Homemodel data) {
    return Container(
      color: MyColors.lightblue1,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Best Selling',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.left,
                ).tr(),
              ),
              InkWell(
                  onTap: () {
                    Get.to(HotDealPage());
                  },
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ).tr(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 25,
                      )
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(0),
            child:StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data?.deals.length > 6 ? 6 : data?.deals.length,
              itemBuilder: (BuildContext context, int index) => Container(
                child:  InkWell(
                    onTap: () async {
                      Get.to(ProductListDetailsPage(
                          productName: data?.deals[index]?.productName,
                          catId: int.parse(data?.deals[index].category),
                          imagePath: Constants.imageUrl +
                              data?.deals[index]?.folderName +
                              data?.deals[index]?.fileName ??
                              "",
                          productTitle: data?.deals[index]?.productName,
                          productsno: data?.deals[index]?.productid,
                          mainproductsno: data?.deals[index]?.productid,
                          aliasName: data?.deals[index]?.aliasName));
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
                            Container(
                              height: 160,
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
                                      data?.deals[index]?.folderName +
                                      data?.deals[index]?.fileName ??
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
                                  data?.deals[index]?.productName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal),
                                ).tr()),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                              data?.deals[index].mrps
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
                                        data?.deals[index].saleRate
                                            .toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  bottom: 10, top: 0, left: 7, right: 10),
                              child: Text(
                                "Gross wt." +
                                    data?.deals[index]?.grossweight
                                        .toString() +
                                    " | Net wt." +
                                    data?.deals[index]?.netweight
                                        .toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ),
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.fit(2),
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
          ),
          /* Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data?.deals.length > 6 ? 6 : data?.deals.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery
                          .of(context)
                          .size
                          .width /
                          (MediaQuery
                              .of(context)
                              .size
                              .height / 1)
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(child: InkWell(
                        onTap: () async {
                          Get.to(ProductListDetailsPage(
                              productName: data?.deals[index]?.productName,
                              catId: int.parse(data?.deals[index].category),
                              imagePath: Constants.imageUrl +
                                  data?.deals[index]?.folderName +
                                  data?.deals[index]?.fileName ??
                                  "",
                              productTitle: data?.deals[index]?.productName,
                              productsno: data?.deals[index]?.productid,
                              mainproductsno: data?.deals[index]?.productid,
                              aliasName: data?.deals[index]?.aliasName));
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
                                Container(
                                  height: 160,
                                  //CommonUtills.displayHeight(context) / 6,
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
                                          data?.deals[index]?.folderName +
                                          data?.deals[index]?.fileName ??
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
                                      data?.deals[index]?.productName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal),
                                    ).tr()),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                  data?.deals[index].mrps
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
                                            data?.deals[index].saleRate
                                                .toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(
                                      bottom: 3, top: 5, left: 5, right: 10),
                                  child: Text(
                                    "Gross wt." +
                                        data?.deals[index]?.grossweight
                                            .toString() +
                                        " | Net wt." +
                                        data?.deals[index]?.netweight
                                            .toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),)
                    ;
                  })
            */
        ],
      ),
    );
  }

  Widget _FlashSale(Homemodel data) {
    return Container(
      color: MyColors.lightblue1,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Flash Sale',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.left,
                ).tr(),
              ),
              InkWell(
                  onTap: () {
                    Get.to(FlashSalePage());
                  },
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ).tr(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 25,
                      )
                    ],
                  ))
            ],
          ),
          _saleTimer(data),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(0),
            child:StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data?.flashSaleList.length > 6? 6: data?.flashSaleList.length,
              itemBuilder: (BuildContext context, int index) => Container(
                  child:
                   InkWell(
                      onTap: () async {
                        Get.to(ProductListDetailsPage(
                            productName:
                            data?.flashSaleList[index]?.productName,
                            catId: int.parse(
                                data?.flashSaleList[index].category),
                            imagePath: Constants.imageUrl +
                                data?.flashSaleList[index]?.folderName +
                                data?.flashSaleList[index]
                                    ?.image1Filename ??
                                "",
                            productTitle:
                            data?.flashSaleList[index]?.productName,
                            productsno: data?.flashSaleList[index]?.sno,
                            mainproductsno: data?.flashSaleList[index]?.sno,
                            aliasName:
                            data?.flashSaleList[index]?.aliasName));
                      },
                      child:  Container(
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
                              Container(
                                height: 160,
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
                                        data?.flashSaleList[index]?.folderName +
                                        data?.flashSaleList[index]?.image1Filename ??
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
                                    data?.flashSaleList[index]?.productName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal),
                                  ).tr()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                data?.flashSaleList[index].mrp
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
                                          data?.flashSaleList[index].saleRate
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                    bottom: 10, top: 0, left: 7, right: 10),
                                child: Text(
                                  "Gross wt." +
                                      data?.flashSaleList[index]?.grossweight
                                          .toString() +
                                      " | Net wt." +
                                      data?.flashSaleList[index]?.netWeight
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
              ),
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.fit(2),
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
          ),

         /* Container(
              color: MyColors.lightblue1,
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data?.flashSaleList.length > 6? 6: data?.flashSaleList.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () async {
                          Get.to(ProductListDetailsPage(
                              productName:
                                  data?.flashSaleList[index]?.productName,
                              catId: int.parse(
                                  data?.flashSaleList[index].category),
                              imagePath: Constants.imageUrl +
                                      data?.flashSaleList[index]?.folderName +
                                      data?.flashSaleList[index]
                                          ?.image1Filename ??
                                  "",
                              productTitle:
                                  data?.flashSaleList[index]?.productName,
                              productsno: data?.flashSaleList[index]?.sno,
                              mainproductsno: data?.flashSaleList[index]?.sno,
                              aliasName:
                                  data?.flashSaleList[index]?.aliasName));
                        },
                        child: Container(
                          width: Get.width,
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 0, right: 0),
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
                                Container(
                                  height: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    child: FadeInImage(
                                      image: NetworkImage(Constants.imageUrl +
                                              data?.flashSaleList[index]
                                                  ?.folderName +
                                              data?.flashSaleList[index]
                                                  ?.image1Filename ??
                                          ""),
                                      placeholder: AssetImage(
                                          'assets/images/placeholder.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 3, top: 5.0, left: 5, right: 3),
                                  child: Text(
                                    "Rs " +
                                        data?.flashSaleList[index]?.saleRate
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
                                          data?.flashSaleList[index]
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
                  })),*/
        ],
      ),
    );
  }

  Widget _saleTimer(Homemodel data) {
    return Container(
        margin: EdgeInsets.only(top: 5, left: 0, right: 5),
        child: CountdownTimer(
          endTime: DateTime.parse(data?.saleEndDatetime)
              .millisecondsSinceEpoch,
          widgetBuilder: (_, CurrentRemainingTime time) {
            if (time == null) {
              return Text('');
            }
            return Text(
              'Days: ${time.days!=null?time.days:'0'} , Hours: ${time.hours!=null?time.hours:'0'} , Min: ${time.min!=null?time.min:'0'} , Sec: ${time.sec!=null?time.sec:'0'} ',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            );
          },
        ));

  }


  Widget _category(Homemodel data) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Explore by Category',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(0),
            child:StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data?.categories.length,
              itemBuilder: (BuildContext context, int index) => Container(
                  child: new InkWell(
                    child: Container(
                      width: CommonUtills.displayWidth(context),
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 160,
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
                                      data?.categories[index]
                                          ?.folderName +
                                      data?.categories[index]
                                          ?.imageFileName ??
                                      ""),
                                  placeholder: AssetImage(
                                      'assets/images/placeholder.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  bottom: 10, top: 10.0, left: 3, right: 3),
                              child: Text(
                                data?.categories[index]?.menuName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      String bannerImage = Constants.imageUrl +
                          data?.categories[index]?.folderName +
                          data?.categories[index]?.bannerFileName;
                      Get.to(SubCategoryTabPage(
                          catName: data?.categories[index]?.menuName,
                          catId: data?.categories[index]?.sno,
                          catImagePath: bannerImage));
                    },
                  )
              ),
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.fit(2),
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
          ),

       /*   Container(
              color: MyColors.lightblue1,
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data?.categories.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.9),
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      child: Container(
                        width: CommonUtills.displayWidth(context),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 160,
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
                                            data?.categories[index]
                                                ?.folderName +
                                            data?.categories[index]
                                                ?.imageFileName ??
                                        ""),
                                    placeholder: AssetImage(
                                        'assets/images/placeholder.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10, top: 10.0, left: 3, right: 3),
                                child: Text(
                                  data?.categories[index]?.menuName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        String bannerImage = Constants.imageUrl +
                            data?.categories[index]?.folderName +
                            data?.categories[index]?.bannerFileName;
                        Get.to(SubCategoryTabPage(
                            catName: data?.categories[index]?.menuName,
                            catId: data?.categories[index]?.sno,
                            catImagePath: bannerImage));
                      },
                    );
                  })
              )*/
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
      ],
    ));
  }

  Widget _buildLoadingWidget() {
    return StreamBuilder<bool>(
      stream: bloc.isLoading,
      builder: (context, snap) {
        return Container(
          child:
              (snap.hasData && snap.data) ? CircularProgressIndicator() : null,
        );
      },
    );
  }

  Widget createDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      accountName: Text(
        controller?.AccountdetailData?.userDetail?.name ?? "",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.left,
      ),
      accountEmail: Text(
        controller?.AccountdetailData?.userDetail?.registeredNo ?? "",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        textAlign: TextAlign.left,
      ),
      currentAccountPicture: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
            'assets/images/logo.png',
          )),
    );
  }

/*  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/placeholder.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Welcome to DigiSakshar",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }*/

  Widget createDrawerBodyItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  showSpamAlertDialog(BuildContext context) {
    // set up the buttons
    Widget logoutButton = RaisedButton(
      child: Text(
        "Logout",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ).tr(),
      shape: CommonWidgets.buttonshape(),
      onPressed: () {
        SharedPref pref = SharedPref();
        pref.remove("name");
        pref.remove("password");
        pref.remove("phone");
        pref.remove("email");
        pref.remove("lname");
        pref.remove("userId");
        pref.remove("currentLocation");
        pref.remove("postalCode");
        pref.remove("profileImg");
        CommonUtills.flutterToast("You have been logout successfully");
        Navigator.of(context).pop();
        Get.offAll(LoginPage());
      },
    );
    Widget CancelButton = RaisedButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ).tr(),
      shape: CommonWidgets.buttonshape(),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to logout!").tr(),
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

  void _getUSerData() async {
    /*var response = await bloc.getUserStatus();
    if(response.value.status==true){

      setState(() {
        username=(GetStorage().read(Constants.USERNAME)??"");
        useremail=(GetStorage().read(Constants.USEREMAIL)??"");
        userimage=(GetStorage().read(Constants.USERIAMGE)??"");
        phone=(GetStorage().read(Constants.PHONE)??"");
        difficultyLevel=(GetStorage().read(Constants.DIFFICULTYLEVEL)??"");
        ageSegment=(GetStorage().read(Constants.AGESEGMENT)??"");

      });

    }
    if(response.totalChapters==response.completedChapters){
//      showDialog3();
    }*/
  }

  Widget _topImageWidget(Carousel data) {
    return Container(
        child: InkWell(
            onTap: () {
              // check user login condition , if user not logged in then redirect to login page else continuew
            },
            child: Container(
              width: Get.width - 50,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  child: FadeInImage(
                    height: 200,
                    width: Get.width,
                    image: NetworkImage(Constants.imageUrl +
                            data?.folderName +
                            data?.fileName ??
                        ""),
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )));
  }

  Future<void> _onRefresh() async {
    await new Future.delayed(const Duration(seconds: 2));
    _getUSerData();
    return null;
  }

  //----show this dialog after complete your level
  void showCourseCompleteDialogdd(context, Homemodel homemodel) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 450,
        width: CommonUtills.displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 250,
              width: 250,
              margin: EdgeInsets.only(top: 15, bottom: 0, left: 0, right: 0),
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/congurats.png'),
            ),
            Container(
                margin: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                alignment: Alignment.center,
                child: Text(
                  'completeCourse',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal),
                  textAlign: TextAlign.center,
                ).tr()),
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                alignment: Alignment.center,
                child: Text('nextLevel',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center)
                    .tr()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: 0, left: 15, right: 5, top: 20),
                    child: RaisedButton(
                      child: Text(
                        "upgrademe",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                      ).tr(),
                      shape: CommonWidgets.buttonshape(),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: 0, left: 5, right: 15, top: 20),
                    child: RaisedButton(
                      child: Text(
                        "cancel",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ).tr(),
                      shape: CommonWidgets.buttonshape(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  _buildLoadingWidgetForComment() {
    return StreamBuilder<bool>(
      stream: bloc.isLoading,
      builder: (context, snap) {
        return Container(
          child:
              (snap.hasData && snap.data) ? CircularProgressIndicator() : null,
        );
      },
    );
  }

  Widget setupAlertDialoadContainer(Homemodel data) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data?.locationList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                setState(() {
                  SharedPref pref = SharedPref();
                  pref.save(
                      "currentLocation", data?.locationList[index]?.pincode);
                  cuttentLocation = data?.locationList[index]?.pincode;
                });
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Text(
                    data?.locationList[index]?.pincode ?? "",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Divider()
                ],
              ));
        },
      ),
    );
  }

  gettingCurrentLocationSave() async {
    SharedPref pref = SharedPref();
    var location = await pref.read("currentLocation");
    if (location != null && location != '') {
      cuttentLocation = location;
    } else {
      cuttentLocation = '';
    }
  }

  LocationData _currentPosition;
  Location location = Location();

  getlocation() async {
    Navigator.of(context).pop();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    String error;
    try {
      _currentPosition = await location.getLocation();
      print('latitude=  ' +
          _currentPosition.latitude.toString() +
          "   longitude=" +
          _currentPosition.longitude.toString());
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      _currentPosition = null;
    }

    getUserLocation();
  }

  getUserLocation() async {
    //call this async method from whereever you need
    final coordinates =
        new Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.postalCode}, ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    setState(() {
      SharedPref pref = SharedPref();
      pref.save("currentLocation", first.addressLine);
      pref.save("postalCode", first.postalCode);
      cuttentLocation = first.addressLine;
    });

    return first;
  }

/*
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      child: new CupertinoAlertDialog(
                        title: new Column(
                          children: <Widget>[
                            new Text("GridView"),
                            new Icon(
                              Icons.favorite,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        content: new Text("Selected Item $index"),
                        actions: <Widget>[
                          new FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: new Text("OK"))
                        ],
                      ),
                    );*/

//----show this dialog after complete your level
  void showCourseCompleteDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        width: CommonUtills.displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 0, left: 0, right: 0),
              alignment: Alignment.topCenter,
              child: FittedBox(
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
                  'ORDERID : ',
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
                  Navigator.pop(context);
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
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    // double currentVersion = double.parse(info.version.trim());
    double currentVersion = double.parse(info.buildNumber.trim());

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(
          remoteConfig.getString('force_update_current_version').trim());
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(Constants.APP_STORE_URL),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(Constants.PLAY_STORE_URL),
                  ),
                  /* FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            )*/
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
