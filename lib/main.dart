import 'package:drop_here_mobile/config/drop_here_assets_config.dart';
import 'package:drop_here_mobile/config/drop_here_theme_config.dart';

import 'app.dart';
import 'common/config/app_config.dart';


void main() => startApp(AppConfig(
    assetsConfig: DHAssetsConfig(),
    themeConfig: DHThemeConfig(),
    apiUrl: "https://icanhazdadjoke.com"));

