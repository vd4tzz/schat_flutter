import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'data/local/app_database.dart';
import 'data/local/token_storage.dart';
import 'data/remote/api_client.dart';
import 'data/remote/socket_client.dart';
import 'data/remote/socket_event_handler.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/friendship_repository.dart';
import 'data/repositories/conversation_repository.dart';
import 'data/repositories/message_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'data/repositories/user_repository.dart';
import 'ui/splash/splash_view_model.dart';
import 'router.dart';

void main() {
  runApp(const SChat());
}

class SChat extends StatelessWidget {
  const SChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1. Local
        Provider<TokenStorage>.value(value: TokenStorage.instance),
        Provider<AppDatabase>(create: (_) => AppDatabase()),

        // 2. Remote
        ProxyProvider<TokenStorage, ApiClient>(
          update: (_, tokenStorage, _) => ApiClient(tokenStorage),
        ),

        ProxyProvider<TokenStorage, SocketClient>(
          update: (_, tokenStorage, prev) =>
              prev ?? SocketClient(tokenStorage),
          dispose: (_, client) => client.dispose(),
        ),

        // 3. Repositories
        ProxyProvider2<TokenStorage, ApiClient, AuthRepository>(
          update: (_, tokenStorage, apiClient, _) =>
              AuthRepository(tokenStorage, apiClient),
        ),

        ProxyProvider2<ApiClient, AppDatabase, UserRepository>(
          update: (_, apiClient, db, _) => UserRepository(apiClient, db),
        ),

        ProxyProvider<ApiClient, FriendshipRepository>(
          update: (_, apiClient, _) => FriendshipRepository(apiClient),
        ),

        ProxyProvider2<ApiClient, AppDatabase, NotificationRepository>(
          update: (_, apiClient, db, _) => NotificationRepository(apiClient, db),
        ),

        ProxyProvider2<ApiClient, AppDatabase, ConversationRepository>(
          update: (_, apiClient, db, _) => ConversationRepository(apiClient, db),
        ),

        ProxyProvider2<ApiClient, AppDatabase, MessageRepository>(
          update: (_, apiClient, db, _) => MessageRepository(apiClient, db),
        ),

        ProxyProvider4<
          SocketClient,
          MessageRepository,
          ConversationRepository,
          NotificationRepository,
          SocketEventHandler
        >(
          update: (_, socketClient, messageRepo, convRepo, notifRepo, prev) =>
              prev ??
              SocketEventHandler(
                socketClient,
                messageRepo,
                convRepo,
                notifRepo,
              ),
          dispose: (_, d) => d.dispose(),
        ),

        // 4. ViewModels
        ChangeNotifierProxyProvider<AuthRepository, SplashViewModel>(
          create: (context) => SplashViewModel(context.read()),
          update: (_, authRepository, prev) => SplashViewModel(authRepository),
        ),

      ],
      child: MaterialApp.router(
        title: 'SChat',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
