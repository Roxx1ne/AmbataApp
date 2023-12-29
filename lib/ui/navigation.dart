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
        create: (_) => SignInCubit(context.read<AuthenticationRepository>()),
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
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: HomeScreen(),
            );
          },
          routes: [
            GoRoute(
              path: 'detail/:id',
              pageBuilder: (context, state) {
                final String id = state.pathParameters['id'] ?? '0';
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: DetailScreen(
                    id: int.parse(id),
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
              parentNavigatorKey: _shellNavigatorKey,
            ),
            GoRoute(
              path: 'cart',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const CartScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
              parentNavigatorKey: _shellNavigatorKey,
            ),
            GoRoute(
              path: 'notification',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const NotificationScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
              parentNavigatorKey: _shellNavigatorKey,
            ),
          ],
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          name: TopLevelDestinations.search.name,
          path: TopLevelDestinations.search.path,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: SearchScreen(),
            );
          },
          routes: [
            GoRoute(
              path: 'detail/:id',
              pageBuilder: (context, state) {
                final String id = state.pathParameters['id'] ?? '0';
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: DetailScreen(
                    id: int.parse(id),
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
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
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: AccountScreen(),
            );
          },
          routes: [
            GoRoute(
              path: 'transaction',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: RecentTransactionPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
              parentNavigatorKey: _shellNavigatorKey,
            ),
          ],
          parentNavigatorKey: _shellNavigatorKey,
        ),
      ],
    ),
  ],
);
