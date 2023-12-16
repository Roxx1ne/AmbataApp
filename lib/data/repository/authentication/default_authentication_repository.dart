import 'dart:async';

import 'package:ambataapp/data/repository/authentication/authentication_repository.dart';

import '../../model/authentication_status.dart';

class DefaultAuthenticationRepository extends AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    yield AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  @override
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  @override
  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() => _controller.close();
}
