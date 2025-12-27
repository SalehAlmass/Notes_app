import 'package:bloc/bloc.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit() : super(EditNoteInitial());

  Future<void> editNote(NotesModel note) async {
    emit(EditNoteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String? currentUserId = prefs.getString('user_id');
      
      if (currentUserId == null) {
        emit(EditNoteFailure('الرجاء تسجيل الدخول أولاً'));
        return;
      }
      
      // التحقق من أن الملاحظة تخص المستخدم الحالي
      if (note.userId != currentUserId) {
        emit(EditNoteFailure('لا يمكنك تعديل هذه الملاحظة'));
        return;
      }
      
      await note.save(); // ✅ تعديل الملاحظة نفسها
      emit(EditNoteSuccess());
    } catch (e) {
      emit(EditNoteFailure(e.toString()));
    }
  }
}
