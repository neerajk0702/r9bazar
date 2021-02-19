class CoursesForYouModel {
  CoursesForYouModel({
    this.id,
    this.type,
    this.parentId,
    this.slug,
    this.sequence,
    this.langResourceName,
    this.url,
    this.thumbnailMediaId,
    this.mediaId,
    this.active,
    this.name,
    this.media,
    this.thumbnail,
    this.activeChild,
  });

  int id;
  String type;
  dynamic parentId;
  dynamic slug;
  int sequence;
  String langResourceName;
  dynamic url;
  int thumbnailMediaId;
  int mediaId;
  int active;
  String name;
  Thumbnail media;
  Thumbnail thumbnail;
  List<ActiveChild> activeChild;

  factory CoursesForYouModel.fromJson(Map<String, dynamic> json) => CoursesForYouModel(
    id: json["id"],
    type: json["type"],
    parentId: json["parent_id"],
    slug: json["slug"],
    sequence: json["sequence"],
    langResourceName: json["lang_resource_name"],
    url: json["url"],
    thumbnailMediaId: json["thumbnail_media_id"],
    mediaId: json["media_id"] == null ? null : json["media_id"],
    active: json["active"],
    name: json["name"],
    media: json["media"] == null ? null : Thumbnail.fromJson(json["media"]),

    thumbnail:json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
    activeChild: List<ActiveChild>.from(json["active_child"].map((x) => ActiveChild.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "parent_id": parentId,
    "slug": slug,
    "sequence": sequence,
    "lang_resource_name": langResourceName,
    "url": url,
    "thumbnail_media_id": thumbnailMediaId,
    "media_id": mediaId == null ? null : mediaId,
    "active": active,
    "name": name,
    "media": media == null ? null : media.toJson(),
    "thumbnail": thumbnail.toJson(),
    "active_child": List<dynamic>.from(activeChild.map((x) => x.toJson())),
  };
}

class ActiveChild {
  ActiveChild({
    this.id,
    this.type,
    this.parentId,
    this.slug,
    this.sequence,
    this.langResourceName,
    this.langResourceDescription,
    this.url,
    this.thumbnailMediaId,
    this.mediaId,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.difficultyLevel,
    this.ageSegment,
    this.names,
    this.completionStatus,
    this.activeChild,
  });

  int id;
  Type type;
  int parentId;
  dynamic slug;
  int sequence;
  String langResourceName;
  String langResourceDescription;
  dynamic url;
  int thumbnailMediaId;
  int mediaId;
  int active;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int difficultyLevel;
  int ageSegment;
  List<NameElement> names;
  List<CompletionStatus> completionStatus;
  List<ActiveChild> activeChild;

  factory ActiveChild.fromJson(Map<String, dynamic> json) => ActiveChild(
    id: json["id"],
    type: typeValues.map[json["type"]],
    parentId: json["parent_id"],
    slug: json["slug"],
    sequence: json["sequence"],
    langResourceName: json["lang_resource_name"],
    langResourceDescription: json["lang_resource_description"],
    url: json["url"],
    thumbnailMediaId: json["thumbnail_media_id"] == null ? null : json["thumbnail_media_id"],
    mediaId: json["media_id"] == null ? null : json["media_id"],
    active: json["active"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    difficultyLevel: json["difficulty_level"] == null ? null : json["difficulty_level"],
    ageSegment: json["age_segment"] == null ? null : json["age_segment"],
    names: json["names"] == null ? null : List<NameElement>.from(json["names"].map((x) => NameElement.fromJson(x))),
    completionStatus: json["completion_status"] == null ? null : List<CompletionStatus>.from(json["completion_status"].map((x) => CompletionStatus.fromJson(x))),
    activeChild: json["active_child"] == null ? null : List<ActiveChild>.from(json["active_child"].map((x) => ActiveChild.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
    "parent_id": parentId,
    "slug": slug,
    "sequence": sequence,
    "lang_resource_name": langResourceName,
    "lang_resource_description": langResourceDescription,
    "url": url,
    "thumbnail_media_id": thumbnailMediaId == null ? null : thumbnailMediaId,
    "media_id": mediaId == null ? null : mediaId,
    "active": active,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "difficulty_level": difficultyLevel == null ? null : difficultyLevel,
    "age_segment": ageSegment == null ? null : ageSegment,
    "names": names == null ? null : List<dynamic>.from(names.map((x) => x.toJson())),
    "completion_status": completionStatus == null ? null : List<dynamic>.from(completionStatus.map((x) => x.toJson())),
    "active_child": activeChild == null ? null : List<dynamic>.from(activeChild.map((x) => x.toJson())),
  };
}

class CompletionStatus {
  CompletionStatus({
    this.contentId,
    this.userId,
    this.completionStatus,
    this.createdAt,
    this.updatedAt,
  });

  int contentId;
  int userId;
  int completionStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory CompletionStatus.fromJson(Map<String, dynamic> json) => CompletionStatus(
    contentId: json["content_id"],
    userId: json["user_id"],
    completionStatus: json["completion_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "content_id": contentId,
    "user_id": userId,
    "completion_status": completionStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class NameElement {
  NameElement({
    this.id,
    this.name,
    this.content,
    this.clientId,
    this.languageId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  NameEnum name;
  String content;
  int clientId;
  int languageId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory NameElement.fromJson(Map<String, dynamic> json) => NameElement(
    id: json["id"],
    name: nameEnumValues.map[json["name"]],
    content: json["content"],
    clientId: json["client_id"],
    languageId: json["language_id"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameEnumValues.reverse[name],
    "content": content,
    "client_id": clientId,
    "language_id": languageId,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum NameEnum { SYS_G_E_HA1589380850, SYS_T_D8_H1589443783, SYS_N6_OJ1593583203, SYS_P_M_WI1604032866, SYS_X_X_RQ1604033183 }

final nameEnumValues = EnumValues({
  "sys_gEHa1589380850": NameEnum.SYS_G_E_HA1589380850,
  "sys_n6oj1593583203": NameEnum.SYS_N6_OJ1593583203,
  "sys_pMWi1604032866": NameEnum.SYS_P_M_WI1604032866,
  "sys_tD8h1589443783": NameEnum.SYS_T_D8_H1589443783,
  "sys_xXRq1604033183": NameEnum.SYS_X_X_RQ1604033183
});

enum Type { CHAPTER, TOPIC }

final typeValues = EnumValues({
  "Chapter": Type.CHAPTER,
  "Topic": Type.TOPIC
});

class Thumbnail {
  Thumbnail({
    this.id,
    this.clientId,
    this.name,
    this.type,
    this.url,
    this.downloadUrl,
    this.thumbnailUrl,
    this.thumbnailFilePath,
    this.filePath,
    this.languageId,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.cloudTransferred,
  });

  int id;
  int clientId;
  String name;
  String type;
  String url;
  String downloadUrl;
  String thumbnailUrl;
  String thumbnailFilePath;
  String filePath;
  int languageId;
  int createdBy;
  dynamic updatedBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int cloudTransferred;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    id: json["id"],
    clientId: json["client_id"],
    name: json["name"],
    type: json["type"],
    url: json["url"],
    downloadUrl: json["download_url"],
    thumbnailUrl: json["thumbnail_url"] == null ? null : json["thumbnail_url"],
    thumbnailFilePath: json["thumbnail_file_path"] == null ? null : json["thumbnail_file_path"],
    filePath: json["file_path"],
    languageId: json["language_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    cloudTransferred: json["cloud_transferred"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "name": name,
    "type": type,
    "url": url,
    "download_url": downloadUrl,
    "thumbnail_url": thumbnailUrl == null ? null : thumbnailUrl,
    "thumbnail_file_path": thumbnailFilePath == null ? null : thumbnailFilePath,
    "file_path": filePath,
    "language_id": languageId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "cloud_transferred": cloudTransferred,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
