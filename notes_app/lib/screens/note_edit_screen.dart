import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import '../controllers/note_controller.dart';

class NoteEditScreen extends StatefulWidget {
  final Note? note;
  const NoteEditScreen({super.key, this.note});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  final NoteController _controller = NoteController();
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.note != null;
    if (_isEdit) {
      _titleCtrl.text = widget.note!.title;
      _contentCtrl.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final iso = now.toIso8601String();

    final note = Note(
      id: widget.note?.id,
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
      date: iso,
    );

    if (_isEdit) {
      await _controller.updateNote(note);
    } else {
      await _controller.addNote(note);
    }

    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = _isEdit ? 'Edit Node' : 'Add Node';
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TextFormField(
                  controller: _contentCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: null,
                  expands: true,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Content cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}