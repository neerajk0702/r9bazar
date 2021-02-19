import 'package:dio/dio.dart';
import 'package:rbazaar/App/Auth/LoginModel.dart';
import 'package:rbazaar/App/Auth/SignUpModel.dart';
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/interceptor/interceptor.dart';


class ChangePasswordServicecaller {
  changePasswordSC(String username,String oldpassword,String newPass) async {
    Dio dio = await getInterceptors();
    try {
      Response response = await dio
          .post("${Constants.AppBaseUrl}ChangePasswordcall?username=${username}&oldpass=${oldpassword}&newpass=${newPass}");
      print(
          'changePasswor url= ' +"${Constants.AppBaseUrl}ChangePasswordcall?username=${username}&oldpass=${oldpassword}&newpass=${newPass}");
      return LoginModel.fromJson(response.data);
    } on DioError catch (error) {
      String message = error.message;
      print("changePasswordSC service caller error " + message);
      throw (message);
    }
  }

}
