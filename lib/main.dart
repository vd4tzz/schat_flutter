import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'data/local/token_storage.dart';
import 'data/remote/api_client.dart';
import 'data/repositories/auth_repository.dart';
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

        // 2. Remote
        ProxyProvider<TokenStorage, ApiClient>(
          update: (_, tokenStorage, _) => ApiClient(tokenStorage),
        ),

        // 3. Repositories
        ProxyProvider2<TokenStorage, ApiClient, AuthRepository>(
          update: (_, tokenStorage, apiClient, _) =>
              AuthRepository(tokenStorage, apiClient),
        ),

        ProxyProvider<ApiClient, UserRepository>(
          update: (_, apiClient, _) => UserRepository(apiClient),
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
        routerConfig: appRouter,
      ),
    );
  }
}
