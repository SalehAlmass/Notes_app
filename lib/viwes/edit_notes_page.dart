import 'package:flutter/material.dart';
import 'package:note_app/viwes/note_page.dart';
import 'package:note_app/widgets/custom_appbar.dart';
import 'package:note_app/widgets/custom_textbox.dart';
import 'package:note_app/widgets/custombutton.dart';

class EidtNotesPage extends StatelessWidget {
  const EidtNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          title: "Edit Notes",
          icon: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NotesPage())
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 25),
                CustomTextBox(text: 'Enter your title'),
                SizedBox(height: 15),
                CustomTextBox(text: 'Enter your description', line: 7),
                SizedBox(height: 80),
                CustomButton(text: 'Save Note', onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}

