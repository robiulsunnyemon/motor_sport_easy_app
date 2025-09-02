import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String id;
  final String title;
  final DateTime? createdAt;

  Notification({
    required this.id,
    required this.title,
    this.createdAt,
  });

  factory Notification.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Notification(
      id: snapshot.id,
      title: data['title'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdAt': createdAt,
    };
  }
}