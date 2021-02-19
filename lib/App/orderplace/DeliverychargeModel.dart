class DeliverychargeModel {
  int deliverycharge;

  DeliverychargeModel({this.deliverycharge});

  DeliverychargeModel.fromJson(Map<String, dynamic> json) {
    deliverycharge = json['deliverycharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliverycharge'] = this.deliverycharge;
    return data;
  }
}