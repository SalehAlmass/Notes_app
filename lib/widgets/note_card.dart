import 'package:flutter/material.dart';
import 'package:note_app/viwes/edit_notes_page.dart';
import 'package:note_app/widgets/custom_list_title.dart';
import 'package:note_app/widgets/custom_text.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
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
                        title: 'Note ${index + 1}',
                        subtitle: 'This is note number ${index + 1}',
                      ),
                      SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 15),
                        child: CustomText(text: 'Note ${index + 1}'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
