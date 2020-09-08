
import 'package:drop_here_mobile/counter/ui/pages/buyer_details_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/buyer_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/choose_user_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/client_details_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/company_details_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/login_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/sandbox_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/seller_details_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/seller_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/splash_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/welcome_page.dart';
import 'package:get/get.dart';

class LoginPages {
  static List<GetPage> pages = [
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/welcome', page: () => WelcomePage()),
    GetPage(name: '/sellerRegister', page: () => SellerRegistrationPage()),
    GetPage(name: '/sellerDetailsRegistration', page: () => SellerDetailsRegistrationPage()),
    GetPage(name: '/buyerRegister', page: () => BuyerRegistrationPage()),
    GetPage(name: '/buyerDetailsRegistration', page: () => BuyerDetailsRegistrationPage()),
    GetPage(name: '/chooseUser', page: () => ChooseUserPage()),
    GetPage(name: '/companyDetails', page: () => CompanyDetailsPage()),
    GetPage(name: '/customerDetails', page: () => ClientDetailsPage()),
    GetPage(name: '/sandbox', page: () => SandboxPage()),
  ];
}