import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_state.dart';
import 'package:note_app/models/notes_model.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  fetchNotes() {
    emit(NotesLoading());
    try {
      var notesBox = Hive.box<NotesModel>('notes_box');
      List<NotesModel> notes = notesBox.values.toList();
      emit(NotesSuccess(notes));
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }
}
