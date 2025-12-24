import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:note_app/cubits/add_note_cubit/add_notes_cubit.dart';
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
      body: NoteCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: BlocConsumer<AddNotesCubit, AddNotesState>(
                  listener: (context, state) {
                    if (state is AddNoteFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add note')),
                      );
                      print("object");
                    } else if (state is AddNoteSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Note added successfully')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return ModalProgressHUD(
                      inAsyncCall: state is AddNoteLoading ? true : false,
                      child: AddNotes(),
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
