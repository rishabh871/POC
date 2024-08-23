
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class LoginValidationError extends LoginState {
  final String? emailError;
  final String? passwordError;

  LoginValidationError({this.emailError, this.passwordError});
}