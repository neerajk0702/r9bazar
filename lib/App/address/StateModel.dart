class StateModel {
  List<States> states;

  StateModel({this.states});

  StateModel.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = new List<States>();
      json['states'].forEach((v) {
        states.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.states != null) {
      data['states'] = this.states.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  int sno;
  int gid;
  String stateName;
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

  States(
      {this.sno,
        this.gid,
        this.stateName,
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

  States.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    gid = json['gid'];
    stateName = json['stateName'];
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
    data['stateName'] = this.stateName;
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