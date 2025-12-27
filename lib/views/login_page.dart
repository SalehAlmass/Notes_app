import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/widgets/custom_text.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custombutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const primaryColor = Color(0xFF3F3D9D);
  static const backgroundColor = Color(0xFFF7F8FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: 'تسجيل الدخول',
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'مرحباً بك 👋',
                textAlign: TextAlign.center,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              const SizedBox(height: 8),
             CustomText(
                text: 'سجل دخولك للمتابعة',
                textAlign: TextAlign.center,
                fontSize: 14,
                
                color: Colors.black,
              ),
              const SizedBox(height: 32),

              /// Email
              AuthTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: _emailController,
                hintText: 'البريد الإلكتروني',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'البريد الإلكتروني غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              /// Password
              AuthTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: _passwordController,
                hintText: 'كلمة المرور',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور';
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              /// Button + Loading
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: primaryColor,
                        content: Text(state.message),
                      ),
                    );
                    Navigator.pushReplacementNamed(context, '/notes');
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator(color: primaryColor);
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'تسجيل الدخول',
                      backgroundColor: primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            _emailController.text.trim(),
                            _passwordController.text,
                          );
                        }
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// Register
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'لا تملك حساب؟ سجل الآن',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
