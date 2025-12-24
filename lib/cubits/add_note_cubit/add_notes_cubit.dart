import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart'
;
import 'package:note_app/models/notes_model.dart';
part 'add_notes_state.dart';
class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());
  addNote(NotesModel note)async{
    emit(AddNoteLoading());
    try{
      var notesBox = Hive.box<NotesModel>('notes_box');
      await notesBox.add(note);
      emit(AddNoteSuccess());
    } catch(e){
      emit(AddNoteFailure(e.toString()));
    }
    
  }
}
