import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class DhListTile extends StatelessWidget {
  const DhListTile({
    Key key,
    @required this.themeConfig,
    this.icon,
    this.title,
    this.trailing,
  }) : super(key: key);

  final ThemeConfig themeConfig;
  final IconData icon;
  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Ink(
        color: themeConfig.colors.listTileMenu,
        child: ListTile(
          leading: Icon(
            icon,
            color: themeConfig.colors.listTileMenuIcon,
          ),
          title: Text(
            title,
            style: themeConfig.textStyles.listTileTitle,
          ),
          trailing: Text(
            trailing,
            style: themeConfig.textStyles.secondaryTitle,
          ),
        ),
      ),
    );
  }
}
