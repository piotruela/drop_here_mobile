import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/counter/ui/pages/buyer_details_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/login_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/sandbox_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/seller_details_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/splash_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/welcome_page.dart';

class CounterRoutes {
  static RouteDefinition splash = RouteDefinition(
      name: '/splash',
      builder: (context) => SplashPage(),
      arguments: NavigationArguments(replaceCurrent: true));

  static RouteDefinition welcome = RouteDefinition(
      name: '/welcome',
      builder: (context) => WelcomePage(),
      arguments: NavigationArguments(replaceCurrent: true));

  static RouteDefinition login = RouteDefinition(
      name: '/login',
      builder: (context) => LoginPage(),
      arguments: NavigationArguments(replaceCurrent: true));
  static RouteDefinition sandbox = RouteDefinition(
      name: '/sandbox',
      builder: (context) => SandboxPage(),
      arguments: NavigationArguments(replaceCurrent: false));
  static RouteDefinition buyerDetailsRegistration = RouteDefinition(
      name: '/buyerDetailsRegistration',
      builder: (context) => BuyerDetailsRegistrationPage(),
      arguments: NavigationArguments(replaceCurrent: false));

  static RouteDefinition sellerDetailsRegistration = RouteDefinition(
      name: '/sellerDetailsRegistration',
      builder: (context) => SellerDetailsRegistrationPage(),
      arguments: NavigationArguments(replaceCurrent: false));
}
