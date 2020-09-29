import 'package:drop_here_mobile/accounts/ui/pages/company_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_admin_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/login_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DHBottomBar extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int selectedIndex;

  DHBottomBar({this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
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
            //to leave space in between the bottom app bar items and below the FAB
            SizedBox(
              width: 50.0,
            ),
            IconButton(
              onPressed: () => Get.to(CompanyDetailsRegistrationPage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.pin_drop_outlined,
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
      //to add a space between the FAB and BottomAppBar
      shape: CircularNotchedRectangle(),
      //color of the BottomAppBar
      color: Colors.white,
    );
  }
}
