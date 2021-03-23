class FlashSaleReportModel {
  List<FlashSaleList> flashSaleList;
  String expirydateCount;

  FlashSaleReportModel({this.flashSaleList, this.expirydateCount});

  FlashSaleReportModel.fromJson(Map<String, dynamic> json) {
    if (json['FlashSaleList'] != null) {
      flashSaleList = new List<FlashSaleList>();
      json['FlashSaleList'].forEach((v) {
        flashSaleList.add(new FlashSaleList.fromJson(v));
      });
    }
    expirydateCount = json['ExpirydateCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flashSaleList != null) {
      data['FlashSaleList'] =
          this.flashSaleList.map((v) => v.toJson()).toList();
    }
    data['ExpirydateCount'] = this.expirydateCount;
    return data;
  }
}

class FlashSaleList {
  int sno;
  String productId;
  String shortDescription;
  String category;
  String group;
  String subGroup;
  String subCategory;
  String subProductName;
  String unit;
  String grossweight;
  String weight;
  String netWeight;
  String productName;
  String applicableMFD;
  String expDate;
  String endtime;
  String expDateforCounter;
  double minqtyalert;
  double rate;
  double tax;
  double mrp;
  double saleRate;
  double purchaseRate;
  double discount;
  double size;
  int sequence;
  int categorySno;
  int patternId;
  String labelName;
  String hideShow;
  String aliasName;
  String folderName;
  String image1Filename;
  int hours;

  FlashSaleList(
      {this.sno,
        this.productId,
        this.shortDescription,
        this.category,
        this.group,
        this.subGroup,
        this.subCategory,
        this.subProductName,
        this.unit,
        this.grossweight,
        this.weight,
        this.netWeight,
        this.productName,
        this.applicableMFD,
        this.expDate,
        this.endtime,
        this.expDateforCounter,
        this.minqtyalert,
        this.rate,
        this.tax,
        this.mrp,
        this.saleRate,
        this.purchaseRate,
        this.discount,
        this.size,
        this.sequence,
        this.categorySno,
        this.patternId,
        this.labelName,
        this.hideShow,
        this.aliasName,
        this.folderName,
        this.image1Filename,
        this.hours});

  FlashSaleList.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    productId = json['productId'];
    shortDescription = json['shortDescription'];
    category = json['category'];
    group = json['group'];
    subGroup = json['subGroup'];
    subCategory = json['subCategory'];
    subProductName = json['subProductName'];
    unit = json['unit'];
    grossweight = json['grossweight'];
    weight = json['weight'];
    netWeight = json['netWeight'];
    productName = json['productName'];
    applicableMFD = json['applicableMFD'];
    expDate = json['expDate'];
    endtime = json['endtime'];
    expDateforCounter = json['expDateforCounter'];
    minqtyalert = double.parse(json['minqtyalert'].toString());
    rate = double.parse(json['rate'].toString());
    tax = double.parse(json['tax'].toString());
    mrp = double.parse(json['mrp'].toString());
    saleRate = double.parse(json['sale_Rate'].toString());
    purchaseRate = double.parse(json['purchase_Rate'].toString());
    discount = double.parse(json['discount'].toString());
    size = double.parse(json['size'].toString());
    sequence = json['sequence'];
    categorySno = json['categorySno'];
    patternId = json['patternId'];
    labelName = json['label_Name'];
    hideShow = json['hide_show'];
    aliasName = json['alias_Name'];
    folderName = json['folderName'];
    image1Filename = json['image1_Filename'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['productId'] = this.productId;
    data['shortDescription'] = this.shortDescription;
    data['category'] = this.category;
    data['group'] = this.group;
    data['subGroup'] = this.subGroup;
    data['subCategory'] = this.subCategory;
    data['subProductName'] = this.subProductName;
    data['unit'] = this.unit;
    data['grossweight'] = this.grossweight;
    data['weight'] = this.weight;
    data['netWeight'] = this.netWeight;
    data['productName'] = this.productName;
    data['applicableMFD'] = this.applicableMFD;
    data['expDate'] = this.expDate;
    data['endtime'] = this.endtime;
    data['expDateforCounter'] = this.expDateforCounter;
    data['minqtyalert'] = this.minqtyalert;
    data['rate'] = this.rate;
    data['tax'] = this.tax;
    data['mrp'] = this.mrp;
    data['sale_Rate'] = this.saleRate;
    data['purchase_Rate'] = this.purchaseRate;
    data['discount'] = this.discount;
    data['size'] = this.size;
    data['sequence'] = this.sequence;
    data['categorySno'] = this.categorySno;
    data['patternId'] = this.patternId;
    data['label_Name'] = this.labelName;
    data['hide_show'] = this.hideShow;
    data['alias_Name'] = this.aliasName;
    data['folderName'] = this.folderName;
    data['image1_Filename'] = this.image1Filename;
    data['hours'] = this.hours;
    return data;
  }
}