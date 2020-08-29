import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();

  MainLayout({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeConfig.colors.secondary,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 102.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: _decorationCircle(themeConfig.colors.primary2)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 97.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: _decorationCircle(themeConfig.colors.primary1.withOpacity(0.5))
            ),
          ),
          child
        ],
      ),
    );
  }

  Widget _decorationCircle(Color color){
    return Transform.scale(
        scale: 102.0,
        child: CircleAvatar(radius: 1,
          backgroundColor: color
        ));
  }
}