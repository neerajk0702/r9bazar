
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rbazaar/App/SharedPreferences/SharedPref.dart';
import 'package:rbazaar/App/database/DBHelper.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/App/model/CategoriesModel.dart';
import 'package:rbazaar/App/model/FlashSaleReportModel.dart';
import 'package:rbazaar/App/model/HotdealModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rxdart/rxdart.dart';

import 'AccountdetailModel.dart';
import 'Homemodel.dart';
import 'LocationModel.dart';
import 'SliderModel.dart';
import 'homeservicecaller.dart';



class HomeBloc{
  final servicecaller = HomeServiceCaller();
  // home OBJECTS
  final homeServiceSubject = BehaviorSubject<Homemodel>();
  get statusData => homeServiceSubject.stream;

  final myaccountServiceSubject = BehaviorSubject<AccountdetailModel>();
  get myaccountData => myaccountServiceSubject.stream;

  /// LOADING OBJECTS
  final _isLoadingStateController = BehaviorSubject<bool>();
  get isLoading => _isLoadingStateController.stream;

  getHomeData()async{
    try {
      if(await CommonUtills.ConnectionStatus()== true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
       /* if (isLoading != null && isLoading) {
          return;
        }*/
        var dbHelper = DBHelper();
        // var total=getTotalItemNo();
        List<Map> ListMap = await dbHelper.getAllProducts();
        List<AddTocartLocal> productList = ListMap.isNotEmpty
            ? ListMap.map((c) => AddTocartLocal.fromMap(c)).toList()
            : null;

        CategoriesModel categoriesModel = await servicecaller.getCategoryesList();
        Homemodel response = Homemodel();
        if (productList != null && productList.length>0) {
          response.totalItem = productList.length;
        }
        LocationModel locationModel = await servicecaller.getLocationData();
        response.locationList=locationModel?.pincodes;

        response.categories=categoriesModel?.categories;
        HotdealModel hotdeal = await servicecaller.getHotDeal();
        response.deals=hotdeal?.deals;
        FlashSaleReportModel flashsale = await servicecaller.getflashsale();
        response.flashSaleList=flashsale?.flashSaleList;
        if(flashsale?.flashSaleList!=null && flashsale?.flashSaleList.length>0){
          // response?.endtime=flashsale?.flashSaleList[0].endtime;
          // response?.expirydateCount=flashsale?.flashSaleList[0].expDateforCounter;
          response?.saleEndDatetime=flashsale?.flashSaleList[0].expDateforCounter+" "+flashsale?.flashSaleList[0].endtime;
        }
        SliderModel sliderData = await servicecaller.getsliderDetails();
        response.sliderList=sliderData?.carousel;

        homeServiceSubject.sink.add(response);
        _isLoadingStateController.sink.add(false);
        return homeServiceSubject;
      }else{
        Homemodel response = Homemodel();
        response.status=false;
        response.message="Network not available";
        homeServiceSubject.sink.add(response);
        _isLoadingStateController.sink.add(false);
        return homeServiceSubject;
      }

    }catch(error){
      print("home Bloc error"+error.toString());
    }
  }

  myaccountdetail()async{
    try {
      SharedPref pref = SharedPref();
      var userInfo = await pref.read("userId");
      if(userInfo!=null && userInfo!='') {
        if (await CommonUtills.ConnectionStatus() == true) {
          AccountdetailModel data = await servicecaller.myaccountdetailData(userInfo);
          if(data.userDetail!=null){
            pref.save("name", data.userDetail.name);
            pref.save("password", data.userDetail.password);
            pref.save("phone", data.userDetail.registeredNo);
            pref.save("email", data.userDetail.emailId);
            pref.save("lname", data.userDetail.lname);
            pref.save("userId", data.userDetail.userId);
            print('myaccountdetail done');
            myaccountServiceSubject.sink.add(data);
          }
        }
      }
    }catch(error){
      print("home Bloc myaccountdetail error"+error.toString());
    }
    return myaccountServiceSubject;
  }

  /*  getUserStatus() async {

    try {
      if(await CommonUtills.ConnectionStatus()== true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
        if (isLoading != null && isLoading) {
          return;
        }
        Homemodel mainmodelresponse = await servicecaller.getUserDetail();
        //UserModel responses = await servicecaller.getUserInfo();


          double percentage=(mainmodelresponse.completedChapters/mainmodelresponse.totalChapters);


          UserModel responses = await servicecaller.getUserInfo();
          /// TRENDING COURSE LIST
         try {
           CourseModel tredingcourserresponseresponse = await servicecaller.getCourseList();
           tredingcourserresponseresponse.status = true;
           tredingcourserresponseresponse.Message = "Success";

           // CHECK FOR LANGUAGE CODE
           try {
             for (int i = 0; i <
                 tredingcourserresponseresponse.data.length; i++) {
               for (int j = 0; j <
                   tredingcourserresponseresponse.data[i].languages
                       .length; j++) {
                 for (int k = 0; k < languagelist.length; k++) {
                   if (tredingcourserresponseresponse.data[i].languages[j] ==
                       languagelist[k].id) {
                     tredingcourserresponseresponse.data[i].languagessec
                         .add(
                         tredingcourserresponseresponse.data[i].languages[j]);
                   }
                 }
               }
             }
             mainmodelresponse.trendingcourserdata=tredingcourserresponseresponse.data;
             /// GET TRENDING COURSES DATA
             try{


               List<dynamic> list=await servicecaller.getINProgressCourses();
               // List<InProgressModel> intList = list.map((s) => s as InProgressModel).toList();
               List<InProgressModel> progList = List<InProgressModel>.from(list.map((i) => InProgressModel.fromJson(i)));
               mainmodelresponse.inProgressListData=progList;
             }catch(e)
             {
               print(e);
             }

             // GET COURSES FOR YOU
             try{


               List<dynamic> list=await servicecaller.getCoursesForYouList();
               // List<InProgressModel> intList = list.map((s) => s as InProgressModel).toList();
               List<CoursesForYouModel> courseforyoulist = List<CoursesForYouModel>.from(list.map((i) => CoursesForYouModel.fromJson(i)));
               mainmodelresponse.courseforyoudata=courseforyoulist;
             }catch(e)
             {
               print(e);
             }




             mainmodelresponse.myprecentage=percentage;




             GetStorage().write(Constants.USERNAME, responses.data.name);
             GetStorage().write(Constants.USEREMAIL, responses.data.email);
             GetStorage().write(Constants.USERID, responses.data.id);
             GetStorage().write(Constants.USERIAMGE, responses.data.avatar);
             GetStorage().write(Constants.PHONE, responses.data.phone);
             GetStorage().write(Constants.DIFFICULTYLEVEL, responses.data.difficultyLevel);
             GetStorage().write(Constants.AGESEGMENT, responses.data.ageSegment);

             mainmodelresponse.username=responses.data.name;
             mainmodelresponse.useremail=responses.data.email;
             mainmodelresponse.userimage=responses.data.avatar;
             mainmodelresponse.status=true;





             _isLoadingStateController.sink.add(false);
             userstatusServiceSubject.sink.add(mainmodelresponse);
             return userstatusServiceSubject;
           } catch (e) {
             print(e.toString());
           }
         }catch (DioError) {
           print(DioError);
           CourseModel models = CourseModel();
           DioError.toString() == " Please complete your profile first."
               ? models.Message = DioError.toString()
               : models.Message = "Please complete your profile first.";

           //courseServiceSubject.sink.add(models);
           //  coursefilterServiceSubject.sink.add(models);
           // _isLoadingStateController.sink.add(false);
           // return courseServiceSubject;
           if (DioError.toString() == "Http status error [422]") {
             Get.off(registerUserPage());
           }

           //  Get.back();
         }



        //_callUserInfo(response);
          if(GetStorage().read(Constants.USERTOKEN)==null){
            _callUserInfo();
          }
          else{
            _isLoadingStateController.sink.add(false);
            return userstatusServiceSubject;
          }


      }else{
        Homemodel response = Homemodel();
        response.status=false;
        response.message="Network not available";
        userstatusServiceSubject.sink.add(response);
        userstatusServiceSubject.sink.add(response);
        _isLoadingStateController.sink.add(false);
        return userstatusServiceSubject;
      }
    }catch(error){
      print("topic Bloc error"+error.toString());
    }
  }*/

  dispose() {
    homeServiceSubject.close();
    _isLoadingStateController.close();
  }
}
