import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String message;
  final String userId;

  Note({required this.id, required this.title, required this.message, required this.userId});

  // Factory to create a Note from a Firestore document
  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      title: data['TITLE'] ?? '',
      message: data['MESSAGE'] ?? '',
      userId: data['USER_ID'] ?? '',
    );
  }
}
