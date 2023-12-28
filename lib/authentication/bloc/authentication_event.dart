part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class _AuthenticationUserChanged extends AuthenticationEvent {
  const _AuthenticationUserChanged(this.user);

  final User user;
}

final class AuthenticationSignOutRequested extends AuthenticationEvent {}
