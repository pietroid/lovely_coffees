import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffees/app_router/router.dart';
import 'package:lovely_coffees/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }

  Future<void> pumpAppWithDefaultRouter() {
    return pumpWidget(
      MaterialApp.router(
        routerConfig: AppRouter().router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
