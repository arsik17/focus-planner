import 'package:flutter/material.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/shared/cubits/user/user_state.dart';
import 'package:focus_planner/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:focus_planner/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final UserCubit userCubit;

  AppRouter({required this.userCubit});

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(userCubit.stream),
    redirect: (context, state) {
      final isLoggedIn = userCubit.state is UserLoggedIn;
      final isAuthRoute = state.matchedLocation == '/sign-in' ||
          state.matchedLocation == '/sign-up';

      if (!isLoggedIn && !isAuthRoute) return '/sign-in';
      if (isLoggedIn && isAuthRoute) return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const _PlaceholderHomeScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}

class _PlaceholderHomeScreen extends StatelessWidget {
  const _PlaceholderHomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Focus Planner')),
      body: const Center(child: Text('Home Screen')),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
