import 'package:flutter/material.dart';
import 'package:note_app/widgets/custom_text.dart';
import 'package:note_app/widgets/custombutton.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Image.asset(
                  'assets/images/jop.png', // ضع الصورة هنا
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 100),

              /// Title
              const CustomText(
                text: 'Notes App',
                fontSize: 35,
                color: Color(0xFF3F3D9D),
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              const CustomText(
                text:
                    'Explore all the existing job roles based on your interest and study major',
                textAlign: TextAlign.center,
                fontSize: 14,
                color: Colors.black,
              ),

              const SizedBox(height: 100),

              /// Description

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'تسجيل الدخول',
                      backgroundColor: const Color(0xFF3F3D9D),
                      borderRadius: 16,
                      elevation: 8,
                      height: 55,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      text: 'إنشاء حساب' ,
                      textColor: Colors.black,
                      backgroundColor: Colors.white,
                      borderRadius: 16,
                      elevation: 8,
                      height: 55,               
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                    })
                    )
                ],
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
