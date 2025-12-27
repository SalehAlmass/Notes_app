import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.decoration, this.height,
  });
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        decoration: decoration,       
      ),
    );
  }
}
