import 'package:ambataapp/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../authentication/authentication.dart';
import '../data/model/authentication_status.dart';
import '../data/repository/authentication_repository.dart';
import '../data/repository/user_repository.dart';

part 'navigation.dart';

class AmbataApp extends StatefulWidget {
  const AmbataApp({super.key});

  @override
  State<AmbataApp> createState() => _AmbataAppState();
}

class _AmbataAppState extends State<AmbataApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
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

class AmbataScaffold extends StatefulWidget {
  const AmbataScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _AmbataScaffoldState();
}

class _AmbataScaffoldState extends State<AmbataScaffold> {
  final routes = ['home', 'search', 'account'];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.surface;
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bar'),
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: NavigationBar(
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
          setState(() {
            currentPageIndex = index;
            GoRouter.of(context).goNamed(routes[index]);
          });
        },
      ),
      body: widget.child,
    );
  }
}
