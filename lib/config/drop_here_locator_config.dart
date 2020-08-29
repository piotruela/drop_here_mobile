import 'package:drop_here_mobile/common/config/bottom_bar_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/config/drop_here_bottom_bar_config.dart';

class AppLocatorConfig extends LocatorConfig {
  @override
  void registerServices() {
    locator.registerSingleton<BottomBarConfig>(DHBottomBarConfig());
  }
}
