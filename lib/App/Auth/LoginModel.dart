class LoginModel {
  String status;
  UserDetail userDetail;

  LoginModel({this.status, this.userDetail});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userDetail = json['UserDetail'] != null
        ? new UserDetail.fromJson(json['UserDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userDetail != null) {
      data['UserDetail'] = this.userDetail.toJson();
    }
    return data;
  }
}

class UserDetail {
  Null address;
  String name;
  Null location;
  Null state;
  Null country;
  String filename;
  Null stateName;
  String position;
  String role;
  String password;
  Null userName;
  Null fullName;
  String title;
  String documentName;
  String mobileno2;
  String whatsappno;
  Null landMark;
  String dob;
  Null sponsorName;
  Null pinCode;
  Null city;
  Null cityName;
  String registeredNo;
  String referalId;
  String emailId;
  String lname;
  String folderName;
  String userId;
  String gender;
  String registeredPincode;
  String registeredState;
  String otheraddressCountry;
  Null googleCityName;
  Null registrationDate;
  String businesspartnertype;
  String registeredAddress;
  String otheraddressArea;
  String otheraddressAddress;
  String otheraddressLandmark;
  String otheraddressPincode;
  String otheraddressState;
  String documentNumber;
  Null registeredCity;
  String registeredCountry;
  Null googleStateName;
  String registeredLandmark;
  String otheraddressCity;
  String registeredArea;
  Null issuingAuthority;
  String filePath;
  int sno;
  String sponsorId;

  UserDetail(
      {this.address,
        this.name,
        this.location,
        this.state,
        this.country,
        this.filename,
        this.stateName,
        this.position,
        this.role,
        this.password,
        this.userName,
        this.fullName,
        this.title,
        this.documentName,
        this.mobileno2,
        this.whatsappno,
        this.landMark,
        this.dob,
        this.sponsorName,
        this.pinCode,
        this.city,
        this.cityName,
        this.registeredNo,
        this.referalId,
        this.emailId,
        this.lname,
        this.folderName,
        this.userId,
        this.gender,
        this.registeredPincode,
        this.registeredState,
        this.otheraddressCountry,
        this.googleCityName,
        this.registrationDate,
        this.businesspartnertype,
        this.registeredAddress,
        this.otheraddressArea,
        this.otheraddressAddress,
        this.otheraddressLandmark,
        this.otheraddressPincode,
        this.otheraddressState,
        this.documentNumber,
        this.registeredCity,
        this.registeredCountry,
        this.googleStateName,
        this.registeredLandmark,
        this.otheraddressCity,
        this.registeredArea,
        this.issuingAuthority,
        this.filePath,
        this.sno,
        this.sponsorId});

  UserDetail.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
    location = json['location'];
    state = json['state'];
    country = json['country'];
    filename = json['filename'];
    stateName = json['stateName'];
    position = json['position'];
    role = json['role'];
    password = json['password'];
    userName = json['userName'];
    fullName = json['fullName'];
    title = json['title'];
    documentName = json['documentName'];
    mobileno2 = json['mobileno2'];
    whatsappno = json['whatsappno'];
    landMark = json['landMark'];
    dob = json['dob'];
    sponsorName = json['sponsorName'];
    pinCode = json['pinCode'];
    city = json['city'];
    cityName = json['cityName'];
    registeredNo = json['registeredNo'];
    referalId = json['referalId'];
    emailId = json['emailId'];
    lname = json['lname'];
    folderName = json['folderName'];
    userId = json['userId'];
    gender = json['gender'];
    registeredPincode = json['registered_pincode'];
    registeredState = json['registered_state'];
    otheraddressCountry = json['otheraddress_country'];
    googleCityName = json['googleCityName'];
    registrationDate = json['registrationDate'];
    businesspartnertype = json['businesspartnertype'];
    registeredAddress = json['registered_address'];
    otheraddressArea = json['otheraddress_area'];
    otheraddressAddress = json['otheraddress_address'];
    otheraddressLandmark = json['otheraddress_landmark'];
    otheraddressPincode = json['otheraddress_pincode'];
    otheraddressState = json['otheraddress_state'];
    documentNumber = json['documentNumber'];
    registeredCity = json['registered_city'];
    registeredCountry = json['registered_country'];
    googleStateName = json['googleStateName'];
    registeredLandmark = json['registered_landmark'];
    otheraddressCity = json['otheraddress_city'];
    registeredArea = json['registered_area'];
    issuingAuthority = json['issuingAuthority'];
    filePath = json['filePath'];
    sno = json['sno'];
    sponsorId = json['sponsorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    data['location'] = this.location;
    data['state'] = this.state;
    data['country'] = this.country;
    data['filename'] = this.filename;
    data['stateName'] = this.stateName;
    data['position'] = this.position;
    data['role'] = this.role;
    data['password'] = this.password;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['title'] = this.title;
    data['documentName'] = this.documentName;
    data['mobileno2'] = this.mobileno2;
    data['whatsappno'] = this.whatsappno;
    data['landMark'] = this.landMark;
    data['dob'] = this.dob;
    data['sponsorName'] = this.sponsorName;
    data['pinCode'] = this.pinCode;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['registeredNo'] = this.registeredNo;
    data['referalId'] = this.referalId;
    data['emailId'] = this.emailId;
    data['lname'] = this.lname;
    data['folderName'] = this.folderName;
    data['userId'] = this.userId;
    data['gender'] = this.gender;
    data['registered_pincode'] = this.registeredPincode;
    data['registered_state'] = this.registeredState;
    data['otheraddress_country'] = this.otheraddressCountry;
    data['googleCityName'] = this.googleCityName;
    data['registrationDate'] = this.registrationDate;
    data['businesspartnertype'] = this.businesspartnertype;
    data['registered_address'] = this.registeredAddress;
    data['otheraddress_area'] = this.otheraddressArea;
    data['otheraddress_address'] = this.otheraddressAddress;
    data['otheraddress_landmark'] = this.otheraddressLandmark;
    data['otheraddress_pincode'] = this.otheraddressPincode;
    data['otheraddress_state'] = this.otheraddressState;
    data['documentNumber'] = this.documentNumber;
    data['registered_city'] = this.registeredCity;
    data['registered_country'] = this.registeredCountry;
    data['googleStateName'] = this.googleStateName;
    data['registered_landmark'] = this.registeredLandmark;
    data['otheraddress_city'] = this.otheraddressCity;
    data['registered_area'] = this.registeredArea;
    data['issuingAuthority'] = this.issuingAuthority;
    data['filePath'] = this.filePath;
    data['sno'] = this.sno;
    data['sponsorId'] = this.sponsorId;
    return data;
  }
}