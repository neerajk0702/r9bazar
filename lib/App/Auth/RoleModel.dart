class RoleModel {
  Role role;

  RoleModel({this.role});

  RoleModel.fromJson(Map<String, dynamic> json) {
    role = json['Role'] != null ? new Role.fromJson(json['Role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.role != null) {
      data['Role'] = this.role.toJson();
    }
    return data;
  }
}

class Role {
  String role1;
  String role;
  String both;

  Role({this.role1, this.role, this.both});

  Role.fromJson(Map<String, dynamic> json) {
    role1 = json['role1'];
    role = json['role'];
    both = json['both'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role1'] = this.role1;
    data['role'] = this.role;
    data['both'] = this.both;
    return data;
  }
}