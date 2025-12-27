import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'add_notes_state.dart';
class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());
  Future<void> addNote(NotesModel note) async {
    emit(AddNoteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String? currentUserId = prefs.getString('user_id');
      
      if (currentUserId == null) {
        emit(AddNoteFailure('الرجاء تسجيل الدخول أولاً'));
        return;
      }
      
      // إنشاء نموذج ملاحظة جديد مع معرف المستخدم
      NotesModel noteWithUserId = NotesModel(
        title: note.title,
        description: note.description,
        color: note.color,
        date: note.date,
        userId: currentUserId,
      );
      
      var notesBox = Hive.box<NotesModel>('notes_box');
      await notesBox.add(noteWithUserId);
      emit(AddNoteSuccess());
    } catch(e) {
      emit(AddNoteFailure(e.toString()));
    }    
  }
}
