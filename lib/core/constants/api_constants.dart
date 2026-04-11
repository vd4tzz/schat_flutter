import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

abstract final class ApiConstants {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000';
    }

    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000'; // Android emulator → host
    }

    if (Platform.isIOS) {
      return 'http://localhost:3000'; // iOS simulator
    }

    // Device thực hoặc platform khác
    return 'http://localhost:3000';
  }

  // Auth
  static const register = '/auth/register';
  static const verifyOtp = '/auth/verify-otp';
  static const resendOtp = '/auth/resend-otp';
  static const login = '/auth/login';
  static const refresh = '/auth/refresh';
  static const logout = '/auth/logout';

  // Users
  static const searchUsers = '/users/search';

  // Friendships
  static const friendships = '/friendships';
  static const friendRequests = '/friendships/requests';
  static const incomingRequests = '/friendships/requests/incoming';

  // Conversations
  static const conversations = '/conversations';
  static String conversation(String id) => '/conversations/$id';

  // Messages
  static String conversationMessages(String conversationId) =>
      '/conversations/$conversationId/messages';

  static String message(String messageId) => '/messages/$messageId';

  // Notifications
  static const notifications = '/notifications';
  static const notificationsUnreadCount = '/notifications/unread-count';
  static const notificationsReadAll = '/notifications/read-all';
}
