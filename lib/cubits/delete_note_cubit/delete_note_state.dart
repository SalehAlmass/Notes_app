part of 'delete_note_cubit.dart';

abstract class DeleteNoteState {}

class DeleteNoteInitial extends DeleteNoteState {}

class DeleteNoteLoading extends DeleteNoteState {}

class DeleteNoteSuccess extends DeleteNoteState {}

class DeleteNoteFailure extends DeleteNoteState {
  final String errMessage;
  DeleteNoteFailure(this.errMessage);
}
