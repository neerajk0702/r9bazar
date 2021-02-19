// import 'package:digisakshar_mobile/Global/Themes/darkTheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/Global/Themes/darkTheme.dart';
import 'package:rbazaar/Global/Themes/lightTheme.dart';

class TestHomePage extends StatefulWidget {
  @override
  _TestHomePageState createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  bool isThemeLight = true;

  @override
  Widget build(BuildContext cont) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello").tr(),
        actions: [
          IconButton(
              icon: Icon(isThemeLight ? Icons.blur_circular : Icons.wb_sunny),
              onPressed: () {
                setState(() {
                  isThemeLight = !isThemeLight;
                  Get.changeTheme(
                    isThemeLight
                        ? DarkTheme.darkTheme()
                        : LightTheme.lightTheme(),
                  );

                  //Write to perst storage
                  GetStorage().write(Constants.THEMEPREF, isThemeLight);
                });
              })
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("title").tr(),
              Text("subtitle").tr(),
              Text("description").tr(),
              Divider(),
              ListTile(
                title: Text("English"),
                selected:
                    EasyLocalization.of(context).locale == Locale('en', 'US'),
                onTap: () => cont.locale = Locale('en', 'US'),
              ),
              ListTile(
                title: Text("Hindi"),
                selected:
                    EasyLocalization.of(context).locale == Locale('hi', 'IN'),
                onTap: () => context.locale = Locale('hi', 'IN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
