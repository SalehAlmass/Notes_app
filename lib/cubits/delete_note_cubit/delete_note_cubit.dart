import 'package:bloc/bloc.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit() : super(DeleteNoteInitial());

  Future<void> deleteNote(NotesModel note) async {
    emit(DeleteNoteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String? currentUserId = prefs.getString('user_id');
      
      if (currentUserId == null) {
        emit(DeleteNoteFailure('الرجاء تسجيل الدخول أولاً'));
        return;
      }
      
      // التحقق من أن الملاحظة تخص المستخدم الحالي
      if (note.userId != currentUserId) {
        emit(DeleteNoteFailure('لا يمكنك حذف هذه الملاحظة'));
        return;
      }
      
      await note.delete(); // حذف النوت من Hive
      emit(DeleteNoteSuccess());
    } catch (e) {
      emit(DeleteNoteFailure(e.toString()));
    }
  }
}
