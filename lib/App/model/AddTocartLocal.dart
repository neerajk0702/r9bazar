import 'dart:convert';

class AddTocartLocal {
  int dsno;
  String productName;
  String aliasName;
  double saleRate;
  double grossweight;
  double netweight;
  double totalNetweight;
  double quantityLocal;
  String imagePath;
  String category;

  int patternid;
  double weight;
  String unit;
  int mainproductsno;
  double purchaserate;
  double mrp;
  double discountpercent;


  // patternid INTEGER, weight REAL, unit TEXT,mainproductsno INTEGER,purchaserate REAL, mrp REAL,discountpercent REAL

  // int resultID;
  // AddTocartLocal();
  AddTocartLocal({this.dsno,
    this.productName,
    this.aliasName,
    this.saleRate,
    this.grossweight,
    this.netweight,
    this.totalNetweight,
    this.quantityLocal,
    this.imagePath,
    this.category,
    this.patternid,
    this.weight,
    this.unit,
    this.mainproductsno,
    this.purchaserate,
    this.mrp,
    this.discountpercent
  });

  /*AddTocartLocal(
      this.dsno,
      this.productName,
      this.aliasName,
      this.saleRate,
      this.grossweight,
      this.netweight,
      this.quantityLocal,
      this.imagePath,
      this.category);*/

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "dsno": dsno,
      "productName": productName,
      "aliasName": aliasName,
      "saleRate": saleRate,
      "grossweight": grossweight,
      "netweight": netweight,
      "totalNetweight":totalNetweight,
      "quantityLocal": quantityLocal,
      "imagePath": imagePath,
      "category": category,
      "patternid": patternid,
      "weight": weight,
      "unit": unit,
      "mainproductsno": mainproductsno,
      "purchaserate": purchaserate,
      "mrp": mrp,
      "discountpercent": discountpercent
    };
    return map;
  }
  /* AddTocartLocal.fromMap(Map<String, dynamic> json):
        dsno = json['dsno'],
        productName = json['productName'],
        aliasName = json['aliasName'],
        saleRate = json['saleRate'],
        grossweight = json['grossweight'],
        netweight = json['netweight'],
        quantityLocal = json['quantityLocal'],
        imagePath = json['imagePath'],
        category = json['category'];*/

  AddTocartLocal.fromMap(Map<String, dynamic> data) {
    dsno = data['dsno'];
    productName = data['productName'];
    aliasName = data['aliasName'];
    saleRate = data['saleRate'];
    grossweight = data['grossweight'];
    netweight = data['netweight'];
    totalNetweight=data['totalNetweight'];
    quantityLocal = data['quantityLocal'];
    imagePath = data['imagePath'];
    category = data['category'];
    patternid = data['patternid'];
    weight = data['weight'];
    unit = data['unit'];
    mainproductsno = data['mainproductsno'];
    purchaserate = data['purchaserate'];
    mrp = data['mrp'];
    discountpercent = data['discountpercent'];
  }

}
