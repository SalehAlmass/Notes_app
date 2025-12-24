import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final IconButton? icon;
  const CustomAppbar({
    super.key, required this.title, this.icon,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: icon,
      title: Text(title),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10, top: 5),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Color(0xFF3C3C3C),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
