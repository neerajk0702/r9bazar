class HotdealModel {
  List<Deals> deals;

  HotdealModel({this.deals});

  HotdealModel.fromJson(Map<String, dynamic> json) {
    if (json['Deals'] != null) {
      deals = new List<Deals>();
      json['Deals'].forEach((v) {
        deals.add(new Deals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deals != null) {
      data['Deals'] = this.deals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deals {
  int dsno;
  int productid;
  int patternid;
  int productimageSno;
  int priceListSno;
  int productDetailmastersno;
  int imgsno;
  String productName;
  String aliasName;
  int saleRate;
  int purchaseRate;
  int discounts;
  int qtys;
  int schemeDiscounts;
  int totalQtys;
  int mrps;
  int discount;
  int weight;
  int grossweight;
  int netweight;
  int quantity;
  int ptax;
  int stax;
  String folderName;
  String fileName;
  String filepath;
  String category;
  String productCode;

  Deals(
      {this.dsno,
        this.productid,
        this.patternid,
        this.productimageSno,
        this.priceListSno,
        this.productDetailmastersno,
        this.imgsno,
        this.productName,
        this.aliasName,
        this.saleRate,
        this.purchaseRate,
        this.discounts,
        this.qtys,
        this.schemeDiscounts,
        this.totalQtys,
        this.mrps,
        this.discount,
        this.weight,
        this.grossweight,
        this.netweight,
        this.quantity,
        this.ptax,
        this.stax,
        this.folderName,
        this.fileName,
        this.filepath,
        this.category,
        this.productCode});

  Deals.fromJson(Map<String, dynamic> json) {
    dsno = json['dsno'];
    productid = json['productid'];
    patternid = json['patternid'];
    productimageSno = json['productimageSno'];
    priceListSno = json['priceListSno'];
    productDetailmastersno = json['productDetailmastersno'];
    imgsno = json['imgsno'];
    productName = json['productName'];
    aliasName = json['aliasName'];
    saleRate = json['saleRate'];
    purchaseRate = json['purchaseRate'];
    discounts = json['discounts'];
    qtys = json['qtys'];
    schemeDiscounts = json['schemeDiscounts'];
    totalQtys = json['totalQtys'];
    mrps = json['mrps'];
    discount = json['discount'];
    weight = json['weight'];
    grossweight = json['grossweight'];
    netweight = json['netweight'];
    quantity = json['quantity'];
    ptax = json['ptax'];
    stax = json['stax'];
    folderName = json['folderName'];
    fileName = json['fileName'];
    filepath = json['filepath'];
    category = json['category'];
    productCode = json['productCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsno'] = this.dsno;
    data['productid'] = this.productid;
    data['patternid'] = this.patternid;
    data['productimageSno'] = this.productimageSno;
    data['priceListSno'] = this.priceListSno;
    data['productDetailmastersno'] = this.productDetailmastersno;
    data['imgsno'] = this.imgsno;
    data['productName'] = this.productName;
    data['aliasName'] = this.aliasName;
    data['saleRate'] = this.saleRate;
    data['purchaseRate'] = this.purchaseRate;
    data['discounts'] = this.discounts;
    data['qtys'] = this.qtys;
    data['schemeDiscounts'] = this.schemeDiscounts;
    data['totalQtys'] = this.totalQtys;
    data['mrps'] = this.mrps;
    data['discount'] = this.discount;
    data['weight'] = this.weight;
    data['grossweight'] = this.grossweight;
    data['netweight'] = this.netweight;
    data['quantity'] = this.quantity;
    data['ptax'] = this.ptax;
    data['stax'] = this.stax;
    data['folderName'] = this.folderName;
    data['fileName'] = this.fileName;
    data['filepath'] = this.filepath;
    data['category'] = this.category;
    data['productCode'] = this.productCode;
    return data;
  }
}