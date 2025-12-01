import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/note_controller.dart';
import '../models/note.dart';
import 'note_edit_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final NoteController _controller = NoteController();
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    _notesFuture = _controller.fetchNotes();
    setState(() {});
  }

  Future<void> _navigateToEdit({Note? note}) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => NoteEditScreen(note: note)),
    );
    if (changed == true) _loadNotes();
  }

  Future<void> _deleteNoteConfirm(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete note?'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed == true) {
      await _controller.deleteNote(id);
      _loadNotes();
    }
  }

  String _formatDate(String dateString) {
    try {
      final parsed = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy hh:mm a').format(parsed);
    } catch (_) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final notes = snapshot.data ?? [];
          if (notes.isEmpty) {
            return const Center(child: Text('No nodes found.'));
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, idx) {
              final n = notes[idx];
              return ListTile(
                title: Text(n.title),
                subtitle: Text(_formatDate(n.date)),
                onTap: () => _navigateToEdit(note: n),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    if (n.id != null) _deleteNoteConfirm(n.id!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEdit(),
        child: const Icon(Icons.add_task),
      ),
    );
  }
}