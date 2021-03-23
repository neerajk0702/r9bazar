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
  String position;
  String role;
  String password;
  Null userName;
  Null fullName;
  Null city;
  Null pinCode;
  Null cityName;
  String whatsappno;
  String dob;
  String mobileno2;
  String documentName;
  Null landMark;
  Null sponsorName;
  String title;
  String filePath;
  int sno;
  String sponsorId;
  String referalId;
  String registeredNo;
  String emailId;
  String lname;
  String userId;
  String folderName;
  String gender;
  Null registeredCity;
  Null googleStateName;
  String documentNumber;
  String otheraddressState;
  String otheraddressPincode;
  String otheraddressCountry;
  Null registrationDate;
  String businesspartnertype;
  Null googleCityName;
  String otheraddressAddress;
  String registeredAddress;
  String registeredLandmark;
  String registeredCountry;
  String registeredState;
  String registeredPincode;
  Null issuingAuthority;
  String registeredArea;
  String otheraddressArea;
  String otheraddressCity;
  String otheraddressLandmark;
  String filename;

  UserDetail(
      {this.address,
        this.name,
        this.location,
        this.state,
        this.country,
        this.stateName,
        this.position,
        this.role,
        this.password,
        this.userName,
        this.fullName,
        this.city,
        this.pinCode,
        this.cityName,
        this.whatsappno,
        this.dob,
        this.mobileno2,
        this.documentName,
        this.landMark,
        this.sponsorName,
        this.title,
        this.filePath,
        this.sno,
        this.sponsorId,
        this.referalId,
        this.registeredNo,
        this.emailId,
        this.lname,
        this.userId,
        this.folderName,
        this.gender,
        this.registeredCity,
        this.googleStateName,
        this.documentNumber,
        this.otheraddressState,
        this.otheraddressPincode,
        this.otheraddressCountry,
        this.registrationDate,
        this.businesspartnertype,
        this.googleCityName,
        this.otheraddressAddress,
        this.registeredAddress,
        this.registeredLandmark,
        this.registeredCountry,
        this.registeredState,
        this.registeredPincode,
        this.issuingAuthority,
        this.registeredArea,
        this.otheraddressArea,
        this.otheraddressCity,
        this.otheraddressLandmark,
        this.filename});

  UserDetail.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
    location = json['location'];
    state = json['state'];
    country = json['country'];
    stateName = json['stateName'];
    position = json['position'];
    role = json['role'];
    password = json['password'];
    userName = json['userName'];
    fullName = json['fullName'];
    city = json['city'];
    pinCode = json['pinCode'];
    cityName = json['cityName'];
    whatsappno = json['whatsappno'];
    dob = json['dob'];
    mobileno2 = json['mobileno2'];
    documentName = json['documentName'];
    landMark = json['landMark'];
    sponsorName = json['sponsorName'];
    title = json['title'];
    filePath = json['filePath'];
    sno = json['sno'];
    sponsorId = json['sponsorId'];
    referalId = json['referalId'];
    registeredNo = json['registeredNo'];
    emailId = json['emailId'];
    lname = json['lname'];
    userId = json['userId'];
    folderName = json['folderName'];
    gender = json['gender'];
    registeredCity = json['registered_city'];
    googleStateName = json['googleStateName'];
    documentNumber = json['documentNumber'];
    otheraddressState = json['otheraddress_state'];
    otheraddressPincode = json['otheraddress_pincode'];
    otheraddressCountry = json['otheraddress_country'];
    registrationDate = json['registrationDate'];
    businesspartnertype = json['businesspartnertype'];
    googleCityName = json['googleCityName'];
    otheraddressAddress = json['otheraddress_address'];
    registeredAddress = json['registered_address'];
    registeredLandmark = json['registered_landmark'];
    registeredCountry = json['registered_country'];
    registeredState = json['registered_state'];
    registeredPincode = json['registered_pincode'];
    issuingAuthority = json['issuingAuthority'];
    registeredArea = json['registered_area'];
    otheraddressArea = json['otheraddress_area'];
    otheraddressCity = json['otheraddress_city'];
    otheraddressLandmark = json['otheraddress_landmark'];
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
    data['position'] = this.position;
    data['role'] = this.role;
    data['password'] = this.password;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['city'] = this.city;
    data['pinCode'] = this.pinCode;
    data['cityName'] = this.cityName;
    data['whatsappno'] = this.whatsappno;
    data['dob'] = this.dob;
    data['mobileno2'] = this.mobileno2;
    data['documentName'] = this.documentName;
    data['landMark'] = this.landMark;
    data['sponsorName'] = this.sponsorName;
    data['title'] = this.title;
    data['filePath'] = this.filePath;
    data['sno'] = this.sno;
    data['sponsorId'] = this.sponsorId;
    data['referalId'] = this.referalId;
    data['registeredNo'] = this.registeredNo;
    data['emailId'] = this.emailId;
    data['lname'] = this.lname;
    data['userId'] = this.userId;
    data['folderName'] = this.folderName;
    data['gender'] = this.gender;
    data['registered_city'] = this.registeredCity;
    data['googleStateName'] = this.googleStateName;
    data['documentNumber'] = this.documentNumber;
    data['otheraddress_state'] = this.otheraddressState;
    data['otheraddress_pincode'] = this.otheraddressPincode;
    data['otheraddress_country'] = this.otheraddressCountry;
    data['registrationDate'] = this.registrationDate;
    data['businesspartnertype'] = this.businesspartnertype;
    data['googleCityName'] = this.googleCityName;
    data['otheraddress_address'] = this.otheraddressAddress;
    data['registered_address'] = this.registeredAddress;
    data['registered_landmark'] = this.registeredLandmark;
    data['registered_country'] = this.registeredCountry;
    data['registered_state'] = this.registeredState;
    data['registered_pincode'] = this.registeredPincode;
    data['issuingAuthority'] = this.issuingAuthority;
    data['registered_area'] = this.registeredArea;
    data['otheraddress_area'] = this.otheraddressArea;
    data['otheraddress_city'] = this.otheraddressCity;
    data['otheraddress_landmark'] = this.otheraddressLandmark;
    data['filename'] = this.filename;
    return data;
  }
}

class OrdersList {
  int sno;
  int productId;
  int addressId;
  int saleId;
  int stage;
  String addressFullname;
  String location;
  String cityName;
  String canceledbyType;
  String canceledby;
  String stateName;
  String estimateddelivery;
  String billno;
  String itemOrderId;
  String folderName;
  String fileName;
  String address;
  String city;
  String pincode;
  String state;
  String landmark;
  String paymentmode;
  String paymentstatus;
  String contactno;
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
  double discount;
  double taxamount;
  double subtotal;
  double payableAmount;
  double taxPercentage;
  double saleTax;
  double purchaseTax;
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
  String boolingslotdate;
  String boolingslottime;

  OrdersList(
      {this.sno,
        this.productId,
        this.addressId,
        this.saleId,
        this.stage,
        this.addressFullname,
        this.location,
        this.cityName,
        this.canceledbyType,
        this.canceledby,
        this.stateName,
        this.estimateddelivery,
        this.billno,
        this.itemOrderId,
        this.folderName,
        this.fileName,
        this.address,
        this.city,
        this.pincode,
        this.state,
        this.landmark,
        this.paymentmode,
        this.paymentstatus,
        this.contactno,
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
        this.unit,
        this.boolingslotdate,
        this.boolingslottime});

  OrdersList.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    productId = json['productId'];
    addressId = json['addressId'];
    saleId = json['saleId'];
    stage = json['stage'];
    addressFullname = json['address_fullname'];
    location = json['location'];
    cityName = json['cityName'];
    canceledbyType = json['canceledbyType'];
    canceledby = json['canceledby'];
    stateName = json['stateName'];
    estimateddelivery = json['estimateddelivery'];
    billno = json['billno'];
    itemOrderId = json['itemOrderId'];
    folderName = json['folderName'];
    fileName = json['fileName'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    state = json['state'];
    landmark = json['landmark'];
    paymentmode = json['paymentmode'];
    paymentstatus = json['paymentstatus'];
    contactno = json['contactno'];
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
    discountpercent =  double.parse(json['discountpercent'].toString());
    discountAmount =  double.parse(json['discountAmount'].toString());
    quantity = json['quantity'];
    saleRate =  double.parse(json['saleRate'].toString());
    mrpRate =  double.parse(json['mrpRate'].toString());
    purchaseRate =  double.parse(json['purchaseRate'].toString());
    discount =  double.parse(json['discount'].toString());
    taxamount =  double.parse(json['taxamount'].toString());
    subtotal =  double.parse(json['subtotal'].toString());
    payableAmount =  double.parse(json['payableAmount'].toString());
    taxPercentage =  double.parse(json['tax_percentage'].toString());
    saleTax =  double.parse(json['saleTax'].toString());
    purchaseTax =  double.parse(json['purchaseTax'].toString());
    gstAmount =  double.parse(json['gstAmount'].toString());
    grossAmount =  double.parse(json['grossAmount'].toString());
    shippingCharge =  double.parse(json['shippingCharge'].toString());
    subfoldername = json['subfoldername'];
    subfilename = json['subfilename'];
    subproductname = json['subproductname'];
    bookingtime = json['bookingtime'];
    indivisualOrderStatus = json['indivisualOrderStatus'];
    weight = json['weight'];
    grossweight = json['grossweight'];
    netweight = json['netweight'];
    unit = json['unit'];
    boolingslotdate = json['boolingslotdate'];
    boolingslottime = json['boolingslottime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['productId'] = this.productId;
    data['addressId'] = this.addressId;
    data['saleId'] = this.saleId;
    data['stage'] = this.stage;
    data['address_fullname'] = this.addressFullname;
    data['location'] = this.location;
    data['cityName'] = this.cityName;
    data['canceledbyType'] = this.canceledbyType;
    data['canceledby'] = this.canceledby;
    data['stateName'] = this.stateName;
    data['estimateddelivery'] = this.estimateddelivery;
    data['billno'] = this.billno;
    data['itemOrderId'] = this.itemOrderId;
    data['folderName'] = this.folderName;
    data['fileName'] = this.fileName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['landmark'] = this.landmark;
    data['paymentmode'] = this.paymentmode;
    data['paymentstatus'] = this.paymentstatus;
    data['contactno'] = this.contactno;
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
    data['boolingslotdate'] = this.boolingslotdate;
    data['boolingslottime'] = this.boolingslottime;
    return data;
  }
}