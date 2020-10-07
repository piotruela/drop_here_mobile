import 'package:drop_here_mobile/accounts/ui/pages/buyer_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/client_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_admin_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/customer_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/home_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/log_on_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/login_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/sandbox_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/splash_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/welcome_page.dart';
import 'package:get/get.dart';

class LoginPages {
  static List<GetPage> pages = [
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/welcome', page: () => WelcomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/sellerRegister', page: () => CompanyRegistrationPage()),
    GetPage(name: '/createAdminProfile', page: () => CreateAdminProfilePage()),
    GetPage(name: '/sellerDetailsRegistration', page: () => CompanyDetailsRegistrationPage()),
    GetPage(name: '/buyerRegister', page: () => CustomerRegistrationPage()),
    GetPage(name: '/buyerDetailsRegistration', page: () => BuyerDetailsRegistrationPage()),
    GetPage(name: '/companyDetails', page: () => CompanyDetailsPage()),
    GetPage(name: '/customerDetails', page: () => ClientDetailsPage()),
    GetPage(name: '/sandbox', page: () => SandboxPage()),
    GetPage(name: '/homePage', page: () => Home()),
    GetPage(name: '/chooseProfile', page: () => ChooseProfilePage()),
    GetPage(name: '/profileLoginPage', page: () => LogOnProfilePage()),
  ];
}
