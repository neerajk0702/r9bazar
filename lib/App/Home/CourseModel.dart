class CourseModel {
  List<CourseData> data;
  String Message;
  bool status;
  CourseModel({this.data});

  CourseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CourseData>();
      json['data'].forEach((v) {
        data.add(new CourseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseData {
  int id;
  String type;
  Thumbnail thumbnail;
  String name;
  String description;
  int chapterCounts;
  int topicsCount;
  List<int> languages;
  List<int> languagessec=new List();
  int userViews;
  List<int> level;

  CourseData(
      {this.id,
        this.type,
        this.thumbnail,
        this.name,
        this.description,
        this.chapterCounts,
        this.topicsCount,
        this.languages,
        this.userViews,
        this.level});

  CourseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    name = json['name'];
    description = json['description'];
    chapterCounts = json['chapter_counts'];
    topicsCount = json['topics_count'];
    languages = json['languages'].cast<int>();
    userViews = json['user_views'];
    level = json['level'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    data['chapter_counts'] = this.chapterCounts;
    data['topics_count'] = this.topicsCount;
    data['languages'] = this.languages;
    data['user_views'] = this.userViews;
    data['level'] = this.level;
    return data;
  }
}

class Thumbnail {
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
  String updatedBy;
  String deletedAt;
  String createdAt;
  String updatedAt;
  int cloudTransferred;

  Thumbnail(
      {this.id,
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
        this.cloudTransferred});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    name = json['name'];
    type = json['type'];
    url = json['url'];
    downloadUrl = json['download_url'];
    thumbnailUrl = json['thumbnail_url'];
    thumbnailFilePath = json['thumbnail_file_path'];
    filePath = json['file_path'];
    languageId = json['language_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cloudTransferred = json['cloud_transferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['thumbnail_file_path'] = this.thumbnailFilePath;
    data['file_path'] = this.filePath;
    data['language_id'] = this.languageId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cloud_transferred'] = this.cloudTransferred;
    return data;
  }
}