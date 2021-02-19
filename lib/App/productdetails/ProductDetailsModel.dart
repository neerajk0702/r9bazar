import 'package:rbazaar/App/productdetails/CartProductDetails.dart';

class ProductDetailsModel {
  List<Subproducts> subproducts;
  bool status;
  String message;
  int totalItem = 0;
  ProductDetailsModel({this.subproducts});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['subproducts'] != null) {
      subproducts = new List<Subproducts>();
      json['subproducts'].forEach((v) {
        subproducts.add(new Subproducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subproducts != null) {
      data['subproducts'] = this.subproducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subproducts {
  int dsno;
  int productid;
  int patternid;
  int productimageSno;
  String productName;
  String aliasName;
  String concatProductName;
  String categoryName;
  String unit;
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
  String category;
  String productCode;
  Products products;
  int dsnolocal;

  double dbnetweight;
  double dbQuantityLocal;

  Subproducts({this.dsno,
    this.productid,
    this.patternid,
    this.productimageSno,
    this.productName,
    this.aliasName,
    this.concatProductName,
    this.categoryName,
    this.unit,
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
    this.productCode,
    this.products,
  this.dsnolocal});

  Subproducts.fromJson(Map<String, dynamic> json) {
    dsno = json['dsno'];
    productid = json['productid'];
    patternid = json['patternid'];
    productimageSno = json['productimageSno'];
    productName = json['productName'];
    aliasName = json['aliasName'];
    concatProductName = json['concatProductName'];
    categoryName = json['categoryName'];
    unit = json['unit'];
    saleRate = double.parse(json['saleRate'].toString());
    purchaseRate = double.parse(json['purchaseRate'].toString());
    discounts = double.parse(json['discounts'].toString());
    qtys = json['qtys'];
    schemeDiscounts = json['schemeDiscounts'];
    totalQtys = json['totalQtys'];
    mrps = json['mrps'];
    discount = json['discount'];
    weight = double.parse(json['weight'].toString());
    grossweight = double.parse(json['grossweight'].toString());
    netweight = double.parse(json['netweight'].toString());
    quantity = json['quantity'];
    ptax = json['ptax'];
    stax = json['stax'];
    folderName = json['folderName'];
    fileName = json['fileName'];
    filepath = json['filepath'];
    category = json['category'];
    productCode = json['productCode'];
    products = json['Products'] != null
        ? new Products.fromJson(json['Products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsno'] = this.dsno;
    data['productid'] = this.productid;
    data['patternid'] = this.patternid;
    data['productimageSno'] = this.productimageSno;
    data['productName'] = this.productName;
    data['aliasName'] = this.aliasName;
    data['concatProductName'] = this.concatProductName;
    data['categoryName'] = this.categoryName;
    data['unit'] = this.unit;
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
    if (this.products != null) {
      data['Products'] = this.products.toJson();
    }
    return data;
  }
}

class Products {
  int dsno;
  String productName;
  String aliasName;
  double saleRate;
  double grossweight;
  double netweight;
  int quantityLocal;
  String imagePath;
  String category;

  Products();

  Products.fromJson(Map<String, dynamic> json) {
    dsno = json['dsno'];
    productName = json['productName'];
    aliasName = json['aliasName'];
    saleRate = json['saleRate'];
    grossweight = json['grossweight'];
    netweight = json['netweight'];
    quantityLocal = json['quantityLocal'];
    imagePath = json['imagePath'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsno'] = this.dsno;
    data['productName'] = this.productName;
    data['aliasName'] = this.aliasName;
    data['saleRate'] = this.saleRate;
    data['grossweight'] = this.grossweight;
    data['netweight'] = this.netweight;
    data['quantityLocal'] = this.quantityLocal;
    data['imagePath'] = this.imagePath;
    data['category'] = this.category;
    return data;
  }
}