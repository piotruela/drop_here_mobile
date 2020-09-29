import 'package:drop_here_mobile/accounts/ui/widgets/dh_card.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsListPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                locale.persons,
                style: themeConfig.textStyles.primaryTitle,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                FlatButton(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    width: 190.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: Text(
                      locale.clients,
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    locale.sellers,
                    style: themeConfig.textStyles.secondaryTitle,
                  ),
                ),
              ],
            ),
            DhSearchBar(),
            DhCard(
              title: 'Piotr',
              isActive: false,
              dropsNumber: 7,
            ),
          ],
        ),
      ),
    );
  }
}
