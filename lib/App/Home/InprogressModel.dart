class InProgressModel {
  InProgressModel({
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
    this.thumbnail,
    this.media,
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
  Thumbnail thumbnail;
  Media media;

  factory InProgressModel.fromJson(Map<String, dynamic> json) => InProgressModel(
    id: json["id"],
    type: json["type"],
    parentId: json["parent_id"],
    slug: json["slug"],
    sequence: json["sequence"],
    langResourceName: json["lang_resource_name"],
    url: json["url"],
    thumbnailMediaId: json["thumbnail_media_id"],
    mediaId: json["media_id"],
    active: json["active"],
    name: json["name"],
    thumbnail:json["thumbnail"]!=null? Thumbnail.fromJson(json["thumbnail"]):null,
    media:json["media"]!=null? Media.fromJson(json["media"]):null,
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
    "media_id": mediaId,
    "active": active,
    "name": name,
    "thumbnail": thumbnail.toJson(),
    "media": media.toJson(),
  };
}

class Media {
  Media({
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
    this.medialanguages,
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
  List<Thumbnail> medialanguages;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    clientId: json["client_id"],
    name: json["name"],
    type: json["type"],
    url: json["url"],
    downloadUrl: json["download_url"],
    thumbnailUrl: json["thumbnail_url"],
    thumbnailFilePath: json["thumbnail_file_path"],
    filePath: json["file_path"],
    languageId: json["language_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    cloudTransferred: json["cloud_transferred"],
    medialanguages: List<Thumbnail>.from(json["medialanguages"].map((x) => Thumbnail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "name": name,
    "type": type,
    "url": url,
    "download_url": downloadUrl,
    "thumbnail_url": thumbnailUrl,
    "thumbnail_file_path": thumbnailFilePath,
    "file_path": filePath,
    "language_id": languageId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "cloud_transferred": cloudTransferred,
    "medialanguages": List<dynamic>.from(medialanguages.map((x) => x.toJson())),
  };
}

class Thumbnail {
  Thumbnail({
    this.id,
    this.filePath,
    this.mediaId,
    this.languageId,
    this.url,
    this.downloadUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.cloudTransferred,
    this.type,
    this.clientId,
    this.name,
    this.thumbnailUrl,
    this.thumbnailFilePath,
  });

  int id;
  String filePath;
  int mediaId;
  int languageId;
  String url;
  String downloadUrl;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int createdBy;
  dynamic updatedBy;
  int cloudTransferred;
  String type;
  int clientId;
  String name;
  dynamic thumbnailUrl;
  dynamic thumbnailFilePath;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    id: json["id"],
    filePath: json["file_path"],
    mediaId: json["media_id"] == null ? null : json["media_id"],
    languageId: json["language_id"],
    url: json["url"],
    downloadUrl: json["download_url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    cloudTransferred: json["cloud_transferred"],
    type: json["type"],
    clientId: json["client_id"] == null ? null : json["client_id"],
    name: json["name"] == null ? null : json["name"],
    thumbnailUrl: json["thumbnail_url"],
    thumbnailFilePath: json["thumbnail_file_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_path": filePath,
    "media_id": mediaId == null ? null : mediaId,
    "language_id": languageId,
    "url": url,
    "download_url": downloadUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "cloud_transferred": cloudTransferred,
    "type": type,
    "client_id": clientId == null ? null : clientId,
    "name": name == null ? null : name,
    "thumbnail_url": thumbnailUrl,
    "thumbnail_file_path": thumbnailFilePath,
  };
}
