import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/buyer_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_user_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/client_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_admin_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/home_page.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SandboxPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                FlatButton(
                  child: Text("buyer details registration"),
                  onPressed: () {
                    Get.to(BuyerDetailsRegistrationPage());
                  },
                ),
                FlatButton(
                  child: Text("seller details registration"),
                  onPressed: () {
                    Get.to(CompanyDetailsRegistrationPage());
                  },
                ),
                FlatButton(
                  child: Text("choose user"),
                  onPressed: () {
                    Get.to(ChooseUserPage());
                  },
                ),
                FlatButton(
                  child: Text("company details"),
                  onPressed: () {
                    Get.to(CompanyDetailsPage());
                  },
                ),
                FlatButton(
                  child: Text("client details"),
                  onPressed: () {
                    Get.to(ClientDetailsPage());
                  },
                ),
                FlatButton(
                  child: Text("home page"),
                  onPressed: () {
                    Get.to(Home());
                  },
                ),
                FlatButton(
                  child: Text("choose profile page"),
                  onPressed: () {
                    Get.to(ChooseProfilePage());
                  },
                ),
                FlatButton(
                  child: Text("create admin profile"),
                  onPressed: () {
                    Get.to(CreateAdminProfilePage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
