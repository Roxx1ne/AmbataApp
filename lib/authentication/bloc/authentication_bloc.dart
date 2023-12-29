import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../data/model/user.dart';
import '../../data/repository/authentication/authentication_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(Unknown()) {
    on<_AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<AuthenticationSignOutRequested>(_onAuthenticationSignOutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AuthenticationUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  Future<void> _onAuthenticationUserChanged(
    _AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = event.user;
    if (user.isNotEmpty) {
      return emit(Authenticated(user: user));
    } else {
      return emit(Unauthenticated());
    }
  }

  void _onAuthenticationSignOutRequested(
    AuthenticationSignOutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.signOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
