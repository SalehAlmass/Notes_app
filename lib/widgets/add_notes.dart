import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/add_note_cubit/add_notes_cubit.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:note_app/widgets/custom_textbox.dart';
import 'package:note_app/widgets/custombutton.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formstate,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 25),
              CustomTextBox(
                text: 'Enter your title',
                onsaved: (value) {
                  title = value;
                },
              ),
              SizedBox(height: 15),
              CustomTextBox(
                text: 'Enter your description',
                line: 7,
                onsaved: (value) {
                  subtitle = value;
                },
              ),
              SizedBox(height: 80),
              CustomButton(
                onPressed: () {
                  if (formstate.currentState!.validate()) {
                    formstate.currentState!.save();
                    print(title);
                    print(subtitle);
                    var notes_model = NotesModel(
                      title: title!,
                      description: subtitle!,
                      date: DateTime.now().toString(),
                      color: Colors.amberAccent.value,
                    );
                    BlocProvider.of<AddNotesCubit>(
                      context,
                    ).addNote(notes_model);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: "Add Note",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
