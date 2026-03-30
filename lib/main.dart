import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/local/token_storage.dart';
import 'data/repositories/auth_repository.dart';
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

        // 2. Remote (ApiClient) — TODO

        // 3. Repositories
        ProxyProvider<TokenStorage, AuthRepository>(
          update: (_, tokenStorage, _) => AuthRepository(tokenStorage),
        ),

        // 4. ViewModels
        ChangeNotifierProxyProvider<AuthRepository, SplashViewModel>(
          create: (context) => SplashViewModel(context.read()),
          update: (_, authRepository, prev) => SplashViewModel(authRepository),
        ),
      ],
      child: MaterialApp.router(title: 'SChat', routerConfig: appRouter),
    );
  }
}
