import 'dart:io';

class DeviceInfoModel {
String modelNo = '';
String brand = '';
String uniqueId = '';
String manufacturer = '';
String androidversion = '';

DeviceInfoModel({
  this.modelNo,
  this.brand,
  this.uniqueId,
  this.manufacturer,
  this.androidversion,
});
Map<String, dynamic> toJson() => {
  "platform": Platform.isIOS ? "IOS" : "Android",
  "modelNo": modelNo,
  "brand": brand,
  "uniqueId": uniqueId,
  "manufacturer": manufacturer,
  "OSversion": androidversion,
};
}
