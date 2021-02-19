class BookingSloatModel {
  List<Slotdate> slotdate;
  List<Slottime> slottime;

  BookingSloatModel({this.slotdate, this.slottime});

  BookingSloatModel.fromJson(Map<String, dynamic> json) {
    if (json['slotdate'] != null) {
      slotdate = new List<Slotdate>();
      json['slotdate'].forEach((v) {
        slotdate.add(new Slotdate.fromJson(v));
      });
    }
    if (json['slottime'] != null) {
      slottime = new List<Slottime>();
      json['slottime'].forEach((v) {
        slottime.add(new Slottime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slotdate != null) {
      data['slotdate'] = this.slotdate.map((v) => v.toJson()).toList();
    }
    if (this.slottime != null) {
      data['slottime'] = this.slottime.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slotdate {
  int sno;
  String slotdate;
  String slot1;

  Slotdate({this.sno, this.slotdate, this.slot1});

  Slotdate.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    slotdate = json['slotdate'];
    slot1 = json['slot1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['slotdate'] = this.slotdate;
    data['slot1'] = this.slot1;
    return data;
  }
}

class Slottime {
  int sno;
  String slottime;
  String timedescription;

  Slottime({this.sno, this.slottime, this.timedescription});

  Slottime.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    slottime = json['slottime'];
    timedescription = json['timedescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['slottime'] = this.slottime;
    data['timedescription'] = this.timedescription;
    return data;
  }
}