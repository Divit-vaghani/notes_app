import 'package:flutter/material.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/note_model/note_model.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/services/firestore_service.dart';
import 'package:notes_app/utils/notes_toast.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;

  const NoteDialog({super.key, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // 🆕 Pre-fill fields if editing a note
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _messageController.text = widget.note!.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🆕 Check if we are editing or adding
    final isEditing = widget.note != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Note' : 'Add Note'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              validator: (value) => value!.trim().isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
              validator: (value) => value!.trim().isEmpty ? 'Please enter a message' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final firestoreService = getIt<FirestoreService>();
              try {
                if (isEditing) {
                  // 🆕 Call updateNote if editing
                  await firestoreService.updateNote(
                    id: widget.note!.id,
                    title: _titleController.text,
                    message: _messageController.text,
                  );
                } else {
                  // Call addNote if adding a new one
                  await firestoreService.addNote(
                    title: _titleController.text,
                    message: _messageController.text,
                  );
                }
                router.pop();
              } catch (e) {
                NotesToast.instance.errorToast(toast: "Failed to save note: $e");
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
