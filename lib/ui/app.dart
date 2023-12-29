import 'package:ambataapp/data/repository/authentication/default_authentication_repository.dart';
import 'package:ambataapp/data/repository/pastry/pastry_repository.dart';
import 'package:ambataapp/ui/screen/account/account_screen.dart';
import 'package:ambataapp/ui/screen/account/recent_transaction.dart';
import 'package:ambataapp/ui/screen/cart/cart_screen.dart';
import 'package:ambataapp/ui/screen/cart/cubit/cart_cubit.dart';
import 'package:ambataapp/ui/screen/detail/detail_screen.dart';
import 'package:ambataapp/ui/screen/home/cubit/home_cubit.dart';
import 'package:ambataapp/ui/screen/home/home_screen.dart';
import 'package:ambataapp/ui/screen/notification/notification_screen.dart';
import 'package:ambataapp/ui/screen/search/cubit/search_cubit.dart';
import 'package:ambataapp/ui/screen/search/filter.dart';
import 'package:ambataapp/ui/screen/search/search_screen.dart';
import 'package:ambataapp/ui/screen/signin/cubit/signin_cubit.dart';
import 'package:ambataapp/ui/screen/signin/signin_screen.dart';
import 'package:ambataapp/ui/screen/signup/cubit/signup_cubit.dart';
import 'package:ambataapp/ui/screen/signup/signup_screen.dart';
import 'package:ambataapp/ui/screen/splash/splash_screen.dart';
import 'package:ambataapp/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../authentication/authentication.dart';
 import '../data/repository/authentication/authentication_repository.dart';
import '../data/repository/cart/cart_repository.dart';
import '../data/repository/cart/default_cart_repository.dart';
import '../data/repository/pastry/default_pastry_repository.dart';
import 'component/root.dart';

part 'navigation.dart';

class AmbataApp extends StatefulWidget {
  const AmbataApp({super.key});

  @override
  State<AmbataApp> createState() => _AmbataAppState();
}

class _AmbataAppState extends State<AmbataApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final DefaultPastryRepository _pastryRepository;
  late final DefaultCartRepository _cartRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = DefaultAuthenticationRepository();
    _pastryRepository = DefaultPastryRepository();
    _cartRepository = DefaultCartRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => _authenticationRepository,
        ),
        RepositoryProvider<PastryRepository>(
          create: (_) => _pastryRepository,
        ),
        RepositoryProvider<CartRepository>(
          create: (_) => _cartRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => HomeCubit(_pastryRepository),
          ),
          BlocProvider(
            create: (_) => SearchCubit(_pastryRepository, SearchFilter()),
          ),
          BlocProvider(
            create: (_) => CartCubit(_cartRepository),
          ),
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
      theme: theme,
      routerConfig: router,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state) {
              case Authenticated():
                router.goNamed('home');
                break;
              case Unauthenticated():
                router.goNamed('sign_in');
                break;
              case Unknown():
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
