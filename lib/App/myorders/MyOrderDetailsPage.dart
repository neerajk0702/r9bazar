import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Home/AccountdetailModel.dart';
import 'package:rbazaar/App/productdetails/ProductListDetailsPage.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';

class MyOrderDetailsPage extends StatefulWidget {
  @override
  MyOrderDetailsPageState createState() => MyOrderDetailsPageState();
  OrdersList product;

  MyOrderDetailsPage({this.product});
}

class MyOrderDetailsPageState extends State<MyOrderDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      _topBar(),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: FadeInImage(
                          height: 230,
                          width: Get.width,
                          image: NetworkImage(Constants.imageUrl +
                                  widget.product?.subfoldername +
                                  widget.product?.subfilename ??
                              ""),
                          placeholder:
                              AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 15, left: 10, right: 10),
                        child: Text(
                          widget.product?.productName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                            bottom: 0, top: 5, left: 10, right: 10),
                        child: Text(
                          widget.product?.subproductname,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              bottom: 0, top: 30, left: 10, right: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                      ),
                                      child: FadeInImage(
                                        height: 130,
                                        width: 130,
                                        image: NetworkImage(Constants.imageUrl +
                                            widget.product?.folderName +
                                            widget.product?.fileName),
                                        placeholder: AssetImage(
                                            'assets/images/placeholder.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: const EdgeInsets.only(
                                              bottom: 0,
                                              top: 5,
                                              left: 5,
                                              right: 5),
                                          child: Text(
                                            widget.product?.itemOrderId,
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
                                              bottom: 0,
                                              top: 5,
                                              left: 5,
                                              right: 5),
                                          child: Text(
                                            getOrderStatus(
                                                widget.product?.orderStatus),
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
                                              bottom: 3,
                                              top: 5,
                                              left: 5,
                                              right: 10),
                                          child: Text(
                                            widget.product?.bookingDateTime
                                                .toString(),
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
                                              bottom: 3,
                                              top: 0,
                                              left: 5,
                                              right: 10),
                                          child: Text(
                                            "Gross wt." +
                                                widget.product?.grossweight
                                                    .toString() +
                                                " | Net wt." +
                                                widget.product?.netweight
                                                    .toString(),
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
                                              bottom: 3,
                                              top: 0,
                                              left: 5,
                                              right: 10),
                                          child: Text(
                                            "Rs " +
                                                widget.product?.grossAmount
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        // _getProductsaveDetails(data),
                                      ],
                                    ))
                                  ],
                                ),
                              ])),
                      Container(margin: const EdgeInsets.only(
                          bottom: 0, top: 15, left: 0, right: 0),child: Row(
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
                                      widget.product?.defaultName??"",
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
                                      widget.product?.defaultNumber??"",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  /* Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 0, right: 5),
                                    child: Text(
                                      widget.product?.address??"",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Row(children: [
                                    Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 0, right: 5),
                                    child: Text(
                                      data?.city??"",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 0, right: 5),
                                    child: Text(
                                      data?.state??"",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),],),

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        bottom: 0, top: 3, left: 0, right: 5),
                                    child: Text(
                                      data?.pinCode??"",
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
                                      data?.landMark??"",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),*/
                                ]),
                          ),
                        ],
                      ),)

                    ],
                  )),
                ),
              ],
            )));
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
                Text(
                  "Order Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
