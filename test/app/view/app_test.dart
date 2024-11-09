import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/root/root.dart';

void main() {
  group('App', () {
    testWidgets('renders Root', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Root), findsOneWidget);
    });
  });
}
