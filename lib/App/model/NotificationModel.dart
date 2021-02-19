class NotificationModel {
  String id;
  String title;
  String subtitle;
  String description;
  bool isRead;
  bool isLongPress;
  String time;
  String action;
  String actionId;
  String actionSlug;
  String collectionType;
  String collectionId;

  NotificationModel({
    this.id = '',
    this.title = '',
    this.subtitle = '',
    this.description = '',
    this.isRead,
    this.isLongPress = false,
    this.time = '',
    this.action = '',
    this.actionSlug = '',
    this.actionId = '',
    this.collectionType,
    this.collectionId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] != null && json['id'].toString().trim() != ''
          ? json['id'].toString()
          : '',
      title: json['title'] != null && json['title'].toString().trim() != null
          ? json['title'].toString()
          : '',
      isRead: json['is_read'],
      time: json['created_at'] != null &&
          json['created_at'].toString().trim() != null
          ? json['created_at'].toString()
          : '',
      description: json['description'] != null &&
          json['description'].toString().trim() != null
          ? json['description'].toString()
          : '',
      action: json['action'] != null && json['action'].toString().trim() != null
          ? json['action'].toString()
          : '',
      actionId: json['action_id'] != null &&
          json['action_id'].toString().trim() != null
          ? json['action_id'].toString()
          : '',
      actionSlug: json['action_slug'] != null &&
          json['action_slug'].toString().trim() != null
          ? json['action_slug'].toString()
          : '',
      collectionType: json['collection_type'] != null &&
          json['collection_type'].toString().trim() != null
          ? json['collection_type'].toString()
          : '',
      collectionId: json['collection_id'] != null &&
          json['collection_id'].toString().trim() != null
          ? json['collection_id'].toString()
          : '',
    );
  }
  factory NotificationModel.fromNotificationJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] != null && json['id'].toString().trim() != null
          ? json['id'].toString()
          : '',
      title: json['title'] != null && json['title'].toString().trim() != null
          ? json['title'].toString()
          : '',
      time: json['created_at'] != null &&
          json['created_at'].toString().trim() != null
          ? json['created_at'].toString()
          : '',
      description: json['description'] != null &&
          json['description'].toString().trim() != null
          ? json['description'].toString()
          : '',
      action: json['action'] != null && json['action'].toString().trim() != null
          ? json['action'].toString()
          : '',
      actionId: json['action_id'] != null &&
          json['action_id'].toString().trim() != null
          ? json['action_id'].toString()
          : '',
      actionSlug: json['action_slug'] != null &&
          json['action_slug'].toString().trim() != null
          ? json['action_slug'].toString()
          : '',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": title,
    "reg_no": subtitle,
    // "present_count": message,
    // "total_attendence": isViewed,
    "absent_count": time,
  };
}