part of 'edit_note_cubit.dart';


abstract class EditNoteState {}

class EditNoteInitial extends EditNoteState {}

class EditNoteLoading extends EditNoteState {}

class EditNoteSuccess extends EditNoteState {}

class EditNoteFailure extends EditNoteState {
  final String errMessage;
  EditNoteFailure(this.errMessage);
}
