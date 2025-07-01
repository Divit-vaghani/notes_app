import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/model/note_model/note_model.dart';
import 'package:notes_app/services/firestore_service.dart';

class NoteProvider extends ChangeNotifier {
  final FirestoreService _firestoreService;
  late StreamSubscription _notesSubscription;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  NoteProvider(this._firestoreService) {
    _listenToNotes();
  }

  void _listenToNotes() {
    _isLoading = true;
    notifyListeners();

    _notesSubscription = _firestoreService.getNotes().listen((notes) {
      _notes = notes;
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _notesSubscription.cancel();
    super.dispose();
  }
}
