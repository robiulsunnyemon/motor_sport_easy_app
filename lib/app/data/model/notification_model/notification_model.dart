class NotificationModel {
  final String id;
  final String uid;
  final String? title;
  final String? message;
  final String? type;
  final String? broadcastId;
  final String? vibrationType;
  final DateTime? timestamp;
  final DateTime? notificationTime;
  final bool sent;
  final FcmResult? fcmResult;
  final NotificationMessage? notificationMessage;
  final NotificationData? data;
  final DateTime? sentAt;
  final DateTime? processedAt;

  NotificationModel({
    required this.id,
    required this.uid,
    this.title,
    this.message,
    this.type,
    this.broadcastId,
    this.vibrationType,
    this.timestamp,
    this.notificationTime,
    required this.sent,
    this.fcmResult,
    this.notificationMessage,
    this.data,
    this.sentAt,
    this.processedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // message ফিল্ড টাইপ চেক করা
    dynamic messageData = json['message'];
    NotificationMessage? notificationMessage;
    String? messageText;

    if (messageData is Map<String, dynamic>) {
      notificationMessage = NotificationMessage.fromJson(messageData);
      messageText = null;
    } else if (messageData is String) {
      messageText = messageData;
      notificationMessage = null;
    }

    return NotificationModel(
      id: json['id'] ?? '',
      uid: json['uid'] ?? '',
      title: json['title'],
      message: messageText,
      type: json['type'],
      broadcastId: json['broadcastId'],
      vibrationType: json['vibrationType'],
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      notificationTime: json['notificationTime'] != null ? DateTime.parse(json['notificationTime']) : null,
      sent: json['sent'] ?? false,
      fcmResult: json['fcm_result'] != null ? FcmResult.fromJson(json['fcm_result']) : null,
      notificationMessage: notificationMessage,
      data: json['data'] != null ? NotificationData.fromJson(json['data']) : null,
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
      processedAt: json['processedAt'] != null ? DateTime.parse(json['processedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'message': message ?? notificationMessage?.toJson(),
      'type': type,
      'broadcastId': broadcastId,
      'vibrationType': vibrationType,
      'timestamp': timestamp?.toIso8601String(),
      'notificationTime': notificationTime?.toIso8601String(),
      'sent': sent,
      'fcm_result': fcmResult?.toJson(),
      'data': data?.toJson(),
      'sentAt': sentAt?.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
    };
  }

  String get displayTitle {
    if (title != null) return title!;
    if (notificationMessage != null) return notificationMessage!.notification.title;
    return 'Notification';
  }

  String get displayBody {
    if (message != null) return message!;
    if (notificationMessage != null) return notificationMessage!.notification.body;
    return '';
  }

  DateTime get displayTime {
    return timestamp ?? notificationTime ?? sentAt ?? processedAt ?? DateTime.now();
  }

  String get notificationType {
    if (type != null) return type!;
    if (data != null) return data!.type;
    return 'unknown';
  }
}

class FcmResult {
  final bool success;
  final String messageId;

  FcmResult({
    required this.success,
    required this.messageId,
  });

  factory FcmResult.fromJson(Map<String, dynamic> json) {
    return FcmResult(
      success: json['success'] ?? false,
      messageId: json['messageId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'messageId': messageId,
    };
  }
}

class NotificationMessage {
  final NotificationContent notification;

  NotificationMessage({
    required this.notification,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage(
      notification: NotificationContent.fromJson(json['notification'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification': notification.toJson(),
    };
  }
}

class NotificationContent {
  final String title;
  final String body;

  NotificationContent({
    required this.title,
    required this.body,
  });

  factory NotificationContent.fromJson(Map<String, dynamic> json) {
    return NotificationContent(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}

class NotificationData {
  final String type;
  final String? userId;
  final String? timestamp;
  final String category;
  final String sequence;

  NotificationData({
    required this.type,
    this.userId,
    this.timestamp,
    required this.category,
    required this.sequence,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      type: json['type'] ?? '',
      userId: json['userId'],
      timestamp: json['timestamp'],
      category: json['category'] ?? '',
      sequence: json['sequence'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'userId': userId,
      'timestamp': timestamp,
      'category': category,
      'sequence': sequence,
    };
  }
}

class NotificationResponse {
  final String uid;
  final List<NotificationModel> notifications;
  final int count;
  final int totalCount;

  NotificationResponse({
    required this.uid,
    required this.notifications,
    required this.count,
    required this.totalCount,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      uid: json['uid'] ?? '',
      notifications: List<NotificationModel>.from(
        (json['notifications'] ?? []).map(
              (x) => NotificationModel.fromJson(x),
        ),
      ),
      count: json['count'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'notifications': notifications.map((x) => x.toJson()).toList(),
      'count': count,
      'totalCount': totalCount,
    };
  }
}