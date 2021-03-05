
import 'package:rbazaar/App/model/FlashSaleReportModel.dart';
import 'package:rbazaar/App/model/HotdealModel.dart';

import '../model/CategoriesModel.dart';
import 'AccountdetailModel.dart';
import 'CourseModel.dart';
import 'CoursesForYouModel.dart';
import 'InprogressModel.dart';
import 'LocationModel.dart';
import 'SliderModel.dart';

class Homemodel {
  Homemodel({
    this.totalChapters,
    this.completedChapters,
    this.percentage,
  });

  int totalChapters;
  int completedChapters;
  var percentage;
  double myprecentage;
  bool status;
  String message;
  String username;
  String useremail;
  String userimage;
//  List<CoursesForYouModel> courseforyoudata;

  List<Categories> categories;
  List<Deals> deals;
  List<FlashSaleList> flashSaleList;
  List<Carousel> sliderList;

  UserDetail userDetail;
  List<OrdersList> ordersList;
  List<Pincodes> locationList;

  String saleEndDatetime;
  int totalItem = 0;
  factory Homemodel.fromJson(Map<String, dynamic> json) => Homemodel(
    totalChapters: json["total_chapters"],
    completedChapters: json["completed_chapters"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "total_chapters": totalChapters,
    "completed_chapters": completedChapters,
    "percentage": percentage,
  };
}
