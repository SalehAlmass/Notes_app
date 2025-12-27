import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/delete_note_cubit/delete_note_cubit.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_cubit.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:note_app/views/edit_notes_page.dart';
import 'package:note_app/widgets/custom_list_title.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.note,
  });
  final String title;
  final String subtitle;
  final NotesModel note;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => EditNotesPage(note: widget.note),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Card(
              color: Color(widget.note.color), // اللون من الملاحظة
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocProvider(
                      create: (context) => DeleteNoteCubit(),
                      child: BlocConsumer<DeleteNoteCubit, DeleteNoteState>(
                        listener: (context, state) {
                          if (state is DeleteNoteSuccess) {
                            context.read<NotesCubit>().fetchNotes();
                          }
                        },
                        builder: (context, state) {
                          return CustomListTitle(
                            title: widget.title,
                            subtitle: widget.subtitle,
                            date: widget.note.date.toString(),
                            onpressed: () {
                              context.read<DeleteNoteCubit>().deleteNote(
                                widget.note,
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
