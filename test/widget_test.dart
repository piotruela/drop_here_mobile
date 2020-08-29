

import 'package:drop_here_mobile/common/config/app_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/config/drop_here_assets_config.dart';
import 'package:drop_here_mobile/config/drop_here_locator_config.dart';
import 'package:drop_here_mobile/config/drop_here_theme_config.dart';
import 'package:drop_here_mobile/counter/ui/pages/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  AppConfig appConfig = AppConfig(
      assetsConfig: DHAssetsConfig(),
      themeConfig: DHThemeConfig(),
      apiUrl: "https://icanhazdadjoke.com");
  LocatorConfig locatorConfig = AppLocatorConfig();
  locatorConfig.registerObjects(appConfig);
  testWidgets('FormPage has icons and title', (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());

    expect(find.text('Flutter Form Validation'), findsOneWidget);
    expect(find.text('Form Submitted Successfully'), findsNothing);

    expect(find.byIcon(Icons.email), findsNWidgets(2));
    expect(find.byIcon(Icons.lock), findsOneWidget);

  });

  testWidgets('FormPage has Submit button', (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());

    expect(find.byType(RaisedButton), findsNWidgets(2));
  });
}
