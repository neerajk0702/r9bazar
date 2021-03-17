class DeliveryLoginModel {
  String status;
  DeliveryBoyDetail deliveryBoyDetail;

  DeliveryLoginModel({this.status, this.deliveryBoyDetail});

  DeliveryLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    deliveryBoyDetail = json['DeliveryBoyDetail'] != null
        ? new DeliveryBoyDetail.fromJson(json['DeliveryBoyDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.deliveryBoyDetail != null) {
      data['DeliveryBoyDetail'] = this.deliveryBoyDetail.toJson();
    }
    return data;
  }
}

class DeliveryBoyDetail {
  String address;
  Null state;
  int totalValue;
  Null userName;
  Null password;
  String status;
  Null enteredon;
  int discount;
  Null currentDate;
  Null courierNo;
  Null city;
  Null pan;
  int quantity;
  Null deliveryDate;
  Null paymentMode;
  Null pinCode;
  Null invoiceno;
  Null landmark;
  int stateid;
  Null tan;
  Null gstn;
  Null orderStatus;
  Null paymentstatus;
  Null contactNo;
  Null courierStatus;
  int cityid;
  Null rateDocument;
  Null remarks;
  Null canceledBy;
  Null packageCharge;
  Null tds;
  Null serviceCity;
  String deliveryBoyUsername;
  String deliveryBoyMobile;
  String deliveryBoypassword;
  String deliveryBoyName;
  String deliveryBoyCourierId;
  int shippingCharge;
  int sno;
  Null orderid;
  int mrp;
  int saleRate;
  String courierName;
  String alternativeMobileNo;
  Null minimumPackageSize;
  String contactpersonName;
  Null bigPackageSizeto;
  Null deliveryAllottedDate;
  int expecteddeliverydays;
  Null applicabledateformat;
  int productDispatchedSno;
  Null smallPackageSize;
  Null orderFullstatus;
  String contactpersonMobile;
  Null deliveredstatus;
  Null deliveredDateTime;
  Null cancelationType;
  Null bigPackageCharge;
  int courierServiceCitySno;
  int couriermasterid;
  Null bigPackageSize;
  Null smallPackageSizeto;
  Null minimumPackageSizeto;
  Null weightOfPackage;
  Null rateApplicableDate;
  Null minimumPackageCharge;
  Null paymentstatusFull;
  Null smallPackageCharge;
  Null cancelationDate;
  Null expectedDeliveryDay;

  DeliveryBoyDetail(
      {this.address,
        this.state,
        this.totalValue,
        this.userName,
        this.password,
        this.status,
        this.enteredon,
        this.discount,
        this.currentDate,
        this.courierNo,
        this.city,
        this.pan,
        this.quantity,
        this.deliveryDate,
        this.paymentMode,
        this.pinCode,
        this.invoiceno,
        this.landmark,
        this.stateid,
        this.tan,
        this.gstn,
        this.orderStatus,
        this.paymentstatus,
        this.contactNo,
        this.courierStatus,
        this.cityid,
        this.rateDocument,
        this.remarks,
        this.canceledBy,
        this.packageCharge,
        this.tds,
        this.serviceCity,
        this.deliveryBoyUsername,
        this.deliveryBoyMobile,
        this.deliveryBoypassword,
        this.deliveryBoyName,
        this.deliveryBoyCourierId,
        this.shippingCharge,
        this.sno,
        this.orderid,
        this.mrp,
        this.saleRate,
        this.courierName,
        this.alternativeMobileNo,
        this.minimumPackageSize,
        this.contactpersonName,
        this.bigPackageSizeto,
        this.deliveryAllottedDate,
        this.expecteddeliverydays,
        this.applicabledateformat,
        this.productDispatchedSno,
        this.smallPackageSize,
        this.orderFullstatus,
        this.contactpersonMobile,
        this.deliveredstatus,
        this.deliveredDateTime,
        this.cancelationType,
        this.bigPackageCharge,
        this.courierServiceCitySno,
        this.couriermasterid,
        this.bigPackageSize,
        this.smallPackageSizeto,
        this.minimumPackageSizeto,
        this.weightOfPackage,
        this.rateApplicableDate,
        this.minimumPackageCharge,
        this.paymentstatusFull,
        this.smallPackageCharge,
        this.cancelationDate,
        this.expectedDeliveryDay});

  DeliveryBoyDetail.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    totalValue = json['totalValue'];
    userName = json['userName'];
    password = json['password'];
    status = json['status'];
    enteredon = json['enteredon'];
    discount = json['discount'];
    currentDate = json['currentDate'];
    courierNo = json['courierNo'];
    city = json['city'];
    pan = json['pan'];
    quantity = json['quantity'];
    deliveryDate = json['deliveryDate'];
    paymentMode = json['paymentMode'];
    pinCode = json['pinCode'];
    invoiceno = json['invoiceno'];
    landmark = json['landmark'];
    stateid = json['stateid'];
    tan = json['tan'];
    gstn = json['gstn'];
    orderStatus = json['orderStatus'];
    paymentstatus = json['paymentstatus'];
    contactNo = json['contactNo'];
    courierStatus = json['courierStatus'];
    cityid = json['cityid'];
    rateDocument = json['rateDocument'];
    remarks = json['remarks'];
    canceledBy = json['canceledBy'];
    packageCharge = json['packageCharge'];
    tds = json['tds'];
    serviceCity = json['serviceCity'];
    deliveryBoyUsername = json['deliveryBoyUsername'];
    deliveryBoyMobile = json['deliveryBoyMobile'];
    deliveryBoypassword = json['deliveryBoypassword'];
    deliveryBoyName = json['deliveryBoyName'];
    deliveryBoyCourierId = json['deliveryBoyCourierId'];
    shippingCharge = json['shippingCharge'];
    sno = json['sno'];
    orderid = json['orderid'];
    mrp = json['mrp'];
    saleRate = json['saleRate'];
    courierName = json['courierName'];
    alternativeMobileNo = json['alternativeMobileNo'];
    minimumPackageSize = json['minimumPackageSize'];
    contactpersonName = json['contactpersonName'];
    bigPackageSizeto = json['bigPackageSizeto'];
    deliveryAllottedDate = json['deliveryAllottedDate'];
    expecteddeliverydays = json['expecteddeliverydays'];
    applicabledateformat = json['applicabledateformat'];
    productDispatchedSno = json['productDispatchedSno'];
    smallPackageSize = json['smallPackageSize'];
    orderFullstatus = json['orderFullstatus'];
    contactpersonMobile = json['contactpersonMobile'];
    deliveredstatus = json['deliveredstatus'];
    deliveredDateTime = json['deliveredDateTime'];
    cancelationType = json['cancelationType'];
    bigPackageCharge = json['bigPackageCharge'];
    courierServiceCitySno = json['courierServiceCitySno'];
    couriermasterid = json['couriermasterid'];
    bigPackageSize = json['bigPackageSize'];
    smallPackageSizeto = json['smallPackageSizeto'];
    minimumPackageSizeto = json['minimumPackageSizeto'];
    weightOfPackage = json['weightOfPackage'];
    rateApplicableDate = json['rateApplicableDate'];
    minimumPackageCharge = json['minimumPackageCharge'];
    paymentstatusFull = json['paymentstatusFull'];
    smallPackageCharge = json['smallPackageCharge'];
    cancelationDate = json['cancelationDate'];
    expectedDeliveryDay = json['expectedDeliveryDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['state'] = this.state;
    data['totalValue'] = this.totalValue;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['status'] = this.status;
    data['enteredon'] = this.enteredon;
    data['discount'] = this.discount;
    data['currentDate'] = this.currentDate;
    data['courierNo'] = this.courierNo;
    data['city'] = this.city;
    data['pan'] = this.pan;
    data['quantity'] = this.quantity;
    data['deliveryDate'] = this.deliveryDate;
    data['paymentMode'] = this.paymentMode;
    data['pinCode'] = this.pinCode;
    data['invoiceno'] = this.invoiceno;
    data['landmark'] = this.landmark;
    data['stateid'] = this.stateid;
    data['tan'] = this.tan;
    data['gstn'] = this.gstn;
    data['orderStatus'] = this.orderStatus;
    data['paymentstatus'] = this.paymentstatus;
    data['contactNo'] = this.contactNo;
    data['courierStatus'] = this.courierStatus;
    data['cityid'] = this.cityid;
    data['rateDocument'] = this.rateDocument;
    data['remarks'] = this.remarks;
    data['canceledBy'] = this.canceledBy;
    data['packageCharge'] = this.packageCharge;
    data['tds'] = this.tds;
    data['serviceCity'] = this.serviceCity;
    data['deliveryBoyUsername'] = this.deliveryBoyUsername;
    data['deliveryBoyMobile'] = this.deliveryBoyMobile;
    data['deliveryBoypassword'] = this.deliveryBoypassword;
    data['deliveryBoyName'] = this.deliveryBoyName;
    data['deliveryBoyCourierId'] = this.deliveryBoyCourierId;
    data['shippingCharge'] = this.shippingCharge;
    data['sno'] = this.sno;
    data['orderid'] = this.orderid;
    data['mrp'] = this.mrp;
    data['saleRate'] = this.saleRate;
    data['courierName'] = this.courierName;
    data['alternativeMobileNo'] = this.alternativeMobileNo;
    data['minimumPackageSize'] = this.minimumPackageSize;
    data['contactpersonName'] = this.contactpersonName;
    data['bigPackageSizeto'] = this.bigPackageSizeto;
    data['deliveryAllottedDate'] = this.deliveryAllottedDate;
    data['expecteddeliverydays'] = this.expecteddeliverydays;
    data['applicabledateformat'] = this.applicabledateformat;
    data['productDispatchedSno'] = this.productDispatchedSno;
    data['smallPackageSize'] = this.smallPackageSize;
    data['orderFullstatus'] = this.orderFullstatus;
    data['contactpersonMobile'] = this.contactpersonMobile;
    data['deliveredstatus'] = this.deliveredstatus;
    data['deliveredDateTime'] = this.deliveredDateTime;
    data['cancelationType'] = this.cancelationType;
    data['bigPackageCharge'] = this.bigPackageCharge;
    data['courierServiceCitySno'] = this.courierServiceCitySno;
    data['couriermasterid'] = this.couriermasterid;
    data['bigPackageSize'] = this.bigPackageSize;
    data['smallPackageSizeto'] = this.smallPackageSizeto;
    data['minimumPackageSizeto'] = this.minimumPackageSizeto;
    data['weightOfPackage'] = this.weightOfPackage;
    data['rateApplicableDate'] = this.rateApplicableDate;
    data['minimumPackageCharge'] = this.minimumPackageCharge;
    data['paymentstatusFull'] = this.paymentstatusFull;
    data['smallPackageCharge'] = this.smallPackageCharge;
    data['cancelationDate'] = this.cancelationDate;
    data['expectedDeliveryDay'] = this.expectedDeliveryDay;
    return data;
  }
}