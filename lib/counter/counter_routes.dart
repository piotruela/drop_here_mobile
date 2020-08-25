
import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/counter/ui/pages/first_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/second_page.dart';

class CounterRoutes {

  static RouteDefinition login = RouteDefinition(
      name: '/greet',
      builder: (context) => LoginPage(),
      arguments: NavigationArguments(
          activeBottomBarItemIndex: 0, replaceCurrent: true));

  static RouteDefinition info = RouteDefinition(
      name: '/info',
      builder: (context) => InfoPage(),
      arguments: NavigationArguments(
          activeBottomBarItemIndex: 1, replaceCurrent: true));
}