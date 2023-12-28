part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

final class Unknown extends AuthenticationState {}

final class Unauthenticated extends AuthenticationState {}

final class Authenticated extends AuthenticationState {
  final User user;

  Authenticated({required this.user});
}


