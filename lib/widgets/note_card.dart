import 'package:flutter/material.dart';
import 'package:note_app/viwes/edit_notes_page.dart';
import 'package:note_app/widgets/custom_list_title.dart';
import 'package:note_app/widgets/custom_text.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    
        return Column(
          children: [
            SingleChildScrollView(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => EidtNotesPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  height: 200,
                  width: 400,
                  child: Card(
                    color: Colors.yellow,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomListTitle(
                          title: title,
                          subtitle: subtitle,
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 15),
                          child: CustomText(text: 'Note'),
                        ),
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
