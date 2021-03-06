class OrderPlaceModel {
  String status;
  String message;
  String orderno;

  OrderPlaceModel({this.status, this.message,this.orderno});

  OrderPlaceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderno = json['orderno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['orderno'] = this.orderno;
    return data;
  }

}

