class PincodeModel {
  String status;
  List<Pincodes> pincodes;

  PincodeModel({this.status, this.pincodes});

  PincodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['pincodes'] != null) {
      pincodes = new List<Pincodes>();
      json['pincodes'].forEach((v) {
        pincodes.add(new Pincodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.pincodes != null) {
      data['pincodes'] = this.pincodes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pincodes {
  int sno;
  String availability;
  int gid;
  String type;
  String pincode;
  int ledgerunder;
  int ledgertype;
  int grouptype;
  int department;
  int areaname;
  int rootname;
  int state;
  int city;
  int transportername;
  int amount;

  Pincodes(
      {this.sno,
        this.availability,
        this.gid,
        this.type,
        this.pincode,
        this.ledgerunder,
        this.ledgertype,
        this.grouptype,
        this.department,
        this.areaname,
        this.rootname,
        this.state,
        this.city,
        this.transportername,
        this.amount});

  Pincodes.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    availability = json['availability'];
    gid = json['gid'];
    type = json['type'];
    pincode = json['pincode'];
    ledgerunder = json['ledgerunder'];
    ledgertype = json['ledgertype'];
    grouptype = json['grouptype'];
    department = json['department'];
    areaname = json['areaname'];
    rootname = json['rootname'];
    state = json['state'];
    city = json['city'];
    transportername = json['transportername'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['availability'] = this.availability;
    data['gid'] = this.gid;
    data['type'] = this.type;
    data['pincode'] = this.pincode;
    data['ledgerunder'] = this.ledgerunder;
    data['ledgertype'] = this.ledgertype;
    data['grouptype'] = this.grouptype;
    data['department'] = this.department;
    data['areaname'] = this.areaname;
    data['rootname'] = this.rootname;
    data['state'] = this.state;
    data['city'] = this.city;
    data['transportername'] = this.transportername;
    data['amount'] = this.amount;
    return data;
  }
}