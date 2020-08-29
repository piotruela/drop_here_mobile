
import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/counter/ui/pages/splash_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/welcome_page.dart';

class CounterRoutes {
  static RouteDefinition welcome = RouteDefinition(
      name: '/welcome',
      builder: (context) => WelcomePage(),
      arguments: NavigationArguments(replaceCurrent: true));

  static RouteDefinition splash = RouteDefinition(
      name: '/splash',
      builder: (context) => SplashPage(),
      arguments: NavigationArguments(replaceCurrent: true));
}