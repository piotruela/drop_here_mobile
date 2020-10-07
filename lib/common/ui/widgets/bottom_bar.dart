import 'package:drop_here_mobile/accounts/ui/pages/company_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_admin_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/login_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DHBottomBar extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int selectedIndex;
  final PanelController controller;

  DHBottomBar({this.selectedIndex, this.controller});

  @override
  Widget build(BuildContext context) {
    ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: themeConfig.colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              //update the bottom app bar view each time an item is clicked
              onPressed: () => Get.to(CreateAdminProfilePage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.home,
                color: selectedIndex == 0
                    ? themeConfig.colors.primary1
                    : themeConfig.colors.textFieldHint,
              ),
            ),
            IconButton(
              onPressed: () => Get.to(LoginPage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.shopping_basket,
                color: selectedIndex == 1
                    ? themeConfig.colors.primary1
                    : themeConfig.colors.textFieldHint,
              ),
            ),
            FloatingActionButton(
              backgroundColor: themeConfig.colors.primary1,
              onPressed: () => controller.open(),
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Icon(Icons.add),
              ),
              elevation: 4.0,
            ),
            //to leave space in between the bottom app bar items and below the FAB
            IconButton(
              onPressed: () => Get.to(CompanyDetailsRegistrationPage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.call_made,
                color: selectedIndex == 2
                    ? themeConfig.colors.primary1
                    : themeConfig.colors.textFieldHint,
              ),
            ),
            IconButton(
              onPressed: () => Get.to(CompanyRegistrationPage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.person,
                color: selectedIndex == 3
                    ? themeConfig.colors.primary1
                    : themeConfig.colors.textFieldHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
