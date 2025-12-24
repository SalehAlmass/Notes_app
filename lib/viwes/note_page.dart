import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:note_app/cubits/add_note_cubit/add_notes_cubit.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_cubit.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_state.dart';
import 'package:note_app/widgets/add_notes.dart';
import 'package:note_app/widgets/custom_appbar.dart';
import 'package:note_app/widgets/note_card.dart';
import 'package:bloc/bloc.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // ThemeMode _themeMode = ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: 'Notes',
          // icon:IconButton(onPressed: (){
          //   setState(() {
          //     _themeMode =
          //         _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
          //   });
          // },
          // icon: Icon(Icons.brightness_6))
        ),
      ),
      /* body: BlocProvider(
        create: (context) => NotesCubit(),
        child: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NotesFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Failed to get notes')));
              print("Failed ${state.errMessage}");
            } else if (state is NotesSuccess) {
              print("Success");
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is NotesLoading ? true : false,
              child: 
              if(state is NotesSuccess){
                ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return NoteCard(title: note.title, subtitle: note.subtitle);
                  },
                )
              }
              
            );
          },
        ),
      ),*/
      body: BlocProvider(
        create: (context) => NotesCubit()..fetchNotes(),
        child: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NotesFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to get notes')),
              );
              print("Failed ${state.errMessage}");
            }
            else if(state is NotesSuccess){
              setState(() {
                
              });
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is NotesLoading,
              child: Builder(
                builder: (context) {
                  if (state is NotesSuccess) {
                    if (state.notes.isEmpty) {
                      return const Center(child: Text('لا توجد ملاحظات'));
                    }
                    return ListView.builder(
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        final note = state.notes[index];
                        return NoteCard(
                          title: note.title,
                          subtitle: note.description,
                        );
                      },
                    );
                  } else if (state is NotesFailure) {
                    return Center(child: Text(state.errMessage));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => AddNotesCubit(),
                child: BlocConsumer<AddNotesCubit, AddNotesState>(
                  listener: (context, state) {
                    if (state is AddNoteFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add note')),
                      );
                      print("Failed${state.errMessage}");
                    } else if (state is AddNoteSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Note added successfully')),
                      );
                      Navigator.pop(context);
                      setState(() {
                        
                      });
                    }
                  },
                  builder: (context, state) {
                    return ModalProgressHUD(
                      inAsyncCall: state is AddNoteLoading ? true : false,
                      child: SingleChildScrollView(child: AddNotes()),
                    );
                  },
                ),
              );
            },
          );
        },
        backgroundColor: Color.fromARGB(255, 0, 236, 215),
        child: Icon(Icons.add, size: 30, color: Colors.black),
      ),
    );
  }
}
