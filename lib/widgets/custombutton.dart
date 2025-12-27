import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.height,
  });

  final String text;
  final VoidCallback onPressed;

  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? elevation;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF3F3D9D),
          padding:
              padding ?? const EdgeInsets.symmetric(vertical: 14),
          elevation: elevation ?? 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 16,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
