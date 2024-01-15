import 'package:application_suivi_des_travaux/models/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/note.dart';
import '../repositories/preferences_repository.dart';

class NotesCubit extends Cubit<NotesState> {
  final PreferencesRepository preferencesRepository;

  /// Constructeur + initialisation du Cubit avec une liste de notes
  NotesCubit(this.preferencesRepository) : super(NotesState([], null));

  /// Méthode pour charger la liste de travaux
  Future<void> loadNotes() async {
    final List<Note> notes = await preferencesRepository.loadAllNotes();
    final Note note = notes.first;
    NotesState notesState = NotesState(notes, note);
    emit(notesState);
  }

  Future<void> loadNote(int id) async {
    final List<Note> notes = await preferencesRepository.loadAllNotes();
    final Note note = notes[id];
    NotesState notesState = NotesState(notes, note);
    emit(notesState);
  }

  void addNote(Note note) {
    preferencesRepository.saveNote(note);
  }

  void addNotes(List<Note> notes) {
    preferencesRepository.saveNotes(notes);
  }
}
