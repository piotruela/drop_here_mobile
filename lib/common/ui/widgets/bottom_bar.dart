import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/management/ui/pages/management_page.dart';
import 'package:drop_here_mobile/products/ui/pages/products_list_page.dart';
import 'package:drop_here_mobile/shipments/ui/pages/dashboard_page.dart';
import 'package:drop_here_mobile/spots/ui/pages/company_map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomerBottomBar extends DHBottomBar {
  final int sectionIndex;

  CustomerBottomBar({this.sectionIndex}) : super(selectedIndex: sectionIndex);
}

class CompanyBottomBar extends DHBottomBar {
  final PanelController controller;
  final int sectionIndex;

  CompanyBottomBar({this.controller, this.sectionIndex}) : super(selectedIndex: sectionIndex);

  @override
  Widget centerButton() => FloatingActionButton(
        backgroundColor: themeConfig.colors.primary1,
        onPressed: () => controller.open(),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Icon(Icons.add),
        ),
        elevation: 4.0,
      );
}

abstract class DHBottomBar extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int selectedIndex;

  DHBottomBar({this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    FocusNode().dispose();
    ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(color: themeConfig.colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => Get.to(DashboardPage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.home,
                color: selectedIndex == 0 ? themeConfig.colors.primary1 : themeConfig.colors.textFieldHint,
              ),
            ),
            IconButton(
              onPressed: () => Get.to(ProductsListPage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.shopping_basket,
                color: selectedIndex == 1 ? themeConfig.colors.primary1 : themeConfig.colors.textFieldHint,
              ),
            ),
            centerButton(),
            IconButton(
              onPressed: () => Get.to(CompanyMapPage()),
              iconSize: 35.0,
              icon: Icon(
                Icons.map,
                color: selectedIndex == 2 ? themeConfig.colors.primary1 : themeConfig.colors.textFieldHint,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(ManagementPage());
              },
              iconSize: 35.0,
              icon: Icon(
                Icons.person,
                color: selectedIndex == 3 ? themeConfig.colors.primary1 : themeConfig.colors.textFieldHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget centerButton() => SizedBox.shrink();
}
