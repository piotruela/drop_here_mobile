import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/management/ui/pages/customer_details_page.dart';
import 'package:drop_here_mobile/management/ui/pages/management_page.dart';
import 'package:drop_here_mobile/products/ui/pages/products_list_page.dart';
import 'package:drop_here_mobile/shipments/ui/pages/customer_shipments_list_page.dart';
import 'package:drop_here_mobile/shipments/ui/pages/dashboard_page.dart';
import 'package:drop_here_mobile/spots/ui/pages/company_map_page.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomerBottomBar extends DHBottomBar {
  final int sectionIndex;

  CustomerBottomBar({this.sectionIndex}) : super(selectedIndex: sectionIndex);

  List<Widget> get bottomBarItems => [
        bottomBarItem(sectionIndex == 0, Icons.home, CustomerShipmentsListPage()),
        bottomBarItem(sectionIndex == 1, Icons.map, CustomerMapPage()),
        bottomBarItem(sectionIndex == 2, Icons.person, CustomerDetailsPage()),
      ];
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

  List<Widget> get bottomBarItems => [
        bottomBarItem(sectionIndex == 0, Icons.home, DashboardPage()),
        bottomBarItem(sectionIndex == 1, Icons.shopping_basket, ProductsListPage()),
        centerButton(),
        bottomBarItem(sectionIndex == 2, Icons.map, CompanyMapPage()),
        bottomBarItem(sectionIndex == 3, Icons.person, ManagementPage()),
      ];
}

abstract class DHBottomBar extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int selectedIndex;

  List<Widget> get bottomBarItems => null;

  Widget centerButton() => SizedBox.shrink();

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
            mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: bottomBarItems),
      ),
    );
  }

  Widget bottomBarItem(bool isSelected, IconData icon, Widget page) {
    final ColorTheme colors = themeConfig.colors;
    return IconButton(
      onPressed: () => Get.offAll(page),
      iconSize: 35.0,
      icon: Icon(
        icon,
        color: isSelected ? colors.primary1 : colors.textFieldHint,
      ),
    );
  }
}
