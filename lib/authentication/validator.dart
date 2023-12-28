class Validator {

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static bool isValidEmail(String email) {
    if (email.isNotEmpty) {
      return _emailRegExp.hasMatch(email);
    } else {
      return true;
    }
  }

  static bool isValidPassword(String password) {
    if (password.isNotEmpty) {
      return _passwordRegExp.hasMatch(password);
    } else {
      return true;
    }
  }
}