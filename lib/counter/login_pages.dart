
import 'package:drop_here_mobile/counter/ui/pages/buyer_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/login_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/seller_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/splash_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/welcome_page.dart';
import 'package:get/get.dart';

class LoginPages {
  static List<GetPage> pages = [
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/welcome', page: () => WelcomePage()),
    GetPage(name: '/sellerRegister', page: () => SellerRegistrationPage()),
    GetPage(name: '/buyerRegister', page: () => BuyerRegistrationPage()),
    GetPage(name: '/login', page: () => LoginPage()),
  ];
}