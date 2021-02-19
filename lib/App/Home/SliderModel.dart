class SliderModel {
  List<Carousel> carousel;

  SliderModel({this.carousel});

  SliderModel.fromJson(Map<String, dynamic> json) {
    if (json['Carousel'] != null) {
      carousel = new List<Carousel>();
      json['Carousel'].forEach((v) {
        carousel.add(new Carousel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carousel != null) {
      data['Carousel'] = this.carousel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carousel {
  int sno;
  String fileName;
  String filePath;
  String folderName;
  String contentsOne;
  String contentsTwo;
  String contentsThree;
  String subCategory;
  int productId;

  Carousel(
      {this.sno,
        this.fileName,
        this.filePath,
        this.folderName,
        this.contentsOne,
        this.contentsTwo,
        this.contentsThree,
        this.subCategory,
        this.productId});

  Carousel.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    fileName = json['fileName'];
    filePath = json['filePath'];
    folderName = json['folderName'];
    contentsOne = json['contentsOne'];
    contentsTwo = json['contentsTwo'];
    contentsThree = json['contentsThree'];
    subCategory = json['subCategory'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['fileName'] = this.fileName;
    data['filePath'] = this.filePath;
    data['folderName'] = this.folderName;
    data['contentsOne'] = this.contentsOne;
    data['contentsTwo'] = this.contentsTwo;
    data['contentsThree'] = this.contentsThree;
    data['subCategory'] = this.subCategory;
    data['productId'] = this.productId;
    return data;
  }
}