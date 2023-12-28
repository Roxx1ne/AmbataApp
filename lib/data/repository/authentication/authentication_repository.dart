import 'dart:async';

import '../../model/user.dart';

abstract class AuthenticationRepository {

  Stream<User> get user;

  Future<void> signUp({required String email, required String password});

  Future<void> signInWithGoogle();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  void signOut();
}
