import 'dart:convert';

import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/App/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /// To Get User info stored in persistant storage as a json.
  /// Decode Json and fetch the values.
  /*Future<AddTocartLocal> getProductInfo() async {
    AddTocartLocal info = AddTocartLocal();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String productrinfo = preferences.get("ProductDetail");
   
    return null;//(productrinfo == null) ? info : AddTocartLocal.fromRawJson(productrinfo);
  }*/

  Future<String> accesToken() async {
    // UserEntity user = UserEntity();
    // String auth;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String auth = preferences.get("token");
   
    return auth;
  }

  // setter Methods
  Future<bool> saveProductInfo(AddTocartLocal product) async {
    String  productInfo=null;// product.toRawJson();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("ProductDetail", productInfo);

  }
  // Logout user (Remove all userrelated details)
  userLogout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("user");
  }

/*
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var obj= json.decode(prefs.getString(key));
    return (obj == null) ? null : obj;
  }*/
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.setString(key, json.encode(value));
    prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}
