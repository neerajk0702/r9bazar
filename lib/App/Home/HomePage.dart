import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/App/Auth/LoginPage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/Test/PDFViewerFromUrl.dart';
import 'package:rbazaar/App/changepassword/ChangePasswordPage.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/App/myorders/MyOrdersPage.dart';
import 'package:rbazaar/App/productdetails/ProductListDetailsPage.dart';
import 'package:rbazaar/App/productdetails/SingleProductDetailsPage.dart';
import 'package:rbazaar/App/profile/ProfilePage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryPage.dart';
import 'package:rbazaar/App/subCategory/SubCategoryTabPage.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/commonwidgets.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'Homemodel.dart';
import 'MyAccountDetailsController.dart';
import 'SliderModel.dart';
import 'homebloc.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  HomeBloc bloc = HomeBloc();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  String username="",useremail="",userimage="", phone="";
  int difficultyLevel,ageSegment;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  final MyAccountDetailsController controller = Get.put(MyAccountDetailsController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval((1 / 9) * 1, 1.0, curve: Curves.fastOutSlowIn)));
    controller.accountDetailsSC();
    bloc.getHomeData();

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
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Obx(() =>createDrawerHeader()),
                  InkWell(onTap: () {
                    Navigator.of(context).pop();
                    Get.offAll(HomePage());

                  },child:
                  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 0,left: 10,right: 10),
                    child: Row(children: [
                      Icon( Icons.home,color:  MyColors.darkpink,size: 20,),SizedBox(width: 5,),
                      Text('Home',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12
                      ),),
                    ],),

                  )),
                  Divider(),
                  InkWell(onTap:() async {
                    SharedPref pref = SharedPref();
                    var userInfo = await pref.read("userId");
                    if(userInfo!=null && userInfo!='') {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProfilePage()));
                    }else{
                      Get.to(LoginPage());
                    }
                  },
                      child:
                      Container(
                        margin: EdgeInsets.only(top: 5,bottom: 0,left: 10,right: 10),
                        child: Row(children: [
                          Icon( Icons.account_circle,color:  MyColors.darkpink,size: 20,),SizedBox(width: 5,),
                          Text('My Account',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12),),
                        ],),

                      )),
                  Divider(),
                  InkWell(onTap: () async {
                    SharedPref pref = SharedPref();
                    var userInfo = await pref.read("userId");
                    if(userInfo!=null && userInfo!='') {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MyOrdersPage()));
                    }else{
                      Get.to(LoginPage());
                    }
                  },child:
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                    child: Row(children: [
                      Icon( Icons.shopping_basket_sharp,color:  MyColors.darkpink,size: 20,),SizedBox(width: 5,),
                      Text('My Orders',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12
                      ),),
                    ],),

                  )),
                  Divider(),
                  InkWell(onTap: () async {
                    SharedPref pref = SharedPref();
                    var userInfo = await pref.read("userId");
                    if(userInfo!=null && userInfo!='') {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ChangePasswordPage()));
                    }else{
                      Get.to(LoginPage());
                    }
                  },child:
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                    child: Row(children: [
                      Icon( Icons.question_answer_rounded,color:  MyColors.darkpink,size: 20,),SizedBox(width: 5,),
                      Text('Change Password',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12
                      ),),
                    ],),

                  )),
                  Divider(),
                  InkWell(onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
                  },child:
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                    child: Row(children: [
                      Icon( Icons.call,color:  MyColors.darkpink,size: 20,),SizedBox(width: 5,),
                      Text('Contact Us',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12
                      ),),
                    ],),

                  )),
                  Divider(),
                  InkWell(onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
                  },child:
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                    child: Row(children: [
                      Icon( Icons.question_answer_rounded,color:  MyColors.darkpink,size: 20,),SizedBox(width: 5,),
                      Text('FAQs & Links',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12
                      ),),
                    ],),

                  )),
                  Divider(),
                  InkWell(
                      onTap: (){
                        showSpamAlertDialog(context);
                      },
                      child:
                      Container(
                        margin: EdgeInsets.only(top: 0,bottom: 15,left: 10,right: 10),
                        child: Row(children: [
                          Icon(Icons.logout,color: MyColors.darkpink,size: 20,),SizedBox(width: 5,),
                          Text('Logout',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12
                          ),).tr(),
                        ],),

                      )),
                  Divider(),

                  ListTile(
                    title: Text('App version 1.0.0'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.only(top: 0, left: 0, right: 0),
              child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh:_onRefresh,child:  SingleChildScrollView(
                child: Stack(children: [
                  Container(child: Container(color: MyColors.light_grey_80,
                      child: Column(
                        children: [
                          _topBar(),
                          //_buildUserWidget(null),
                          StreamBuilder<Homemodel>(
                            stream: bloc.homeServiceSubject.stream,
                            builder: (context, AsyncSnapshot<Homemodel> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.error == null &&snapshot.data.status == false) {
                                  return _buildErrorWidget(snapshot.data.message);
                                } else if (snapshot.error == null && snapshot.data.isNull) {
                                  return _buildErrorWidget("No Data Found");
                                } else if (snapshot.error != null || snapshot.data.isNull) {
                                  return _buildErrorWidget(snapshot.error);
                                }
                                return _buildUserWidget(snapshot.data);
                              } else if (snapshot.hasError) {
                                return _buildErrorWidget(snapshot.error);
                              } else {
                                return _buildLoadingWidget();
                              }
                            },
                          )
                        ],
                      ))),
                  Positioned(child:Center(child: _buildLoadingWidgetForComment())),
                ],),



                ////

              )),
            )));
  }

  Widget _topBar() {
    return Container(color: MyColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child:  Row(children: [
            Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () =>
                        _scaffoldState.currentState.openDrawer())),
            InkWell( onTap: (){
              // Get.to(SearchPage());
            },
              child: Container(child:   RichText(maxLines: 1,text: TextSpan(
                children: [TextSpan(
                    text: "Nirala Aspire ",style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)
                ),
                  WidgetSpan(
                    child: Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.white,
                    ),
                  ),]),),),
           )


          ],)),
          Expanded(child:  Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () =>
                      Get.to(LoginPage()))))
        ],
      ),
    );
  }
  Widget _buildUserWidget(Homemodel data) {
    return  Container(child: Column(crossAxisAlignment:CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      /*_name(data),
      _userScore(data),
      data.trendingcourserdata.length>0? _trendingCourse(data):SizedBox(),
      data.courseforyoudata.length>0? _courseForYou(data):SizedBox(),
      data.inProgressListData.length>0? _courseInProgress(data):SizedBox()*/
      topImge(data),
        _hotDeal(data),
      _FlashSale(data),
        _category(data),
        bottomImge(data),

    ],));
  }
  Widget topImge(Homemodel data) {
    return   SizedBox(
        height: 200,
        child:Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 5, left: 0, right: 5),
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
  Widget bottomImge(Homemodel data) {
    return   SizedBox(
        height: 200,
        child:Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 5, left: 0, right: 5),
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
  Widget _hotDeal(Homemodel data) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Hot Deal',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ).tr(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          //// Trending Course List
          Container(
              height: 210,
              child: ListView.builder(
                  itemCount: data?.deals?.length,//data.courseforyoudata.length
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                         /* var dbHelper = DBHelper();
                          var productDetails = await dbHelper.getProduct(data?.deals[index]?.dsno);
                          if(productDetails!=null){
                            Get.to(SingleProductDetailsPage(product:productDetails));
                          }else{
                            var cartData = AddTocartLocal(
                                dsno: data?.deals[index]?.dsno,
                                productName: data?.deals[index]?.productName,
                                aliasName: data?.deals[index]?.aliasName,
                                saleRate: data?.deals[index]?.saleRate,
                                grossweight: data?.deals[index]?.grossweight,
                                netweight: data?.deals[index]?.netweight,
                                totalNetweight: 0,
                                quantityLocal: 5.6,
                                imagePath: Constants.imageUrl +  data?.deals[index]?.folderName +  data?.deals[index]?.fileName ?? "",
                                category: data?.deals[index]?.productCode);
                            Get.to(SingleProductDetailsPage(product:cartData));
                          }*/
                          Get.to(ProductListDetailsPage(productName:data?.deals[index]?.productName,catId:int.parse(data?.deals[index].category),
                              imagePath:Constants.imageUrl +  data?.deals[index]?.folderName +  data?.deals[index]?.fileName ?? "",
                              productTitle:data?.deals[index]?.productName,productsno:data?.deals[index]?.productid,mainproductsno :data?.deals[index]?.productid));

                          /*Get.to(SingleProductDetailsPage(productName:data?.deals[index]?.productName,
                              imagePath:Constants.imageUrl +  data?.deals[index]?.folderName +  data?.deals[index]?.fileName ?? "",
                              productTitle:data?.deals[index]?.productName,productsno:data?.deals[index]?.dsno,
                              saleRate:data?.deals[index]?.saleRate,netweight:data?.deals[index]?.netweight,
                              grossweight:data?.deals[index]?.grossweight,aliasName:data?.deals[index]?.aliasName,category:data?.deals[index]?.productCode));*/
                        },
                        child: Container(
                          width: Get.width / 2,
                          color: Colors.white,
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
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  child: FadeInImage(
                                    height: 120,
                                    image: NetworkImage(Constants.imageUrl+data?.deals[index]?.folderName+data?.deals[index]?.fileName??""),
                                    placeholder: AssetImage(
                                        'assets/images/placeholder.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 3, top: 5.0, left: 5, right: 3),
                                  child: Text(
                                    "Rs "+data?.deals[index].saleRate.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 5, top: 0, left: 5, right: 3),
                                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                                      Text(
                                        data?.deals[index]?.productName,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal),
                                      ).tr(),SizedBox(width: 2,),
                                      Text(
                                        data?.deals[index]?.aliasName,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ).tr(),
                                    ],)
                                ),
                              ],
                            ),
                          ),
                        ));
                  })),
        ],
      ),
    );
  }

  Widget _FlashSale(Homemodel data) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Flash Sale',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ).tr(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          //// Trending Course List
          Container(
              height: 210,
              child: ListView.builder(
                  itemCount: data?.flashSaleList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                         /* var dbHelper = DBHelper();
                          var productDetails = await dbHelper.getProduct(data?.deals[index]?.dsno);
                          if(productDetails!=null){
                            Get.to(SingleProductDetailsPage(product:productDetails));
                          }else{
                            var cartData = AddTocartLocal(
                                dsno: data?.flashSaleList[index]?.sno,
                                productName: data?.flashSaleList[index]?.productName,
                                aliasName: data?.flashSaleList[index]?.aliasName,
                                saleRate: data?.flashSaleList[index]?.saleRate,
                                grossweight: 1,
                                netweight: 1,
                                totalNetweight: 0,
                                quantityLocal: 5.6,
                                imagePath: Constants.imageUrl +  data?.flashSaleList[index]?.folderName +  data?.flashSaleList[index]?.image1Filename ?? "",
                                category: data?.flashSaleList[index]?.subCategory);
                            Get.to(SingleProductDetailsPage(product:cartData));
                          }*/
                          Get.to(ProductListDetailsPage(productName:data?.flashSaleList[index]?.productName,catId:int.parse(data?.flashSaleList[index].category),
                              imagePath:Constants.imageUrl +  data?.flashSaleList[index]?.folderName +  data?.flashSaleList[index]?.image1Filename ?? "",
                              productTitle:data?.flashSaleList[index]?.productName,productsno:data?.flashSaleList[index]?.sno,mainproductsno :data?.flashSaleList[index]?.sno));
                        },
                        child: Container(
                          width: Get.width / 2,
                          color: Colors.white,
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
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  child: FadeInImage(
                                    height: 120,
                                    image: NetworkImage(Constants.imageUrl+data?.flashSaleList[index]?.folderName+data?.flashSaleList[index]?.image1Filename??""),
                                    placeholder: AssetImage(
                                        'assets/images/placeholder.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 3, top: 5.0, left: 5, right: 3),
                                  child: Text(
                                    "Rs "+data?.flashSaleList[index]?.saleRate.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 5, top: 0, left: 5, right: 3),
                                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                                     /* Text(
                                        "500g",
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal),
                                      ).tr(),SizedBox(width: 2,),*/
                                      Text(
                                        data?.flashSaleList[index]?.productName,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ).tr(),
                                    ],)
                                ),
                              ],
                            ),
                          ),
                        ));
                  })),

        ],
      ),
    );
  }


  Widget _category(Homemodel data) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Shop by Category',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(child:  GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data?.categories.length,
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return new InkWell(
                  child:  Container(
                    width: Get.width / 2,
                    color: Colors.white,
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
                        children: <Widget>[
                        Expanded(flex: 3,child:  ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          child: FadeInImage(
                            height: 150,
                            image: NetworkImage(Constants.imageUrl+data?.categories[index]?.folderName+data?.categories[index]?.imageFileName??""),
                            placeholder: AssetImage(
                                'assets/images/placeholder.png'),
                            fit: BoxFit.fill,
                          ),
                        ),),
                      Expanded(flex:1,child: Container(
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
                      ),)

                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    String bannerImage=Constants.imageUrl+data?.categories[index]?.folderName+data?.categories[index]?.bannerFileName;
                    Get.to(SubCategoryTabPage(catName:data?.categories[index]?.menuName,catId:data?.categories[index]?.sno,catImagePath:bannerImage));
                  },
                );
              }))

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
        color: MyColors.light_grey_80,
      ),
      accountName: Text(
        controller?.AccountdetailData?.userDetail?.name??"",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        textAlign: TextAlign.left,
      ),
      accountEmail: Text(
        controller?.AccountdetailData?.userDetail?.registeredNo??"",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        textAlign: TextAlign.left,
      ),
      currentAccountPicture: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: FadeInImage(
          image: NetworkImage(userimage??""),
          placeholder: AssetImage('assets/images/placeholder.png'),
          fit: BoxFit.cover,
        ),
      ),
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
    Widget logoutButton =RaisedButton(
      child: Text("Logout",style: TextStyle(color: Colors.white,fontSize: 14),).tr(),
      shape: CommonWidgets.buttonshape(),
      onPressed:  ()  {
        SharedPref pref = SharedPref();
        pref.remove("name");
        pref.remove("password");
        pref.remove("phone");
        pref.remove("email");
        pref.remove("lname");
        pref.remove("userId");
        CommonUtills.flutterToast("You have been logout successfully");
        Navigator.of(context).pop();
       Get.offAll(HomePage());
      },
    );
    Widget CancelButton = RaisedButton(
      child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 14),).tr(),
      shape: CommonWidgets.buttonshape(),
      onPressed:  () {
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

  void _getUSerData()async {
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
    return Container(child:  InkWell(
        onTap: () {
          // check user login condition , if user not logged in then redirect to login page else continuew
        },
        child:Container(width: Get.width-50,alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
          child: Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child:   ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              child: FadeInImage(height: 200,width: Get.width,
                image: NetworkImage(Constants.imageUrl+data?.folderName+data?.fileName??""),
                placeholder: AssetImage('assets/images/placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
    ));
  }

  Future<void> _onRefresh() async{
    await new Future.delayed(const Duration(seconds: 2));
    _getUSerData();
    return null;
  }
  //----show this dialog after complete your level
  void showCourseCompleteDialog(context,Homemodel homemodel) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 450,
        width: CommonUtills.displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(height: 250,width: 250,margin: EdgeInsets.only(top: 15, bottom: 0, left: 0, right: 0),alignment:Alignment.topCenter , child:
            Image.asset('assets/images/congurats.png'),),
            Container(margin: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),alignment:Alignment.center,
                child: Text('completeCourse',
                  style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal),textAlign: TextAlign.center,).tr()),
            Container(margin: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),alignment:Alignment.center,
                child: Text('nextLevel',
                    style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal),textAlign: TextAlign.center).tr()),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Expanded(flex: 1,child:  Container( margin: EdgeInsets.only(bottom: 0, left: 15, right: 5,top: 20),child: RaisedButton(
                child: Text("upgrademe",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal),).tr(),
                shape: CommonWidgets.buttonshape(),
                onPressed:  () async {
                  Navigator.pop(context);
                },
              ),),),
              Expanded(flex: 1,child: Container(margin: EdgeInsets.only(bottom: 0, left: 5, right: 15,top: 20),child: RaisedButton(
                child: Text("cancel",style: TextStyle(color: Colors.white,fontSize: 14),).tr(),
                shape: CommonWidgets.buttonshape(),
                onPressed:  () {
                  Navigator.pop(context);
                },
              ),),)

            ],)

          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);
  }
  _buildLoadingWidgetForComment() {
    return  StreamBuilder<bool>(
      stream: bloc.isLoading,
      builder: (context, snap) {
        return Container(
          child: (snap.hasData && snap.data)
              ? CircularProgressIndicator()
              : null,
        );
      },
    );
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
}
