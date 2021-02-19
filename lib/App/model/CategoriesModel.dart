class CategoriesModel {
  List<Categories> categories;

  CategoriesModel({this.categories});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['Categories'] != null) {
      categories = new List<Categories>();
      json['Categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['Categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int sno;
  String menuName;
  String bannerFileName;
  String bannerFilePath;
  String folderName;
  String imageFileName;
  String imageFilePath;
  String iconFileName;
  String iconFilePath;
  String hideShow;
  String concatString;
  int menuSno;
  int subMenuSno;

  Categories(
      {this.sno,
        this.menuName,
        this.bannerFileName,
        this.bannerFilePath,
        this.folderName,
        this.imageFileName,
        this.imageFilePath,
        this.iconFileName,
        this.iconFilePath,
        this.hideShow,
        this.concatString,
        this.menuSno,
        this.subMenuSno});

  Categories.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    menuName = json['menuName'];
    bannerFileName = json['bannerFileName'];
    bannerFilePath = json['bannerFilePath'];
    folderName = json['folderName'];
    imageFileName = json['imageFileName'];
    imageFilePath = json['imageFilePath'];
    iconFileName = json['iconFileName'];
    iconFilePath = json['iconFilePath'];
    hideShow = json['hide_show'];
    concatString = json['concatString'];
    menuSno = json['menuSno'];
    subMenuSno = json['subMenuSno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['menuName'] = this.menuName;
    data['bannerFileName'] = this.bannerFileName;
    data['bannerFilePath'] = this.bannerFilePath;
    data['folderName'] = this.folderName;
    data['imageFileName'] = this.imageFileName;
    data['imageFilePath'] = this.imageFilePath;
    data['iconFileName'] = this.iconFileName;
    data['iconFilePath'] = this.iconFilePath;
    data['hide_show'] = this.hideShow;
    data['concatString'] = this.concatString;
    data['menuSno'] = this.menuSno;
    data['subMenuSno'] = this.subMenuSno;
    return data;
  }
}