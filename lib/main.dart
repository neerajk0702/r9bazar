import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/Global/global.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'App/appEntry/appEntry.dart';
import 'App/firebase/FirebaseNotification.dart';
import 'Global/GlobalConstants.dart';
import 'Global/Themes/darkTheme.dart';
import 'Global/Themes/lightTheme.dart';
import 'Global/config.dart';
import 'Routes/app_routes.dart';
import 'Routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Force disable Crashlytics collection while doing every day development.
  // Temporarily toggle this to true if you want to test crash reporting in your app.
  // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  // Set AppFlavour
  Config.appFlavor = Flavor.QA;

  await GetStorage.init();
  runZonedGuarded(() {
    runApp(
      EasyLocalization(
        child: MyApp(),
        path: 'assets/translations',
        supportedLocales: [Locale('en', 'US'), Locale('hi', 'IN')],
        fallbackLocale: Locale('en', 'US'),

      ),
    );
  }, (error, stackTrace) {
    //CrashAnalytics added for, any flutter crash
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool isDefaultThemeLight = true;
  int langid;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // isDefaultThemeLight = GetStorage().read<bool>(Constants.THEMEPREF);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    ));
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _notification();
    super.initState();
  }
  _notification() async {

    FirebaseNotification _pNotification = FirebaseNotification(context);
    await _pNotification?.getToken();
    await _pNotification?.getNotifications();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
      initConnectivity();
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
      initConnectivity();
    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
      initConnectivity();
    } else if (state == AppLifecycleState.detached) {
      // app suspended (not used in iOS)
      initConnectivity();
    }
//    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    ));*/
    return GetMaterialApp(
      // key: Get.key,
      navigatorKey: navigatorKey,
      builder: BotToastInit(),

      debugShowCheckedModeBanner: false,
      title: Constants.APPNAME,
      navigatorObservers: [MyApp.observer, BotToastNavigatorObserver()],
      //Translation setup
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: isDefaultThemeLight ? LightTheme.lightTheme() : DarkTheme.darkTheme(),
//      initialRoute: Routes.SPLASHSCREEN,

      home: AppEntry(
        observer: MyApp.observer,
        analytics: MyApp.analytics,
      ),

      getPages: AppPages.pages,
    );
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      showOffline();
    } else {
      closeToast();
    }
  }

}
