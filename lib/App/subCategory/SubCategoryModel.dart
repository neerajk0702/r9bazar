class SubCategoryModel {
  List<SubCategories> subCategories;
  bool status;
  String message;
  SubCategoryModel({this.subCategories});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['SubCategories'] != null) {
      subCategories = new List<SubCategories>();
      json['SubCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
      data['SubCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  String subCategory;
  String category;
  String concatString;

  SubCategories({this.subCategory, this.category, this.concatString});

  SubCategories.fromJson(Map<String, dynamic> json) {
    subCategory = json['SubCategory'];
    category = json['Category'];
    concatString = json['concatString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubCategory'] = this.subCategory;
    data['Category'] = this.category;
    data['concatString'] = this.concatString;
    return data;
  }
}