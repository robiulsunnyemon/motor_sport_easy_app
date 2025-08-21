import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String broadcastChannel;
  final String location;
  final String sponsor;
  final String logoUrl;
  final DateTime date;
  final DateTime fullDateTime;
  final DateTime createdAt;
  final EventTime time;

  EventModel({
    required this.id,
    required this.broadcastChannel,
    required this.location,
    required this.sponsor,
    required this.logoUrl,
    required this.date,
    required this.fullDateTime,
    required this.createdAt,
    required this.time,
  });

  // Firebase ডকুমেন্ট থেকে মডেল তৈরি করার ফ্যাক্টরি মেথড
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final timeData = data['time'] as Map<String, dynamic>;

    return EventModel(
      id: doc.id,
      broadcastChannel: data['title'] ?? '',
      location: data['location'] ?? '',
      sponsor: data['sponsor'] ?? '',
      logoUrl: data['logoUrl'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      fullDateTime: (data['fullDateTime'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      time: EventTime(
        hour: timeData['hour'] ?? 0,
        minute: timeData['minute'] ?? 0,
      ),
    );
  }

  // মডেলকে Map এ কনভার্ট করার মেথড (Firebase এ সেভ করতে প্রয়োজন হলে)
  Map<String, dynamic> toMap() {
    return {
      'title': broadcastChannel,
      'location': location,
      'sponsor': sponsor,
      'logoUrl': logoUrl,
      'date': Timestamp.fromDate(date),
      'fullDateTime': Timestamp.fromDate(fullDateTime),
      'createdAt': Timestamp.fromDate(createdAt),
      'time': {
        'hour': time.hour,
        'minute': time.minute,
      },
    };
  }
}

class EventTime {
  final int hour;
  final int minute;

  EventTime({
    required this.hour,
    required this.minute,
  });


  String get formattedTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}