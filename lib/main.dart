import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:note_app/models/notes_model.dart';
import 'package:note_app/services/auth_service.dart';
import 'package:note_app/views/login_page.dart';
import 'package:note_app/views/note_page.dart';
import 'package:note_app/views/register_page.dart';
import 'package:note_app/views/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes_box');
  runApp(const NoteApp());
}
class NoteApp extends StatelessWidget {
  const NoteApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthService(),
      child: BlocProvider(
        create: (context) => AuthCubit()..checkAuthStatus(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: _getHomeScreen(authState),
              routes: {
                '/login': (context) => const LoginPage(),
                '/register': (context) => const RegisterPage(),
                '/notes': (context) => const NotesPage(),
              },
            );
          },
        ),
      ),
    );
  }

  Widget _getHomeScreen(AuthState authState) {
    if (authState is Authenticated) {
      return const NotesPage();
    } else if (authState is Unauthenticated || authState is AuthLoggedOut) {
      return const WelcomePage();
    } else {
      // في البداية نعرض شاشة التحميل
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
