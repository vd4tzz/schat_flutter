import 'package:flutter_test/flutter_test.dart';
import 'package:schat_flutter/main.dart';

void main() {
  testWidgets('SChat app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SChat());
  });
}
