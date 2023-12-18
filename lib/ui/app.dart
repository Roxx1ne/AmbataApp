import 'package:ambataapp/data/repository/authentication/default_authentication_repository.dart';
import 'package:ambataapp/data/repository/cart/cart_repository.dart';
import 'package:ambataapp/data/repository/pastry_repository.dart';
import 'package:ambataapp/ui/screen/home/home_screen.dart';
import 'package:ambataapp/ui/screen/search/search_screen.dart';
import 'package:ambataapp/ui/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../authentication/authentication.dart';
import '../data/model/authentication_status.dart';
import '../data/repository/authentication/authentication_repository.dart';
import '../data/repository/user_repository.dart';
import 'component/root.dart';

part 'navigation.dart';

class AmbataApp extends StatefulWidget {
  const AmbataApp({super.key});

  @override
  State<AmbataApp> createState() => _AmbataAppState();
}

class _AmbataAppState extends State<AmbataApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final DefaultPastryRepository _pastryRepository;
  late final DefaultCartRepository _cartRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = DefaultAuthenticationRepository();
    _userRepository = UserRepository();
    _pastryRepository = DefaultPastryRepository();
    _cartRepository = DefaultCartRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => _authenticationRepository,
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => _userRepository,
        ),
        RepositoryProvider<DefaultPastryRepository>(
          create: (_) => _pastryRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          )
        ],
        child: const AmbataAppRoot(),
      ),
    );
  }
}

class AmbataAppRoot extends StatefulWidget {
  const AmbataAppRoot({super.key});

  @override
  State<StatefulWidget> createState() => _AmbataAppRootState();
}

class _AmbataAppRootState extends State<AmbataAppRoot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ambata Bakery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF914C00)),
        useMaterial3: true,
      ),
      routerConfig: router,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                router.goNamed('home');
                break;
              case AuthenticationStatus.unauthenticated:
                router.goNamed('sign_in');
                break;
              case AuthenticationStatus.unknown:
                router.goNamed('splash');
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}

class AmbataBottomNavigationBar extends StatefulWidget {
  final Function(int) onDestinationSelected;

  const AmbataBottomNavigationBar({
    super.key,
    required this.onDestinationSelected,
  });

  @override
  State<StatefulWidget> createState() => _AmbataBottomNavigationBarState();
}

class _AmbataBottomNavigationBarState extends State<AmbataBottomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Account',
        ),
      ],
      onDestinationSelected: (index) {
        setState(
          () {
            currentPageIndex = index;
            widget.onDestinationSelected(index);
          },
        );
      },
    );
  }
}
