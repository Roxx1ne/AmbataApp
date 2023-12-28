part of 'app.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum TopLevelDestinations {
  home(path: '/home'),
  search(path: '/search'),
  account(path: '/account');

  const TopLevelDestinations({
    required this.path,
  });

  final String path;
}

final router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      name: 'sign_in',
      path: '/sign/in',
      builder: (context, state) => BlocProvider(
        create: (_) =>
            SignInCubit(context.read<AuthenticationRepository>()),
        child: SignInScreen(),
      ),
      routes: [
        GoRoute(
          name: 'sign_up',
          path: 'sign/up',
          builder: (context, state) => BlocProvider(
            create: (_) =>
                SignUpCubit(context.read<AuthenticationRepository>()),
            child: SignUpScreen(),
          ),
          parentNavigatorKey: _rootNavigatorKey,
        ),
      ],
      parentNavigatorKey: _rootNavigatorKey,
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AmbataScaffold(
        bottomNavigationBar: AmbataBottomNavigationBar(
          onDestinationSelected: (index) {
            GoRouter.of(context)
                .goNamed(TopLevelDestinations.values[index].name);
          },
        ),
        child: child,
      ),
      routes: [
        GoRoute(
          name: TopLevelDestinations.home.name,
          path: TopLevelDestinations.home.path,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) {
                final String id = state.pathParameters['id'] ?? '0';

                return DetailScreen(
                  id: int.parse(id),
                );
              },
              parentNavigatorKey: _shellNavigatorKey,
            ),
            GoRoute(
              path: 'cart',
              builder: (context, state) => const CartScreen(),
              parentNavigatorKey: _shellNavigatorKey,
            ),
          ],
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          name: TopLevelDestinations.search.name,
          path: TopLevelDestinations.search.path,
          builder: (context, state) => const SearchScreen(),
          routes: [
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) {
                final String id = state.pathParameters['id'] ?? '0';

                return DetailScreen(
                  id: int.parse(id),
                );
              },
              parentNavigatorKey: _shellNavigatorKey,
            ),
          ],
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          name: TopLevelDestinations.account.name,
          path: TopLevelDestinations.account.path,
          builder: (context, state) => const AccountScreen(),
          parentNavigatorKey: _shellNavigatorKey,
        ),
      ],
    ),
  ],
);
