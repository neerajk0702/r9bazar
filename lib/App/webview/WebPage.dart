import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/Auth/SignupPage.dart';
import 'package:rbazaar/App/Home/HomePage.dart';
import 'package:rbazaar/utils/commonutills.dart';

import 'package:rbazaar/utils/mycolors.dart';
import 'package:rbazaar/utils/showtoast.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebPage extends StatefulWidget {
  @override
  WebPageState createState() => WebPageState();
  String url;
  String title;

  WebPage({this.url,this.title});
}

class WebPageState extends State<WebPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  bool isProcessing=false;
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
              Center(
                child: isProcessing
                    ? SizedBox(
                  height: 10,
                )
                    : Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                    child: CircularProgressIndicator()),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _topBar(),
                    Container(
                        margin: EdgeInsets.only(top: 0, left: 0, right: 0,bottom: 50),
                        height: Get.height,
                        child:
                      /*  WebView(
                          javascriptMode: JavascriptMode.unrestricted,
                          initialUrl: 'http://www.baidu.com',
                          onWebViewCreated: (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                        ),*/
                      WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: widget.url,
                        onWebViewCreated: (WebViewController webViewController) {
                          _controller.complete(webViewController);
                        },
                        onPageStarted: (String url) {
                          print('Page started loading: $url');
                        },
                        onPageFinished: (String url) {
                          print('Page finished loading: $url');
                          setState(() {
                            isProcessing=true;
                          });

                        },
                        gestureNavigationEnabled: true,
                      ),

                    )
                  ],
                ),
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
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
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
