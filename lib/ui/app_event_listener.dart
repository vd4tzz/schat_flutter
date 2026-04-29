import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_event_bus.dart';
import '../router.dart';

class AppEventListener extends StatefulWidget {
  final Widget child;

  const AppEventListener({required this.child, super.key});

  @override
  State<AppEventListener> createState() => _AppEventListenerState();
}

class _AppEventListenerState extends State<AppEventListener> {
  late StreamSubscription<AppEvent> _sub;

  @override
  void initState() {
    super.initState();
    _sub = context.read<AppEventBus>().stream.listen(_onEvent);
  }

  Future<void> _onEvent(AppEvent event) async {
    switch (event) {
      case AppEvent.sessionExpired:
        await _handleSessionExpired();
    }
  }

  Future<void> _handleSessionExpired() async {
    final context = appRouter.routerDelegate.navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Session expired'),
        content: const Text('Please log in again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    appRouter.go('/login');
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
