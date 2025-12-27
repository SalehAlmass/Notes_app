import 'package:flutter/material.dart';
import 'package:note_app/widgets/custom_text.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    this.onpressed,
  });

  final String title;
  final String subtitle;
  final String date;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 44, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// العنوان
              CustomText(
                text: title,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),

              const SizedBox(height: 8),

              /// الوصف
              CustomText(
                text: subtitle,
                fontSize: 16,
                color: Colors.black,
              ),

              const SizedBox(height: 12),

              /// 📅 التاريخ (أسفل يمين بدون تخريب الشكل)
              Align(
                alignment: Alignment.bottomRight,
                child: CustomText(
                  text: date,
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),

        /// أيقونة الحذف
        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            icon: const Icon(
              Icons.delete_outline,
              size: 22,
              color: Colors.black54,
            ),
            onPressed: onpressed,
          ),
        ),
      ],
    );
  }
}
