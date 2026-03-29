# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

SChat - Real-time messaging app built with Flutter.

## Commands

```bash
flutter run                      # Run app
flutter analyze                  # Lint
flutter test                     # Run all tests
flutter test test/foo_test.dart  # Run single test
dart run build_runner build      # Code gen (for Drift)
```

## Architecture

**MVVM**, layer-based folder structure:

```
lib/
├── data/              # Data layer (no Flutter imports)
│   ├── models/        # Data classes: Message, User, Conversation
│   ├── repositories/  # Mediator between ViewModel and data sources
│   ├── remote/        # ApiClient, SocketClient
│   └── local/         # Drift database (offline-first)
├── ui/                # Presentation layer
│   ├── theme/         # AppTheme (light/dark)
│   ├── auth/          # view/ + auth_view_model.dart
│   ├── conversations/ # view/ + widgets/ + conversations_view_model.dart
│   └── chat/          # view/ + widgets/ + chat_view_model.dart
└── main.dart
```

**Dependency direction (one-way only):** View → ViewModel → Repository → Remote/Local

## Key Patterns

- **View:** Widgets that render UI, only know ViewModel via `context.watch<>()`
- **ViewModel:** Extends ChangeNotifier, only knows Repository, no Flutter widget imports
- **Repository:** Mediates between local DB and remote API, handles offline-first logic
- **SocketListener:** Non-rendering widget placed above MainScreen in widget tree, distributes WebSocket events to all ViewModels
- **MainScreen:** Uses IndexedStack with lazy init for tab preservation
- **Provider setup order in main.dart:** Network → Repository (ProxyProvider) → ViewModel (ChangeNotifierProvider)

## Language

User communicates in Vietnamese.
