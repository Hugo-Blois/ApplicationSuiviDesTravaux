import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.dart';

class PreferencesRepository {
  Future<void> saveNotes(List<Note> notes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listJson = [];

    for (final Note note in notes) {
      listJson.add(jsonEncode(note.toJson()));
    }
    prefs.setStringList('notes', listJson);
  }

  Future<void> saveNote(Note note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> existingNotes = prefs.getStringList('notes') ?? [];

    existingNotes.add(jsonEncode(note.toJson()));

    prefs.setStringList('notes', existingNotes);
  }

  Future<Note?> loadNote(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Note? note;

    final listJson = prefs.getStringList('notes') ?? [];
    for (final String json in listJson) {
      note = Note.fromJson(jsonDecode(json));
      if (note.id == id) {
        return note;
      }
    }
    return null;
  }

  Future<List<Note>> loadAllNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Note> notes = [];

    final listJson = prefs.getStringList('notes') ?? [];
    for (final String json in listJson) {
      final note = Note.fromJson(jsonDecode(json));
      notes.add(note);
    }

    return notes;
  }
}
