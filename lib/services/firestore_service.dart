import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/model/note_model/note_model.dart';

@injectable
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get a real-time stream of notes for the current user
  Stream<List<Note>> getNotes() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      // Return an empty stream if the user is not logged in
      return Stream.value([]);
    }
    return _db
        .collection('NOTES')
        .where('USER_ID', isEqualTo: userId)
        .orderBy('CREATED_AT', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  // Add a new note for the current user
  Future<void> addNote({required String title, required String message}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User not logged in. Cannot add note.");
    }
    await _db.collection('NOTES').add({
      'TITLE': title,
      'MESSAGE': message,
      'USER_ID': userId,
      'CREATED_AT': Timestamp.now(),
    });
  }

  // 🆕 UPDATE an existing note
  Future<void> updateNote({required String id, required String title, required String message}) async {
    await _db.collection('NOTES').doc(id).update({
      'TITLE': title,
      'MESSAGE': message,
    });
  }

  // 🆕 DELETE a note
  Future<void> deleteNote({required String id}) async {
    await _db.collection('NOTES').doc(id).delete();
  }
}
