import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();
  
  AuthCubit() : super(AuthInitial());

  Future<void> register(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      bool success = await _authService.registerUser(email, password, name);
      if (success) {
        emit(AuthSuccess(message: 'تم إنشاء الحساب بنجاح'));
      } else {
        emit(AuthError(error: 'البريد الإلكتروني مستخدم مسبقاً'));
      }
    } catch (e) {
      emit(AuthError(error: 'حدث خطأ أثناء إنشاء الحساب'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      bool success = await _authService.loginUser(email, password);
      if (success) {
        emit(AuthSuccess(message: 'تم تسجيل الدخول بنجاح'));
      } else {
        emit(AuthError(error: 'البريد الإلكتروني أو كلمة المرور غير صحيحة'));
      }
    } catch (e) {
      emit(AuthError(error: 'حدث خطأ أثناء تسجيل الدخول'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authService.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(error: 'حدث خطأ أثناء تسجيل الخروج'));
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      bool isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }
}