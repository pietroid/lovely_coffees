import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/discover/view/widgets/beating_heart.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('HeartBeatAnimation', () {
    testWidgets(
        'when rendering HeartBeatAnimation, it should show the heart icon',
        (tester) async {
      await tester.pumpApp(const HeartBeatAnimation());

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
