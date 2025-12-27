import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:note_app/cubits/add_note_cubit/add_notes_cubit.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_cubit.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_state.dart';
import 'package:note_app/widgets/add_notes.dart';
import 'package:note_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:note_app/widgets/custom_appbar.dart';
import 'package:note_app/widgets/note_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  static const primaryColor = Color(0xFF3F3D9D);
  static const backgroundColor = Color(0xFFF7F8FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      /// AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppbar(
          title: 'Notes',
          backgroundColor: backgroundColor,
          titleColor: primaryColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: primaryColor),
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
            ),
          ],
        ),
      ),

      /// Body
      body: BlocProvider(
        create: (_) => NotesCubit()..fetchNotes(),
        child: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NotesFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errMessage),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (state is NotesSuccess) {
              if (state.notes.isEmpty) {
                return const Center(
                  child: Text(
                    'لا توجد ملاحظات',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return NoteCard(
                    note: note,
                    title: note.title,
                    subtitle: note.description,
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),

      /// FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: backgroundColor,
            isScrollControlled: true,
            context: context,
            builder: (bottomSheetContext) {
              return BlocProvider(
                create: (_) => AddNotesCubit(),
                child: BlocConsumer<AddNotesCubit, AddNotesState>(
                  listener: (context, state) {
                    if (state is AddNoteFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.errMessage),
                        ),
                      );
                    } else if (state is AddNoteSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: primaryColor,
                          content: Text('تمت إضافة الملاحظة بنجاح'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return ModalProgressHUD(
                      inAsyncCall: state is AddNoteLoading,
                      child: const SingleChildScrollView(
                        child: AddNotes(),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
