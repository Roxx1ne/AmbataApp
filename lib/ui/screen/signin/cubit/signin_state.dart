part of 'signin_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

final class SignInState extends Equatable {
  SignInState({
    this.email = '',
    this.password = '',
    this.errorMessage,
  }) {
    _isValid = _validateSignIn();
  }

  final String email;
  final String password;
  late final bool _isValid;
  late final String? errorMessage;

  @override
  List<Object?> get props =>
      [
        email,
        password,
        errorMessage,
      ];

  bool get isValid => _isValid;

  SignInState copyWith({
    String? email,
    String? password,
    String? confirmedPassword,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool _validateSignIn() =>
      Validator.isValidEmail(email) && Validator.isValidPassword(password);
}
