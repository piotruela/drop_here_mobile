import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/common/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/counter/counter_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SandboxPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  final AssetsConfig assetsConfig = locator.get<AssetsConfig>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              FlatButton(child: Text("buyer details registration"), onPressed: (){BasePageNavigator.push(CounterRoutes.buyerDetailsRegistration);},),
            ],
          ),
        ),
      ),
    ),);
  }
}