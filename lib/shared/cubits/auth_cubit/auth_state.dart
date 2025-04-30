part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//* Register//
final class RegisterLoading extends AuthState {}
final class RegisterSuccessfully extends AuthState {
  final String token;
  RegisterSuccessfully(this.token);
}
final class RegisterWithError extends AuthState {
  final String message;
  RegisterWithError(this.message);
}


//* Login//
final class LoginLoading extends AuthState {}
final class LoginSuccessfully extends AuthState {
  final String token;
  LoginSuccessfully(this.token);
}
final class LoginWithError extends AuthState {
final String message;
LoginWithError(this.message);
}
