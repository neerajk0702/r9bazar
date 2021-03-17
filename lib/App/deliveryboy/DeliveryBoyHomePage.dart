
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'DeliveryBoyPage.dart';
import 'SettingPage.dart';

class DeliveryBoyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DeliveryBoyHomePageState();
  }
}

class DeliveryBoyHomePageState extends State<DeliveryBoyHomePage> {
  int tabIndex = 0;
  List<Widget> listScreens;
  bool navBarMode = false;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listScreens = [
      DeliveryBoyPage(),
      SettingPage()
     /* ,
      AssessmentPage(),
      profilePage(),*/
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      listScreens[tabIndex],
      bottomNavigationBar: TitledBottomNavigationBar(

          currentIndex: tabIndex,

          activeColor: MyColors.primaryColor,
          inactiveColor: MyColors.darkgrey_100,
          indicatorColor: MyColors.primaryColor,

          inactiveStripColor: MyColors.bottombarcolor,

          curve: Curves.easeInBack,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
            TitledNavigationBarItem(title: Text('Setting'), icon: Icons.settings),
            // TitledNavigationBarItem(title: Text('Assessment'), icon: Icons.assessment),
            // TitledNavigationBarItem(title: Text('Profile'), icon: Icons.work_outline),
          ]),
      backgroundColor: Theme.of(context).primaryColor,
    );
   /* return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      key: _scaffoldState,
      *//* appBar: AppBar(
          title: Text("Drawer app"),
        ),*//*
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(),
            createDrawerBodyItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomeFile()));
              },
            ),
            createDrawerBodyItem(icon: Icons.pages, text: 'Course',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CoursePage()));
              },),
            createDrawerBodyItem(icon: Icons.account_circle, text: 'Profile'),
            createDrawerBodyItem(icon: Icons.settings, text: 'Setting',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LanguagePage()));
              },
            ),
            Divider(),
            createDrawerBodyItem(
                icon: Icons.notifications_active, text: 'Notification'),
            createDrawerBodyItem(icon: Icons.logout, text: 'Logout',
              onTap: () {
                Navigator.of(context).pop();
                GetStorage().remove(Constants.USERTOKEN);
              },
            ),
            ListTile(
              title: Text('App version 1.0.0'),
              onTap: () {
                CommonUtills.flutterToast("logout");
                Navigator.pop(context);},
            ),
          ],
        ),
      ),
      body:
      Container(
          child:_topBar()
        *//* IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldState.currentState.openDrawer();
          },

        ),*//*
      ),
    );*/
  }
  Widget  _topBar() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child:Container(alignment: Alignment.centerLeft, child:IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () =>  _scaffoldState.currentState.openDrawer()
          ))),
          Row(children: [IconButton(
              icon: Icon(Icons.add_alert, color: Colors.black),
              onPressed: () => Get.back()
          ),
            IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () =>    SystemNavigator.pop()
            ),],)
        ],
      ),

    );
  }
  Widget createDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text("DigiSakshar"),
      accountEmail: Text("DigiSakshar@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.white,
        child: Text(
          "D",
          style: TextStyle(fontSize: 40.0),
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
}
