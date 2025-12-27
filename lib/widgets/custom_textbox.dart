import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    super.key, required this.text, this.line, this.onsaved, this.textStyle,
  });
  final String text;
  final int? line;
 final TextStyle? textStyle;
  final void Function(String?)? onsaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,     
      onSaved: onsaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        else if (value.length < 3) {
          return 'Please enter at least 3 characters';
        }
        return null;
      },
      maxLines: line,                        
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: text,
      ),
    );
  }
}
