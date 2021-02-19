class CityModel {
  List<Citys> citys;

  CityModel({this.citys});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['citys'] != null) {
      citys = new List<Citys>();
      json['citys'].forEach((v) {
        citys.add(new Citys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.citys != null) {
      data['citys'] = this.citys.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Citys {
  int sno;
  int gid;
  String cityName;
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

  Citys(
      {this.sno,
        this.gid,
        this.cityName,
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

  Citys.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    gid = json['gid'];
    cityName = json['cityName'];
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
    data['gid'] = this.gid;
    data['cityName'] = this.cityName;
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