part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  
  AuthSuccess({required this.message});
}

class AuthError extends AuthState {
  final String error;
  
  AuthError({required this.error});
}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthLoggedOut extends AuthState {}