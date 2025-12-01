import '../helpers/database_helper.dart';
import '../models/note.dart';

class NoteController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Note>> fetchNotes() => _dbHelper.getAllNotes();

  Future<int> addNote(Note note) => _dbHelper.insertNote(note);

  Future<int> updateNote(Note note) => _dbHelper.updateNote(note);

  Future<int> deleteNote(int id) => _dbHelper.deleteNote(id);
}