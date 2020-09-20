import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/counter/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/counter/ui/pages/add_product_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/buyer_details_registration_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/choose_user_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/client_details_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/company_details_page.dart';
import 'package:drop_here_mobile/counter/ui/pages/seller_details_registration_page.dart';
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
                    Get.to(SellerDetailsRegistrationPage());
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
                  child: Text("add product"),
                  onPressed: () {
                    Get.to(AddProductPage());
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
