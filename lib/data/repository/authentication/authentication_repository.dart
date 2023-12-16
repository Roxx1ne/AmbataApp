import 'dart:async';

import '../../model/authentication_status.dart';

abstract class AuthenticationRepository {

  Stream<AuthenticationStatus> get status;

  Future<void> logIn({
    required String username,
    required String password,
  });

  void logOut();

  void dispose();
}
