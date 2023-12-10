part of 'app.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

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
      builder: (context, state) => const Center(
        child: Text('Sign In'),
      ),
      routes: [
        GoRoute(
            name: 'sign_up',
            path: 'sign/up',
            builder: (context, state) => const Center(
                  child: Text('Sign Up'),
                ),
            parentNavigatorKey: _rootNavigatorKey),
      ],
      parentNavigatorKey: _rootNavigatorKey,
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AmbataScaffold(child: child),
      routes: [
        GoRoute(
          name: 'home',
          path: '/home',
          builder: (context, state) => Center(
              child: Column(
            children: [
              const Text('Home'),
              ElevatedButton(
                onPressed: () {
                  context.goNamed('detail', pathParameters: {'id': '1'});
                },
                child: const Text('Detail'),
              ),
            ],
          )),
          routes: [
            GoRoute(
              name: 'detail',
              path: 'detail/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '0';

                return Center(
                  child: Text(id),
                );
              },
              parentNavigatorKey: _rootNavigatorKey,
            ),
          ],
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          name: 'search',
          path: '/search',
          builder: (context, state) => const Center(
            child: Text('Search'),
          ),
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          name: 'account',
          path: '/account',
          builder: (context, state) => const Center(
            child: Text('Account'),
          ),
          parentNavigatorKey: _shellNavigatorKey,
        ),
      ],
    ),
  ],
);
