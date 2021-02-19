import 'package:get/get.dart';
import 'package:rbazaar/App/SplashScreen/SplashScreen.dart';
import 'package:rbazaar/App/Test/testHome.dart';
import 'package:rbazaar/App/appEntry/appEntry.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import '../main.dart';
import 'app_routes.dart';

abstract class AppPages {
  AppPages._();
  static final pages = [
    GetPage(name: Routes.HOME, page: () => TestHomePage()),
    GetPage(name: Routes.SPLASHSCREEN, page: () => SplashScreen()),
//    GetPage(name: Routes.SPLASHSCREEN, page: () => mainScreen()),
    GetPage(
      name: Constants.appEntry,
      page: () => AppEntry(
        observer: MyApp.observer,
        analytics: MyApp.analytics,
      ),
    )
  ];
}
