import 'package:cloud_firestore/cloud_firestore.dart';

class RaceModel {
  final DateTime createdAt;
  final String logoUrl;
  final String title;
  final String id;

  RaceModel({
    required this.createdAt,
    required this.logoUrl,
    required this.title,
    required this.id,
  });

  factory RaceModel.fromJson(Map<String, dynamic> json, {String id = ''}) {
    return RaceModel(
      createdAt: _toDateTime(json['createdAt']),
      logoUrl: json['logoUrl'] ?? '',
      title: json['title'] ?? '',
      id: id,
    );
  }

  factory RaceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RaceModel.fromJson(data, id: doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': Timestamp.fromDate(createdAt),
      'logoUrl': logoUrl,
      'title': title,

    };
  }

  static DateTime _toDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    } else if (value is DateTime) {
      return value;
    }
    return DateTime.now();
  }
}



