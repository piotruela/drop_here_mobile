import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/add_new_item_panel.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/routes_list_page.dart';
import 'package:drop_here_mobile/shipments/ui/pages/shipments_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final PanelController panelController = PanelController();
  final int initialIndex;

  DashboardPage({this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: DefaultTabController(
              initialIndex: initialIndex,
              length: 2,
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 30.0, bottom: 12.0),
                      child: Text(
                        "Dashboard",
                        style: themeConfig.textStyles.primaryTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TabBar(
                        indicator:
                            BoxDecoration(color: themeConfig.colors.white, borderRadius: BorderRadius.circular(10)),
                        tabs: <Widget>[
                          buildTab("Routes"),
                          buildTab("Orders"),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TabBarView(
                        children: [
                          RoutesListPage(),
                          ShipmentsListPage(),
                        ],
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: DHBottomBar(controller: panelController, selectedIndex: 0),
              ),
            ),
          ),
          AddNewItemPanel(controller: panelController)
        ],
      ),
    );
  }

  Tab buildTab(String text) {
    return Tab(child: Text(text, style: themeConfig.textStyles.secondaryTitle));
  }
}
