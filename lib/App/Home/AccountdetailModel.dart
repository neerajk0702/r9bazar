class AccountdetailModel {
  String status;
  UserDetail userDetail;
  List<OrdersList> ordersList;
  int orders;

  AccountdetailModel(
      {this.status, this.userDetail, this.ordersList, this.orders});

  AccountdetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userDetail = json['UserDetail'] != null
        ? new UserDetail.fromJson(json['UserDetail'])
        : null;
    if (json['OrdersList'] != null) {
      ordersList = new List<OrdersList>();
      json['OrdersList'].forEach((v) {
        ordersList.add(new OrdersList.fromJson(v));
      });
    }
    orders = json['Orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userDetail != null) {
      data['UserDetail'] = this.userDetail.toJson();
    }
    if (this.ordersList != null) {
      data['OrdersList'] = this.ordersList.map((v) => v.toJson()).toList();
    }
    data['Orders'] = this.orders;
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
  String filename;
  String role;
  String position;
  String password;
  Null userName;
  Null fullName;
  String filePath;
  int sno;
  String sponsorId;
  String referalId;
  String emailId;
  String registeredNo;
  String folderName;
  String lname;
  String gender;
  String userId;
  Null googleStateName;
  Null googleCityName;
  Null registrationDate;
  String registeredCountry;
  String otheraddressState;
  String registeredLandmark;
  String registeredPincode;
  String otheraddressCountry;
  Null registeredCity;
  Null issuingAuthority;
  String registeredAddress;
  String registeredState;
  String otheraddressArea;
  String otheraddressCity;
  String otheraddressPincode;
  String registeredArea;
  String otheraddressLandmark;
  String otheraddressAddress;
  String businesspartnertype;
  String documentNumber;
  Null sponsorName;
  String dob;
  String documentName;
  Null landMark;
  String mobileno2;
  String title;
  String whatsappno;
  Null pinCode;
  Null city;
  Null cityName;

  UserDetail(
      {this.address,
        this.name,
        this.location,
        this.state,
        this.country,
        this.stateName,
        this.filename,
        this.role,
        this.position,
        this.password,
        this.userName,
        this.fullName,
        this.filePath,
        this.sno,
        this.sponsorId,
        this.referalId,
        this.emailId,
        this.registeredNo,
        this.folderName,
        this.lname,
        this.gender,
        this.userId,
        this.googleStateName,
        this.googleCityName,
        this.registrationDate,
        this.registeredCountry,
        this.otheraddressState,
        this.registeredLandmark,
        this.registeredPincode,
        this.otheraddressCountry,
        this.registeredCity,
        this.issuingAuthority,
        this.registeredAddress,
        this.registeredState,
        this.otheraddressArea,
        this.otheraddressCity,
        this.otheraddressPincode,
        this.registeredArea,
        this.otheraddressLandmark,
        this.otheraddressAddress,
        this.businesspartnertype,
        this.documentNumber,
        this.sponsorName,
        this.dob,
        this.documentName,
        this.landMark,
        this.mobileno2,
        this.title,
        this.whatsappno,
        this.pinCode,
        this.city,
        this.cityName});

  UserDetail.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
    location = json['location'];
    state = json['state'];
    country = json['country'];
    stateName = json['stateName'];
    filename = json['filename'];
    role = json['role'];
    position = json['position'];
    password = json['password'];
    userName = json['userName'];
    fullName = json['fullName'];
    filePath = json['filePath'];
    sno = json['sno'];
    sponsorId = json['sponsorId'];
    referalId = json['referalId'];
    emailId = json['emailId'];
    registeredNo = json['registeredNo'];
    folderName = json['folderName'];
    lname = json['lname'];
    gender = json['gender'];
    userId = json['userId'];
    googleStateName = json['googleStateName'];
    googleCityName = json['googleCityName'];
    registrationDate = json['registrationDate'];
    registeredCountry = json['registered_country'];
    otheraddressState = json['otheraddress_state'];
    registeredLandmark = json['registered_landmark'];
    registeredPincode = json['registered_pincode'];
    otheraddressCountry = json['otheraddress_country'];
    registeredCity = json['registered_city'];
    issuingAuthority = json['issuingAuthority'];
    registeredAddress = json['registered_address'];
    registeredState = json['registered_state'];
    otheraddressArea = json['otheraddress_area'];
    otheraddressCity = json['otheraddress_city'];
    otheraddressPincode = json['otheraddress_pincode'];
    registeredArea = json['registered_area'];
    otheraddressLandmark = json['otheraddress_landmark'];
    otheraddressAddress = json['otheraddress_address'];
    businesspartnertype = json['businesspartnertype'];
    documentNumber = json['documentNumber'];
    sponsorName = json['sponsorName'];
    dob = json['dob'];
    documentName = json['documentName'];
    landMark = json['landMark'];
    mobileno2 = json['mobileno2'];
    title = json['title'];
    whatsappno = json['whatsappno'];
    pinCode = json['pinCode'];
    city = json['city'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    data['location'] = this.location;
    data['state'] = this.state;
    data['country'] = this.country;
    data['stateName'] = this.stateName;
    data['filename'] = this.filename;
    data['role'] = this.role;
    data['position'] = this.position;
    data['password'] = this.password;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['filePath'] = this.filePath;
    data['sno'] = this.sno;
    data['sponsorId'] = this.sponsorId;
    data['referalId'] = this.referalId;
    data['emailId'] = this.emailId;
    data['registeredNo'] = this.registeredNo;
    data['folderName'] = this.folderName;
    data['lname'] = this.lname;
    data['gender'] = this.gender;
    data['userId'] = this.userId;
    data['googleStateName'] = this.googleStateName;
    data['googleCityName'] = this.googleCityName;
    data['registrationDate'] = this.registrationDate;
    data['registered_country'] = this.registeredCountry;
    data['otheraddress_state'] = this.otheraddressState;
    data['registered_landmark'] = this.registeredLandmark;
    data['registered_pincode'] = this.registeredPincode;
    data['otheraddress_country'] = this.otheraddressCountry;
    data['registered_city'] = this.registeredCity;
    data['issuingAuthority'] = this.issuingAuthority;
    data['registered_address'] = this.registeredAddress;
    data['registered_state'] = this.registeredState;
    data['otheraddress_area'] = this.otheraddressArea;
    data['otheraddress_city'] = this.otheraddressCity;
    data['otheraddress_pincode'] = this.otheraddressPincode;
    data['registered_area'] = this.registeredArea;
    data['otheraddress_landmark'] = this.otheraddressLandmark;
    data['otheraddress_address'] = this.otheraddressAddress;
    data['businesspartnertype'] = this.businesspartnertype;
    data['documentNumber'] = this.documentNumber;
    data['sponsorName'] = this.sponsorName;
    data['dob'] = this.dob;
    data['documentName'] = this.documentName;
    data['landMark'] = this.landMark;
    data['mobileno2'] = this.mobileno2;
    data['title'] = this.title;
    data['whatsappno'] = this.whatsappno;
    data['pinCode'] = this.pinCode;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    return data;
  }
}

class OrdersList {
  int sno;
  int productId;
  int addressId;
  int saleId;
  int stage;
  String canceledbyType;
  String canceledby;
  String estimateddelivery;
  String billno;
  String itemOrderId;
  String folderName;
  String fileName;
  String paymentmode;
  String paymentstatus;
  String category;
  String subCategory;
  String groupName;
  String subGroupName;
  String productName;
  String aliasName;
  String productCode;
  String stageName;
  String barCode;
  String defaultName;
  String defaultNumber;
  String referalId;
  String productStatus;
  String orderStatus;
  String bookingDateTime;
  double discountpercent;
  double discountAmount;
  int quantity;
  double saleRate;
  double mrpRate;
  double purchaseRate;
  int discount;
  double taxamount;
  double subtotal;
  double payableAmount;
  int taxPercentage;
  int saleTax;
  int purchaseTax;
  double gstAmount;
  double grossAmount;
  double shippingCharge;
  String subfoldername;
  String subfilename;
  String subproductname;
  String bookingtime;
  String indivisualOrderStatus;
  String weight;
  String grossweight;
  String netweight;
  String unit;

  OrdersList(
      {this.sno,
        this.productId,
        this.addressId,
        this.saleId,
        this.stage,
        this.canceledbyType,
        this.canceledby,
        this.estimateddelivery,
        this.billno,
        this.itemOrderId,
        this.folderName,
        this.fileName,
        this.paymentmode,
        this.paymentstatus,
        this.category,
        this.subCategory,
        this.groupName,
        this.subGroupName,
        this.productName,
        this.aliasName,
        this.productCode,
        this.stageName,
        this.barCode,
        this.defaultName,
        this.defaultNumber,
        this.referalId,
        this.productStatus,
        this.orderStatus,
        this.bookingDateTime,
        this.discountpercent,
        this.discountAmount,
        this.quantity,
        this.saleRate,
        this.mrpRate,
        this.purchaseRate,
        this.discount,
        this.taxamount,
        this.subtotal,
        this.payableAmount,
        this.taxPercentage,
        this.saleTax,
        this.purchaseTax,
        this.gstAmount,
        this.grossAmount,
        this.shippingCharge,
        this.subfoldername,
        this.subfilename,
        this.subproductname,
        this.bookingtime,
        this.indivisualOrderStatus,
        this.weight,
        this.grossweight,
        this.netweight,
        this.unit});

  OrdersList.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    productId = json['productId'];
    addressId = json['addressId'];
    saleId = json['saleId'];
    stage = json['stage'];
    canceledbyType = json['canceledbyType'];
    canceledby = json['canceledby'];
    estimateddelivery = json['estimateddelivery'];
    billno = json['billno'];
    itemOrderId = json['itemOrderId'];
    folderName = json['folderName'];
    fileName = json['fileName'];
    paymentmode = json['paymentmode'];
    paymentstatus = json['paymentstatus'];
    category = json['category'];
    subCategory = json['subCategory'];
    groupName = json['groupName'];
    subGroupName = json['subGroupName'];
    productName = json['productName'];
    aliasName = json['aliasName'];
    productCode = json['productCode'];
    stageName = json['stageName'];
    barCode = json['barCode'];
    defaultName = json['defaultName'];
    defaultNumber = json['defaultNumber'];
    referalId = json['referalId'];
    productStatus = json['productStatus'];
    orderStatus = json['OrderStatus'];
    bookingDateTime = json['bookingDateTime'];
    discountpercent = double.parse(json['discountpercent'].toString());
    discountAmount = double.parse(json['discountAmount'].toString());
    quantity = json['quantity'];
    saleRate = double.parse(json['saleRate'].toString());
    mrpRate = double.parse(json['mrpRate'].toString());
    purchaseRate = double.parse(json['purchaseRate'].toString());
    discount = json['discount'];
    taxamount = double.parse(json['taxamount'].toString());
    subtotal = double.parse(json['subtotal'].toString());
    payableAmount = double.parse(json['payableAmount'].toString());
    taxPercentage = json['tax_percentage'];
    saleTax = json['saleTax'];
    purchaseTax = json['purchaseTax'];
    gstAmount = double.parse(json['gstAmount'].toString());
    grossAmount = double.parse(json['grossAmount'].toString());
    shippingCharge = double.parse(json['shippingCharge'].toString());
    subfoldername = json['subfoldername'];
    subfilename = json['subfilename'];
    subproductname = json['subproductname'];
    bookingtime = json['bookingtime'];
    indivisualOrderStatus = json['indivisualOrderStatus'];
    weight = json['weight'];
    grossweight = json['grossweight'];
    netweight = json['netweight'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['productId'] = this.productId;
    data['addressId'] = this.addressId;
    data['saleId'] = this.saleId;
    data['stage'] = this.stage;
    data['canceledbyType'] = this.canceledbyType;
    data['canceledby'] = this.canceledby;
    data['estimateddelivery'] = this.estimateddelivery;
    data['billno'] = this.billno;
    data['itemOrderId'] = this.itemOrderId;
    data['folderName'] = this.folderName;
    data['fileName'] = this.fileName;
    data['paymentmode'] = this.paymentmode;
    data['paymentstatus'] = this.paymentstatus;
    data['category'] = this.category;
    data['subCategory'] = this.subCategory;
    data['groupName'] = this.groupName;
    data['subGroupName'] = this.subGroupName;
    data['productName'] = this.productName;
    data['aliasName'] = this.aliasName;
    data['productCode'] = this.productCode;
    data['stageName'] = this.stageName;
    data['barCode'] = this.barCode;
    data['defaultName'] = this.defaultName;
    data['defaultNumber'] = this.defaultNumber;
    data['referalId'] = this.referalId;
    data['productStatus'] = this.productStatus;
    data['OrderStatus'] = this.orderStatus;
    data['bookingDateTime'] = this.bookingDateTime;
    data['discountpercent'] = this.discountpercent;
    data['discountAmount'] = this.discountAmount;
    data['quantity'] = this.quantity;
    data['saleRate'] = this.saleRate;
    data['mrpRate'] = this.mrpRate;
    data['purchaseRate'] = this.purchaseRate;
    data['discount'] = this.discount;
    data['taxamount'] = this.taxamount;
    data['subtotal'] = this.subtotal;
    data['payableAmount'] = this.payableAmount;
    data['tax_percentage'] = this.taxPercentage;
    data['saleTax'] = this.saleTax;
    data['purchaseTax'] = this.purchaseTax;
    data['gstAmount'] = this.gstAmount;
    data['grossAmount'] = this.grossAmount;
    data['shippingCharge'] = this.shippingCharge;
    data['subfoldername'] = this.subfoldername;
    data['subfilename'] = this.subfilename;
    data['subproductname'] = this.subproductname;
    data['bookingtime'] = this.bookingtime;
    data['indivisualOrderStatus'] = this.indivisualOrderStatus;
    data['weight'] = this.weight;
    data['grossweight'] = this.grossweight;
    data['netweight'] = this.netweight;
    data['unit'] = this.unit;
    return data;
  }
}