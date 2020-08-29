

import 'package:drop_here_mobile/common/config/app_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/main_widget.dart';
import 'package:drop_here_mobile/config/drop_here_assets_config.dart';
import 'package:drop_here_mobile/config/drop_here_locator_config.dart';
import 'package:drop_here_mobile/config/drop_here_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  AppConfig appConfig = AppConfig(
      assetsConfig: DHAssetsConfig(),
      themeConfig: DHThemeConfig(),
      apiUrl: "https://icanhazdadjoke.com");
  LocatorConfig locatorConfig = AppLocatorConfig();
  locatorConfig.registerObjects(appConfig);
  testWidgets('FormPage has icons and title', (WidgetTester tester) async {
    await tester.pumpWidget(MainWidget(
      appConfig: appConfig,
      navigatorKey: GlobalKey<NavigatorState>(),
    ));

    expect(find.text('drop.here'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    expect(find.byType(SvgPicture), findsOneWidget);
  });
}
