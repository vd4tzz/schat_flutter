import 'dart:io' show Platform;

String? fixUrl(String? url) {
  if (url == null) return null;
  if (Platform.isAndroid && url.contains('localhost')) {
    return url.replaceAll('localhost', '10.0.2.2');
  }
  return url;
}
