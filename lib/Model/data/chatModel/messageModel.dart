// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class MessageModel {
//   final String id;
//   final String text;
//   final String sender;
//   final DateTime timestamp;
//   final bool read;
//   final bool delivered;
//
//   MessageModel({
//     required this.id,
//     required this.text,
//     required this.sender,
//     required this.timestamp,
//     required this.read,
//     required this.delivered,
//   });
//
//   // Factory constructor to map Firestore document data into MessageModel
//   factory MessageModel.fromMap(Map<String, dynamic> data, String id) {
//     return MessageModel(
//       id: id,
//       text: data['text'] ?? '',
//       sender: data['sender'] ?? '',
//       timestamp: (data['timestamp'] as Timestamp).toDate(), // Handling Firestore Timestamp
//       read: data['read'] ?? false,
//       delivered: data['delivered'] ?? false,
//     );
//   }
//
//   // Convert model back to map for saving to Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'text': text,
//       'sender': sender,
//       'timestamp': Timestamp.fromDate(timestamp), // Convert back to Firestore timestamp
//       'read': read,
//       'delivered': delivered,
//     };
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String text;
  final String sender;
  final String type;
  final DateTime timestamp;
  final bool read;
  final bool delivered;
  final String? url; // New field for image URL

  MessageModel(  {
    this.url,
    required this.type,
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.read,
    required this.delivered,


  });

  // Factory constructor to map FireStore document data into MessageModel
  factory MessageModel.fromMap(Map<String, dynamic> data, String id) {
    return MessageModel(
      id: id,
      text: data['text'] ?? '',
      sender: data['sender'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      read: data['read'] ?? false,
      delivered: data['delivered'] ?? false,
      type: data['type']?? 'text',
      url: data['url'],
    );
  }


  // Convert model back to map for saving to FireStore
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'timestamp': Timestamp.fromDate(timestamp),
      'read': read,
      'delivered': delivered,
      'type': type,
    };
  }

  // Overriding the toString method for logging
  @override
  String toString() {
    return 'MessageModel{id: $id, text: $text, sender: $sender, timestamp: $timestamp, read: $read, delivered: $delivered,type: $type}';
  }
}
