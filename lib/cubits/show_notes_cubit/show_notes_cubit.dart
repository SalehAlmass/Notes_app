import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_state.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  Future<void> fetchNotes() async {
    emit(NotesLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String? currentUserId = prefs.getString('user_id');
      
      if (currentUserId == null) {
        emit(NotesFailure('الرجاء تسجيل الدخول أولاً'));
        return;
      }

      var notesBox = Hive.box<NotesModel>('notes_box');
      // تصفية الملاحظات حسب المستخدم الحالي
      List<NotesModel> notes = notesBox.values.where((note) => note.userId == currentUserId).toList();
      notes.sort((a, b) => b.date.compareTo(a.date)); // ترتيب حسب التاريخ
      emit(NotesSuccess(notes));
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }
}
