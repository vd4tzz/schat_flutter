import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/friendship_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'data/repositories/user_repository.dart';
import 'ui/auth/login_view_model.dart';
import 'ui/auth/register_view_model.dart';
import 'ui/auth/otp_view_model.dart';
import 'ui/home/conversations/inbox_view_model.dart';
import 'ui/home/notifications/notifications_view_model.dart';
import 'ui/home/profile/profile_view_model.dart';
import 'ui/splash/splash_screen.dart';
import 'ui/auth/view/welcome_screen.dart';
import 'ui/auth/view/login_screen.dart';
import 'ui/auth/view/register_screen.dart';
import 'ui/auth/view/otp_screen.dart';
import 'ui/home/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash',  builder: (_, _) => const SplashScreen()),
    GoRoute(path: '/welcome', builder: (_, _) => const WelcomeScreen()),
    GoRoute(
      path: '/home',
      builder: (context, _) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => ProfileViewModel(ctx.read<UserRepository>()),
          ),
          ChangeNotifierProvider(
            create: (ctx) => InboxViewModel(
              ctx.read<UserRepository>(),
              ctx.read<FriendshipRepository>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => NotificationsViewModel(
              ctx.read<NotificationRepository>(),
              ctx.read<FriendshipRepository>(),
            ),
          ),
        ],
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, _) => ChangeNotifierProvider(
        create: (ctx) => LoginViewModel(ctx.read<AuthRepository>()),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, _) => ChangeNotifierProvider(
        create: (ctx) => RegisterViewModel(ctx.read<AuthRepository>()),
        child: const RegisterScreen(),
      ),
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) => ChangeNotifierProvider(
        create: (ctx) => OtpViewModel(ctx.read<AuthRepository>()),
        child: OtpScreen(
          email: state.uri.queryParameters['email'] ?? '',
          expireSeconds: int.tryParse(
                state.uri.queryParameters['expire'] ?? '',
              ) ??
              120,
        ),
      ),
    ),
  ],
);
