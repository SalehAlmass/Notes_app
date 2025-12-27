import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final IconButton? icon;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  const CustomAppbar({
    super.key, required this.title, this.icon, this.actions, this.backgroundColor, this.titleColor,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor, 
      leading: icon,
      titleTextStyle: TextStyle(color: titleColor),
      title: Center(
        child: Text(title , style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        ) ,
        ),
      ),
      actions: actions ?? [
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
