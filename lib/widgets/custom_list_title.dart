import 'package:flutter/material.dart';
import 'package:note_app/widgets/custom_text.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key, required this.title, required this.subtitle,
  });
  final String title;
  final String subtitle;
  


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: CustomText(text: title),
      ),
    
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 10),
        child: CustomText(
          text: subtitle,
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.black,
            size: 30,
          ),
          color: Colors.black,
          onPressed: () {},
        ),
      ),
    );
  }
}
