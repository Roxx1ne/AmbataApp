import 'package:ambataapp/authentication/validator.dart';
import 'package:ambataapp/data/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../authentication/authentication_exception.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmedPassword: value,
      ),
    );
  }

  void errorMessageShowed() {
    emit(
      state.copyWith(
        errorMessage: null,
      ),
    );
  }

  Future<void> signUp() async {
    if (!state.isValid) return;
    try {
      await _authenticationRepository.signUp(
        email: state.email,
        password: state.password,
      );
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
        ),
      );
    }
  }
}
