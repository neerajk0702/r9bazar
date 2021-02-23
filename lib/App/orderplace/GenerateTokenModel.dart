class GenerateTokenModel {
  Head head;
  Body body;

  GenerateTokenModel({this.head, this.body});

  GenerateTokenModel.fromJson(Map<String, dynamic> json) {
    head = json['head'] != null ? new Head.fromJson(json['head']) : null;
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class Head {
  String responseTimestamp;
  String version;
  String signature;

  Head({this.responseTimestamp, this.version, this.signature});

  Head.fromJson(Map<String, dynamic> json) {
    responseTimestamp = json['responseTimestamp'];
    version = json['version'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseTimestamp'] = this.responseTimestamp;
    data['version'] = this.version;
    data['signature'] = this.signature;
    return data;
  }
}

class Body {
  ResultInfo resultInfo;
  String txnToken;
  bool isPromoCodeValid;
  bool authenticated;

  Body(
      {this.resultInfo,
        this.txnToken,
        this.isPromoCodeValid,
        this.authenticated});

  Body.fromJson(Map<String, dynamic> json) {
    resultInfo = json['resultInfo'] != null
        ? new ResultInfo.fromJson(json['resultInfo'])
        : null;
    txnToken = json['txnToken'];
    isPromoCodeValid = json['isPromoCodeValid'];
    authenticated = json['authenticated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultInfo != null) {
      data['resultInfo'] = this.resultInfo.toJson();
    }
    data['txnToken'] = this.txnToken;
    data['isPromoCodeValid'] = this.isPromoCodeValid;
    data['authenticated'] = this.authenticated;
    return data;
  }
}

class ResultInfo {
  String resultStatus;
  String resultCode;
  String resultMsg;

  ResultInfo({this.resultStatus, this.resultCode, this.resultMsg});

  ResultInfo.fromJson(Map<String, dynamic> json) {
    resultStatus = json['resultStatus'];
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultStatus'] = this.resultStatus;
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    return data;
  }
}