import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/thresholds.dart';
import 'package:drop_here_mobile/common/ui/widgets/add_new_item_panel.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/common/ui/widgets/snackbar.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/management/ui/pages/sellers_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'clients_list_page.dart';
import 'company_details_page.dart';

class ManagementPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final PanelController panelController = PanelController();
  final int initialIndex;

  ManagementPage({this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: dhSnackBar(locale.tapBackButtonAgainHint),
        child: Stack(
          children: [
            SafeArea(
              child: DefaultTabController(
                initialIndex: initialIndex,
                length: 3,
                child: Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 30.0, bottom: 12.0),
                        child: Text(
                          locale.management,
                          style: themeConfig.textStyles.primaryTitle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: TabBar(
                          indicator: BoxDecoration(
                              color: themeConfig.colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          tabs: <Widget>[
                            buildTab(locale.clients, width),
                            buildTab(locale.sellers, width),
                            buildTab(locale.company, width),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TabBarView(
                          children: [
                            ClientsListPage(),
                            SellersListPage(),
                            CompanyDetailsPage(),
                          ],
                        ),
                      )
                    ],
                  ),
                  bottomNavigationBar:
                      CompanyBottomBar(controller: panelController, sectionIndex: 3),
                ),
              ),
            ),
            AddNewItemPanel(controller: panelController)
          ],
        ),
      ),
    );
  }

  Tab buildTab(String text, double width) {
    return Tab(
      child: width > Thresholds.width
          ? Text(text, style: themeConfig.textStyles.secondaryTitle)
          : Text(text, style: themeConfig.textStyles.smallSecondaryTitle),
    );
  }
}
