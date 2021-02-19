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
  String category;
  String group;
  String subGroup;
  String subCategory;
  String productName;
  String applicableMFD;
  String expDate;
  String endtime;
  String expDateforCounter;
  int minqtyalert;
  int rate;
  int tax;
  double mrp;
  double saleRate;
  double purchaseRate;
  double discount;
  int size;
  int sequence;
  int categorySno;
  int patternId;
  String labelName;
  String hideShow;
  String aliasName;
  String folderName;
  String image1Filename;
  String image1FilePath;
  int hours;

  FlashSaleList(
      {this.sno,
        this.productId,
        this.category,
        this.group,
        this.subGroup,
        this.subCategory,
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
        this.image1FilePath,
        this.hours});

  FlashSaleList.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    productId = json['productId'];
    category = json['category'];
    group = json['group'];
    subGroup = json['subGroup'];
    subCategory = json['subCategory'];
    productName = json['productName'];
    applicableMFD = json['applicableMFD'];
    expDate = json['expDate'];
    endtime = json['endtime'];
    expDateforCounter = json['expDateforCounter'];
    minqtyalert = json['minqtyalert'];
    rate = json['rate'];
    tax = json['tax'];
    mrp = double.parse(json['mrp'].toString());
    saleRate = double.parse(json['sale_Rate'].toString());
    purchaseRate = double.parse(json['purchase_Rate'].toString());
    discount = double.parse(json['discount'].toString());
    size = json['size'];
    sequence = json['sequence'];
    categorySno = json['categorySno'];
    patternId = json['patternId'];
    labelName = json['label_Name'];
    hideShow = json['hide_show'];
    aliasName = json['alias_Name'];
    folderName = json['folderName'];
    image1Filename = json['image1_Filename'];
    image1FilePath = json['image1_FilePath'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['productId'] = this.productId;
    data['category'] = this.category;
    data['group'] = this.group;
    data['subGroup'] = this.subGroup;
    data['subCategory'] = this.subCategory;
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
    data['image1_FilePath'] = this.image1FilePath;
    data['hours'] = this.hours;
    return data;
  }
}