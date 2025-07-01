import 'package:flutter/material.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/note_model/note_model.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/services/firestore_service.dart';
import 'package:notes_app/widget/add_note.dart';
import 'package:notes_app/widget/responsive_layout.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          if (noteProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (noteProvider.notes.isEmpty) {
            return const Center(child: Text("No notes yet. Add one!"));
          }

          return ResponsiveLayout(
            mobileBody: _buildMobileLayout(context, noteProvider.notes),
            tabletBody: _buildTabletLayout(context, noteProvider.notes),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const NoteDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🆕 Helper function for showing menu options
  void _showMenu(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the menu dialog
                  showDialog(
                    context: context,
                    builder: (_) => NoteDialog(note: note), // Open edit dialog
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.of(context).pop(); // Close the menu dialog
                  _showDeleteConfirmation(context, note);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 🆕 Helper function for delete confirmation
  void _showDeleteConfirmation(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note?'),
        content: const Text('Are you sure you want to delete this note? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final firestoreService = getIt<FirestoreService>();
              firestoreService.deleteNote(id: note.id);
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.message, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              // 🆕 Add trailing icon button
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showMenu(context, note),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout(BuildContext context, List<Note> notes) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // 🆕 Wrap title and button in a Row
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => _showMenu(context, note),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(child: Text(note.message)),
              ],
            ),
          ),
        );
      },
    );
  }
}
