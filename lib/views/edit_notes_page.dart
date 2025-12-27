import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/edit_note_cubit/edit_note_cubit.dart';
import 'package:note_app/cubits/show_notes_cubit/show_notes_cubit.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:note_app/widgets/custom_appbar.dart';
import 'package:note_app/widgets/custom_textbox.dart';
import 'package:note_app/widgets/custombutton.dart';

class EditNotesPage extends StatefulWidget {
  final NotesModel note;

  const EditNotesPage({super.key, required this.note});

  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, description;

  @override
  void initState() {
    super.initState();
    // تعيين القيم الحالية للـ onsaved
    title = widget.note.title;
    description = widget.note.description;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formstate,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            title: "Edit Notes",
            icon: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 25),
                CustomTextBox(
                  text: widget.note.title,
                  onsaved: (value) {
                    title = value;
                  },
                ),
                SizedBox(height: 15),
                CustomTextBox(
                  text: widget.note.description,
                  line: 7,
                  onsaved: (value) {
                    description = value;
                  },
                ),
                SizedBox(height: 80),
                BlocProvider(
                  create: (context) => EditNoteCubit(),
                  child: BlocConsumer<EditNoteCubit, EditNoteState>(
                    listener: (context, state) {
                      if (state is EditNoteSuccess) {
                        // تحديث قائمة الملاحظات
                        context.read<NotesCubit>().fetchNotes();

                        // الرجوع للصفحة السابقة بعد الحفظ
                        Navigator.of(context).pop();
                      } else if (state is EditNoteFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update note')),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Save Note',
                        onPressed: () {
                          if (formstate.currentState!.validate()) {
                            formstate.currentState!.save();

                            // تعديل بيانات الملاحظة
                            widget.note.title = title!;
                            widget.note.description = description!;
                            widget.note.date = DateTime.now();
                            // استدعاء Cubit لحفظ التعديلات
                            context.read<EditNoteCubit>().editNote(widget.note);
                            // ❌ لا تفعل Navigator.pop() هنا
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
