part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

final class SignUpState extends Equatable {
  SignUpState({
    this.email = '',
    this.password = '',
    this.confirmedPassword = '',
    this.errorMessage,
  }) {
    _isValid = _validateSignUp();
  }

  final String email;
  final String password;
  final String confirmedPassword;
  late final bool _isValid;
  late final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        errorMessage,
      ];

  bool get isValid => _isValid;

  SignUpState copyWith({
    String? email,
    String? password,
    String? confirmedPassword,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool _validateSignUp() =>
      (Validator.isValidEmail(email) && Validator.isValidPassword(password)) &&
      (password == confirmedPassword);
}
