import 'package:ambataapp/authentication/validator.dart';
import 'package:ambataapp/data/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../authentication/authentication_exception.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository) : super(SignInState());

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

  void errorMessageShowed() {
    emit(
      state.copyWith(
        errorMessage: null,
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!state.isValid) return;
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
    } on SignInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _authenticationRepository.signInWithGoogle();
    } on SignInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
        ),
      );
    }
  }
}
