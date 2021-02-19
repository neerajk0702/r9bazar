class AddressModel {
  List<UserAddress> userAddress;
  bool status;
  String message;

  AddressModel({this.userAddress});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json['UserAddress'] != null) {
      userAddress = new List<UserAddress>();
      json['UserAddress'].forEach((v) {
        userAddress.add(new UserAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userAddress != null) {
      data['UserAddress'] = this.userAddress.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddress {
  int sno;
  String stateName;
  String cityName;
  String location;
  String fullName;
  String pinCode;
  String city;
  String state;
  String country;
  String landMark;
  String address;
  String googleStateName;
  String googleCityName;
  String mobileno2;
  bool selectFlag=false;
  UserAddress(
      {this.sno,
        this.stateName,
        this.cityName,
        this.location,
        this.fullName,
        this.pinCode,
        this.city,
        this.state,
        this.country,
        this.landMark,
        this.address,
        this.googleStateName,
        this.googleCityName,
        this.mobileno2});

  UserAddress.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    stateName = json['stateName'];
    cityName = json['cityName'];
    location = json['location'];
    fullName = json['fullName'];
    pinCode = json['pinCode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    landMark = json['landMark'];
    address = json['address'];
    googleStateName = json['googleStateName'];
    googleCityName = json['googleCityName'];
    mobileno2 = json['mobileno2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['stateName'] = this.stateName;
    data['cityName'] = this.cityName;
    data['location'] = this.location;
    data['fullName'] = this.fullName;
    data['pinCode'] = this.pinCode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['landMark'] = this.landMark;
    data['address'] = this.address;
    data['googleStateName'] = this.googleStateName;
    data['googleCityName'] = this.googleCityName;
    data['mobileno2'] = this.mobileno2;
    return data;
  }
}