import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textStyle,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      validator: widget.validator,
      style: widget.textStyle ??
          const TextStyle(
            color: Color(0xFF3F3D9D),
            fontSize: 16,
          ),
      cursorColor: const Color(0xFF3F3D9D),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        /// 👁️ زر إظهار / إخفاء كلمة المرور
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
