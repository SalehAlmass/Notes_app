import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/add_note_cubit/add_notes_cubit.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:note_app/widgets/custom_textbox.dart';
import 'package:note_app/widgets/custombutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subtitle;

  // 🔹 إضافة اختيار اللون
  int selectedColor = Colors.amberAccent.value;
  List<Color> colors = [
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.tealAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formstate,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 25),

              // Title
              CustomTextBox(

                text: 'Enter your title',
                onsaved: (value) {
                  title = value;
                },
                textStyle: const TextStyle(fontSize: 20 ,
                color: Colors.black),
                
              ),
              const SizedBox(height: 15),

              // Description
              CustomTextBox(
                text: 'Enter your description',
                line: 7,
                onsaved: (value) {
                  subtitle = value;
                },
                textStyle: const TextStyle(fontSize: 20 ,
                color: Colors.black),
              ),
              const SizedBox(height: 20),

              // 🔹 اختيار اللون
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = colors[index].value;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[index],
                          border: selectedColor == colors[index].value
                              ? Border.all(
                                  color: Colors.black,
                                  width: 3,
                                )
                              : null,
                        ),
                        width: 40,
                        height: 40,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              // زر حفظ الملاحظة
              CustomButton(
                onPressed: () async {
                  if (formstate.currentState!.validate()) {
                    formstate.currentState!.save();

                    // الحصول على معرف المستخدم من SharedPreferences
                    final prefs = await SharedPreferences.getInstance();
                    String? currentUserId = prefs.getString('user_id');
                    
                    if (currentUserId == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('الرجاء تسجيل الدخول أولاً')),
                        );
                      }
                      return;
                    }
                    
                    var notes_model = NotesModel(
                      title: title!,
                      description: subtitle!,
                      date: DateTime.now(), // تاريخ الإضافة
                      color: selectedColor, // اللون المختار
                      userId: currentUserId,
                    );

                    if (context.mounted) {
                      BlocProvider.of<AddNotesCubit>(context).addNote(notes_model);
                    }
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
