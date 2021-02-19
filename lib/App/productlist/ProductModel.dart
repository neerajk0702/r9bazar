class ProductModel {
  List<Products> products;
  bool status;
  String message;
  ProductModel({this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['Products'] != null) {
      products = new List<Products>();
      json['Products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['Products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int dsno;
  int productid;
  int patternid;
  int productimageSno;
  String productName;
  String subCategory;
  String aliasName;
  String concatProductName;
  String productBarcode;
  String brandName;
  double saleRate;
  double purchaseRate;
  double discounts;
  int qtys;
  int schemeDiscounts;
  int totalQtys;
  int mrps;
  int discount;
  double weight;
  double grossweight;
  double netweight;
  int quantity;
  int ptax;
  int stax;
  String folderName;
  String fileName;
  String filepath;
  String groupName;
  String subGroupName;
  String category;
  String productCode;
  String barCode;

  Products(
      {this.dsno,
        this.productid,
        this.patternid,
        this.productimageSno,
        this.productName,
        this.subCategory,
        this.aliasName,
        this.concatProductName,
        this.productBarcode,
        this.brandName,
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
        this.groupName,
        this.subGroupName,
        this.category,
        this.productCode,
        this.barCode});

  Products.fromJson(Map<String, dynamic> json) {
    dsno = json['dsno'];
    productid = json['productid'];
    patternid = json['patternid'];
    productimageSno = json['productimageSno'];
    productName = json['productName'];
    subCategory = json['subCategory'];
    aliasName = json['aliasName'];
    concatProductName = json['concatProductName'];
    productBarcode = json['productBarcode'];
    brandName = json['brandName'];
    saleRate =  double.parse(json['saleRate'].toString());
    purchaseRate =  double.parse(json['purchaseRate'].toString());
    discounts =  double.parse(json['discounts'].toString());
    qtys = json['qtys'];
    schemeDiscounts = json['schemeDiscounts'];
    totalQtys = json['totalQtys'];
    mrps = json['mrps'];
    discount = json['discount'];
    weight =  double.parse(json['weight'].toString());
    grossweight =  double.parse(json['grossweight'].toString());
    netweight =  double.parse(json['netweight'].toString());
    quantity = json['quantity'];
    ptax = json['ptax'];
    stax = json['stax'];
    folderName = json['folderName'];
    fileName = json['fileName'];
    filepath = json['filepath'];
    groupName = json['groupName'];
    subGroupName = json['SubGroupName'];
    category = json['category'];
    productCode = json['productCode'];
    barCode = json['barCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsno'] = this.dsno;
    data['productid'] = this.productid;
    data['patternid'] = this.patternid;
    data['productimageSno'] = this.productimageSno;
    data['productName'] = this.productName;
    data['subCategory'] = this.subCategory;
    data['aliasName'] = this.aliasName;
    data['concatProductName'] = this.concatProductName;
    data['productBarcode'] = this.productBarcode;
    data['brandName'] = this.brandName;
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
    data['groupName'] = this.groupName;
    data['SubGroupName'] = this.subGroupName;
    data['category'] = this.category;
    data['productCode'] = this.productCode;
    data['barCode'] = this.barCode;
    return data;
  }
}