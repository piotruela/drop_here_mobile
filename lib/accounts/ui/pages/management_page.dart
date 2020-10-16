import 'package:drop_here_mobile/accounts/ui/pages/sellers_list_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'clients_list_page.dart';
import 'company_details_page.dart';

class ManagementPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
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
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: themeConfig.colors.white, borderRadius: BorderRadius.circular(10)),
                  tabs: <Widget>[
                    buildTab(locale.clients),
                    buildTab(locale.sellers),
                    buildTab(locale.company),
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
          )),
        ),
      ),
    );
  }

  Tab buildTab(String text) {
    return Tab(child: Text(text, style: themeConfig.textStyles.secondaryTitle));
  }
}
