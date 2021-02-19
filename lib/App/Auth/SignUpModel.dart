class SignUpModel {
  String status;
  UserDetail userDetail;

  SignUpModel({this.status, this.userDetail});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  Null stateName;
  String role;
  String position;
  Null userName;
  String password;
  Null fullName;
  String documentNumber;
  String otheraddressState;
  String registeredCountry;
  Null registeredCity;
  String otheraddressLandmark;
  Null registrationDate;
  String otheraddressAddress;
  String registeredAddress;
  String otheraddressPincode;
  String registeredPincode;
  String otheraddressArea;
  Null issuingAuthority;
  String registeredLandmark;
  String otheraddressCountry;
  String otheraddressCity;
  Null googleStateName;
  Null googleCityName;
  String registeredState;
  String registeredArea;
  String businesspartnertype;
  Null pinCode;
  Null city;
  Null cityName;
  Null sponsorName;
  String mobileno2;
  String title;
  String documentName;
  String whatsappno;
  Null landMark;
  String dob;
  String filePath;
  int sno;
  String sponsorId;
  String registeredNo;
  String emailId;
  String referalId;
  String lname;
  String userId;
  String folderName;
  String gender;
  String filename;

  UserDetail(
      {this.address,
        this.name,
        this.location,
        this.state,
        this.country,
        this.stateName,
        this.role,
        this.position,
        this.userName,
        this.password,
        this.fullName,
        this.documentNumber,
        this.otheraddressState,
        this.registeredCountry,
        this.registeredCity,
        this.otheraddressLandmark,
        this.registrationDate,
        this.otheraddressAddress,
        this.registeredAddress,
        this.otheraddressPincode,
        this.registeredPincode,
        this.otheraddressArea,
        this.issuingAuthority,
        this.registeredLandmark,
        this.otheraddressCountry,
        this.otheraddressCity,
        this.googleStateName,
        this.googleCityName,
        this.registeredState,
        this.registeredArea,
        this.businesspartnertype,
        this.pinCode,
        this.city,
        this.cityName,
        this.sponsorName,
        this.mobileno2,
        this.title,
        this.documentName,
        this.whatsappno,
        this.landMark,
        this.dob,
        this.filePath,
        this.sno,
        this.sponsorId,
        this.registeredNo,
        this.emailId,
        this.referalId,
        this.lname,
        this.userId,
        this.folderName,
        this.gender,
        this.filename});

  UserDetail.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
    location = json['location'];
    state = json['state'];
    country = json['country'];
    stateName = json['stateName'];
    role = json['role'];
    position = json['position'];
    userName = json['userName'];
    password = json['password'];
    fullName = json['fullName'];
    documentNumber = json['documentNumber'];
    otheraddressState = json['otheraddress_state'];
    registeredCountry = json['registered_country'];
    registeredCity = json['registered_city'];
    otheraddressLandmark = json['otheraddress_landmark'];
    registrationDate = json['registrationDate'];
    otheraddressAddress = json['otheraddress_address'];
    registeredAddress = json['registered_address'];
    otheraddressPincode = json['otheraddress_pincode'];
    registeredPincode = json['registered_pincode'];
    otheraddressArea = json['otheraddress_area'];
    issuingAuthority = json['issuingAuthority'];
    registeredLandmark = json['registered_landmark'];
    otheraddressCountry = json['otheraddress_country'];
    otheraddressCity = json['otheraddress_city'];
    googleStateName = json['googleStateName'];
    googleCityName = json['googleCityName'];
    registeredState = json['registered_state'];
    registeredArea = json['registered_area'];
    businesspartnertype = json['businesspartnertype'];
    pinCode = json['pinCode'];
    city = json['city'];
    cityName = json['cityName'];
    sponsorName = json['sponsorName'];
    mobileno2 = json['mobileno2'];
    title = json['title'];
    documentName = json['documentName'];
    whatsappno = json['whatsappno'];
    landMark = json['landMark'];
    dob = json['dob'];
    filePath = json['filePath'];
    sno = json['sno'];
    sponsorId = json['sponsorId'];
    registeredNo = json['registeredNo'];
    emailId = json['emailId'];
    referalId = json['referalId'];
    lname = json['lname'];
    userId = json['userId'];
    folderName = json['folderName'];
    gender = json['gender'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    data['location'] = this.location;
    data['state'] = this.state;
    data['country'] = this.country;
    data['stateName'] = this.stateName;
    data['role'] = this.role;
    data['position'] = this.position;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['documentNumber'] = this.documentNumber;
    data['otheraddress_state'] = this.otheraddressState;
    data['registered_country'] = this.registeredCountry;
    data['registered_city'] = this.registeredCity;
    data['otheraddress_landmark'] = this.otheraddressLandmark;
    data['registrationDate'] = this.registrationDate;
    data['otheraddress_address'] = this.otheraddressAddress;
    data['registered_address'] = this.registeredAddress;
    data['otheraddress_pincode'] = this.otheraddressPincode;
    data['registered_pincode'] = this.registeredPincode;
    data['otheraddress_area'] = this.otheraddressArea;
    data['issuingAuthority'] = this.issuingAuthority;
    data['registered_landmark'] = this.registeredLandmark;
    data['otheraddress_country'] = this.otheraddressCountry;
    data['otheraddress_city'] = this.otheraddressCity;
    data['googleStateName'] = this.googleStateName;
    data['googleCityName'] = this.googleCityName;
    data['registered_state'] = this.registeredState;
    data['registered_area'] = this.registeredArea;
    data['businesspartnertype'] = this.businesspartnertype;
    data['pinCode'] = this.pinCode;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['sponsorName'] = this.sponsorName;
    data['mobileno2'] = this.mobileno2;
    data['title'] = this.title;
    data['documentName'] = this.documentName;
    data['whatsappno'] = this.whatsappno;
    data['landMark'] = this.landMark;
    data['dob'] = this.dob;
    data['filePath'] = this.filePath;
    data['sno'] = this.sno;
    data['sponsorId'] = this.sponsorId;
    data['registeredNo'] = this.registeredNo;
    data['emailId'] = this.emailId;
    data['referalId'] = this.referalId;
    data['lname'] = this.lname;
    data['userId'] = this.userId;
    data['folderName'] = this.folderName;
    data['gender'] = this.gender;
    data['filename'] = this.filename;
    return data;
  }
}