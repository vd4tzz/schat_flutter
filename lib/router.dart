import 'package:go_router/go_router.dart';
import 'ui/splash/splash_screen.dart';
import 'ui/auth/view/login_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
  ],
);
