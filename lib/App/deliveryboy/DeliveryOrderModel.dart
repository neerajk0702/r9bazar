class DeliveryOrderModel {
  String status;
  List<Orders> orders;

  DeliveryOrderModel({this.status, this.orders});

  DeliveryOrderModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      if (json['Orders'] != null) {
        orders = new List<Orders>();
        json['Orders'].forEach((v) {
          orders.add(new Orders.fromJson(v));
        });
      }
    }catch (error) {
    print(error.toString());
  }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['Orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int sno;
  int stateid;
  int cityid;
  int couriermasterid;
  int expecteddeliverydays;
  int courierServiceCitySno;
  int productDispatchedSno;
  int quantity;
  String courierName;
  String city;
  String state;
  double shippingCharge;
  double saleRate;
  double mrp;
  double discount;
  double totalValue;
  String contactpersonName;
  String contactpersonMobile;
  String canceledBy;
  String cancelationType;
  String cancelationDate;
  String address;
  String remarks;
  String paymentstatus;
  String paymentMode;
  String paymentstatusFull;
  String deliveryBoyMobile;
  String userName;
  String deliveryBoyName;
  String currentDate;
  String deliveryDate;
  String invoiceno;
  String packageCharge;
  String courierNo;
  String alternativeMobileNo;
  String deliveredDateTime;
  String deliveryAllottedDate;
  String status;
  String weightOfPackage;
  String pinCode;
  String landmark;
  String contactNo;
  String orderid;
  String orderStatus;
  String orderFullstatus;
  String deliveredstatus;

  Orders(
      {this.sno,
        this.stateid,
        this.cityid,
        this.couriermasterid,
        this.expecteddeliverydays,
        this.courierServiceCitySno,
        this.productDispatchedSno,
        this.quantity,
        this.courierName,
        this.city,
        this.state,
        this.shippingCharge,
        this.saleRate,
        this.mrp,
        this.discount,
        this.totalValue,
        this.contactpersonName,
        this.contactpersonMobile,
        this.canceledBy,
        this.cancelationType,
        this.cancelationDate,
        this.address,
        this.remarks,
        this.paymentstatus,
        this.paymentMode,
        this.paymentstatusFull,
        this.deliveryBoyMobile,
        this.userName,
        this.deliveryBoyName,
        this.currentDate,
        this.deliveryDate,
        this.invoiceno,
        this.packageCharge,
        this.courierNo,
        this.alternativeMobileNo,
        this.deliveredDateTime,
        this.deliveryAllottedDate,
        this.status,
        this.weightOfPackage,
        this.pinCode,
        this.landmark,
        this.contactNo,
        this.orderid,
        this.orderStatus,
        this.orderFullstatus,
        this.deliveredstatus});

  Orders.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    stateid = json['stateid'];
    cityid = json['cityid'];
    couriermasterid = json['couriermasterid'];
    expecteddeliverydays = json['expecteddeliverydays'];
    courierServiceCitySno = json['courierServiceCitySno'];
    productDispatchedSno = json['productDispatchedSno'];
    quantity = json['quantity'];
    courierName = json['courierName'];
    city = json['city'];
    state = json['state'];
    shippingCharge = double.parse(json['shippingCharge'].toString());
    saleRate = double.parse(json['saleRate'].toString());
    mrp = double.parse(json['mrp'].toString());
    discount = double.parse(json['discount'].toString());
    totalValue = double.parse(json['totalValue'].toString());
    contactpersonName = json['contactpersonName'];
    contactpersonMobile = json['contactpersonMobile'];
    canceledBy = json['canceledBy'];
    cancelationType = json['cancelationType'];
    cancelationDate = json['cancelationDate'];
    address = json['address'];
    remarks = json['remarks'];
    paymentstatus = json['paymentstatus'];
    paymentMode = json['paymentMode'];
    paymentstatusFull = json['paymentstatusFull'];
    deliveryBoyMobile = json['deliveryBoyMobile'];
    userName = json['userName'];
    deliveryBoyName = json['deliveryBoyName'];
    currentDate = json['currentDate'];
    deliveryDate = json['deliveryDate'];
    invoiceno = json['invoiceno'];
    packageCharge = json['packageCharge'];
    courierNo = json['courierNo'];
    alternativeMobileNo = json['alternativeMobileNo'];
    deliveredDateTime = json['deliveredDateTime'];
    deliveryAllottedDate = json['deliveryAllottedDate'];
    status = json['status'];
    weightOfPackage = json['weightOfPackage'];
    pinCode = json['pinCode'];
    landmark = json['landmark'];
    contactNo = json['contactNo'];
    orderid = json['orderid'];
    orderStatus = json['orderStatus'];
    orderFullstatus = json['orderFullstatus'];
    deliveredstatus = json['deliveredstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['stateid'] = this.stateid;
    data['cityid'] = this.cityid;
    data['couriermasterid'] = this.couriermasterid;
    data['expecteddeliverydays'] = this.expecteddeliverydays;
    data['courierServiceCitySno'] = this.courierServiceCitySno;
    data['productDispatchedSno'] = this.productDispatchedSno;
    data['quantity'] = this.quantity;
    data['courierName'] = this.courierName;
    data['city'] = this.city;
    data['state'] = this.state;
    data['shippingCharge'] = this.shippingCharge;
    data['saleRate'] = this.saleRate;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    data['totalValue'] = this.totalValue;
    data['contactpersonName'] = this.contactpersonName;
    data['contactpersonMobile'] = this.contactpersonMobile;
    data['canceledBy'] = this.canceledBy;
    data['cancelationType'] = this.cancelationType;
    data['cancelationDate'] = this.cancelationDate;
    data['address'] = this.address;
    data['remarks'] = this.remarks;
    data['paymentstatus'] = this.paymentstatus;
    data['paymentMode'] = this.paymentMode;
    data['paymentstatusFull'] = this.paymentstatusFull;
    data['deliveryBoyMobile'] = this.deliveryBoyMobile;
    data['userName'] = this.userName;
    data['deliveryBoyName'] = this.deliveryBoyName;
    data['currentDate'] = this.currentDate;
    data['deliveryDate'] = this.deliveryDate;
    data['invoiceno'] = this.invoiceno;
    data['packageCharge'] = this.packageCharge;
    data['courierNo'] = this.courierNo;
    data['alternativeMobileNo'] = this.alternativeMobileNo;
    data['deliveredDateTime'] = this.deliveredDateTime;
    data['deliveryAllottedDate'] = this.deliveryAllottedDate;
    data['status'] = this.status;
    data['weightOfPackage'] = this.weightOfPackage;
    data['pinCode'] = this.pinCode;
    data['landmark'] = this.landmark;
    data['contactNo'] = this.contactNo;
    data['orderid'] = this.orderid;
    data['orderStatus'] = this.orderStatus;
    data['orderFullstatus'] = this.orderFullstatus;
    data['deliveredstatus'] = this.deliveredstatus;
    return data;
  }
}