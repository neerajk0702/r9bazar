

class CartProductDetails{

  int dsno;
  String productName;
  String aliasName;
  double saleRate;
  double grossweight;
  double netweight;
  double quantityLocal;
  String imagePath;
  String category;

  CartProductDetails();

  CartProductDetails.fromJson(Map<String, dynamic> json)
      : dsno = json['dsno'],
        productName = json['productName'],
        aliasName = json['aliasName'],
        saleRate = json['saleRate'],
        grossweight = json['grossweight'],
        netweight = json['netweight'],
        quantityLocal = json['quantityLocal'],
        imagePath = json['imagePath'],
        category = json['category'];

  Map<String, dynamic> toJson() => {
    "dsno": dsno,
    "productName": productName,
    "aliasName": aliasName,
    "saleRate": saleRate,
    "grossweight": grossweight,
    "netweight": netweight,
    "quantityLocal": quantityLocal,
    "imagePath": imagePath,
    "category": category,
  };
}