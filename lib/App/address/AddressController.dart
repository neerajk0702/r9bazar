import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rbazaar/App/address/StateModel.dart';
import 'package:rbazaar/utils/commonutills.dart';
import 'package:rbazaar/utils/showtoast.dart';

import 'AddressModel.dart';
import 'AddressServicecaller.dart';
import 'CityModel.dart';
import 'SaveAddressModel.dart';

class AddressController extends GetxController {
  final AddressServicecaller serviceCaller = AddressServicecaller();
  final _stateData = StateModel().obs;

  StateModel get collectionData => this._stateData.value;

  changeStateData(StateModel value) => this._stateData.value = value;

  final _stateDropdownMenu = List<DropdownMenuItem<States>>().obs;

  List<DropdownMenuItem<States>> get StateDropdownMenuData =>
      this._stateDropdownMenu.value;

  changeDropdownMenuData(List<DropdownMenuItem<States>> value) =>
      this._stateDropdownMenu.assignAll(value);

  final _cityDropdownMenu = List<DropdownMenuItem<Citys>>().obs;

  List<DropdownMenuItem<Citys>> get CityDropdownMenuData =>
      this._cityDropdownMenu.value;

  changeDropdownMenuCityData(List<DropdownMenuItem<Citys>> value) =>
      this._cityDropdownMenu.assignAll(value);

  final _flatNO = "".obs;

  String get flatNoValue => this._flatNO.value;

  changeFlatNo(String value) => this._flatNO.value = value;

  final _tower = "".obs;

  String get towerValue => this._tower.value;

  changeTower(String value) => this._tower.value = value;

  final _street = "".obs;

  String get streetValue => this._street.value;

  changestreet(String value) => this._street.value = value;

  final _sector = "".obs;

  String get sectorValue => this._sector.value;

  changeSector(String value) => this._sector.value = value;

  final _landmark = "".obs;

  String get landmarkValue => this._landmark.value;

  changeLandmark(String value) => this._landmark.value = value;

  final _pincode = "".obs;

  String get pinkcodeValue => this._pincode.value;

  changePincode(String value) => this._pincode.value = value;


  final _fullname = "".obs;

  String get fullnameValue => this._fullname.value;

  changeFullname(String value) => this._fullname.value = value;

  final _phone = "".obs;

  String get phoneValue => this._phone.value;

  changePhone(String value) => this._phone.value = value;


  final _isProcessing = false.obs;

  get isProcessing => this._isProcessing.value;

  changeProcessing(value) => this._isProcessing.value = value;

  final _error = "".obs;

  get errorValue => this._error.value;

  changeError(value) => this._error.value = value;


  final _selectedStateData = States().obs;

  States get selectedStateData => this._selectedStateData.value;

  changeselectedStateData(States value) => this._selectedStateData.value = value;

  final _selectedCityData = Citys().obs;

  Citys get selectedCityData => this._selectedCityData.value;

  changeselectedCityData(Citys value) => this._selectedCityData.value = value;

  final _isSaveAddress = false.obs;

  get isSaveAddress => this._isSaveAddress.value;

  changeIsSaveAddress(value) => this._isSaveAddress.value = value;


  final _AddressList = AddressModel().obs;

  AddressModel get AddressListData => this._AddressList.value;

  changeAddressList(AddressModel value) => this._AddressList.value = value;

  getAllState() async {
    if (await CommonUtills.ConnectionStatus() == true) {
      try {
        changeProcessing(false);
        var data = await serviceCaller.getAllstatelistSC();
        if (data != null) {
          // changeStateData(data);
          List<DropdownMenuItem<States>> _dropdownMenuItems =
              buildDropdownMenuItemsForState(data.states);
          changeDropdownMenuData(_dropdownMenuItems);
          changeProcessing(true);
          print('_dropdownMenuItems');
        }
      } catch (e) {
        changeProcessing(true);
        CommonUtills.flutterToast(e.toString());
      }
    } else {
      showOfflineToast1();
    }
  }

  List<DropdownMenuItem<States>> buildDropdownMenuItemsForState(
      List<States> states) {
    List<DropdownMenuItem<States>> items = List();
    for (States state in states) {
      print('state name' + state.stateName);
      items.add(
        DropdownMenuItem(
          value: state,
          child: Text(state?.stateName),
        ),
      );
    }
    return items;
  }

  getAllCity(int sno) async {
    if (await CommonUtills.ConnectionStatus() == true) {
      try {
        changeProcessing(false);
        var data = await serviceCaller.getAllCitylistSC(sno);
        if (data != null) {
          List<DropdownMenuItem<Citys>> _dropdownMenuItems =
              buildDropdownMenuItemsForCity(data.citys);
          changeDropdownMenuCityData(_dropdownMenuItems);
          changeProcessing(true);
        }
      } catch (e) {
        changeProcessing(true);
        CommonUtills.flutterToast(e.toString());
      }
    } else {
      showOfflineToast1();
    }
  }

  List<DropdownMenuItem<Citys>> buildDropdownMenuItemsForCity(
      List<Citys> citys) {
    List<DropdownMenuItem<Citys>> items = List();
    for (Citys state in citys) {
      print('state name' + state.cityName);
      items.add(
        DropdownMenuItem(
          value: state,
          child: Text(state?.cityName),
        ),
      );
    }
    return items;
  }

  Future<bool> saveAddress(String userId) async {
    if (await CommonUtills.ConnectionStatus() == true) {
      try {

        if (fullnameValue == null || fullnameValue == '') {
          changeError("Enter Full Name");
          return false;
        } if (phoneValue == null || phoneValue == '') {
          changeError("Enter Phone");
          return false;
        }
        if (flatNoValue == null || flatNoValue == '') {
          changeError("Enter House/Flat No");
          return false;
        }
        if (towerValue == null || towerValue == '') {
          changeError("Enter Building Name/Tower");
          return false;
        }
        if (streetValue == null || streetValue == '') {
          changeError("Enter Street");
          return false;
        }
       /* if (sectorValue == null || sectorValue == '') {
          changeError("Enter Locality/Sector");
          return false;
        }*/
        /*if (landmarkValue == null || landmarkValue == '') {
          changeError("Enter Landmark");
          return false;
        }*/
        if (pinkcodeValue == null || pinkcodeValue == '') {
          changeError("Enter Pincode");
          return false;
        }
        if (selectedStateData == null || selectedStateData.sno==0 ) {
          changeError("Select State");
          return false;
        }
        if (selectedCityData == null || selectedCityData.sno==0) {
          changeError("Select city");
          return false;
        }
        String address=flatNoValue+" "+towerValue+" "+streetValue+" "+sectorValue;
        String location="";
        String userName=userId;
        changeProcessing(false);
        SaveAddressModel data = await serviceCaller.saveAddressSC(userName,address,landmarkValue,pinkcodeValue,fullnameValue,phoneValue,location,selectedStateData,selectedCityData);
        if (data != null && data?.status!=null && data?.status=='Saved Successfully') {
          changeProcessing(true);
          CommonUtills.flutterToast(data?.status);
          changeIsSaveAddress(true);

          return true;
        }else{
          changeProcessing(true);
          CommonUtills.flutterToast("data?.status");
          changeIsSaveAddress(false);
          return false;
        }
      } catch (e) {
        changeIsSaveAddress(false);
        changeProcessing(true);
        CommonUtills.flutterToast(e.toString());
        return false;
      }
    } else {
      showOfflineToast1();
    }
  }

  getAddressListData(phone)async{
    try {
      if(await CommonUtills.ConnectionStatus()== true) {
        changeProcessing(false);
        AddressModel subcategoriesModel = await serviceCaller.getAddressList(phone);
        changeProcessing(true);
        changeAddressList(subcategoriesModel);
      }else{
        AddressModel response = AddressModel();
        response.status=false;
        response.message="Network not available";
        changeAddressList(response);
      }

    }catch(error){
      print("Address list Bloc error"+error.toString());
      changeProcessing(true);
    }
  }
}
