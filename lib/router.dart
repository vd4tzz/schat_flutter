import 'package:go_router/go_router.dart';
import 'ui/splash/splash_screen.dart';
import 'ui/auth/view/welcome_screen.dart';
import 'ui/auth/view/login_screen.dart';
import 'ui/auth/view/register_screen.dart';
import 'ui/auth/view/otp_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash',   builder: (_, _) => const SplashScreen()),
    GoRoute(path: '/welcome',  builder: (_, _) => const WelcomeScreen()),
    GoRoute(path: '/login',    builder: (_, _) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
    GoRoute(
      path: '/verify',
      builder: (_, state) => OtpScreen(
        email: state.uri.queryParameters['email'] ?? '',
        expireSeconds: int.tryParse(
              state.uri.queryParameters['expire'] ?? '',
            ) ??
            120,
      ),
    ),
  ],
);
