import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class ChooseUserPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Column(
        children: [
          Text(
            Localization.of(context).bundle.whoAreYou,
            style: themeConfig.textStyles.secondaryTitle,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.0 / 10.0,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: UserCard(
                    themeConfig: themeConfig,
                    name: "Name",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({this.themeConfig, this.name});

  final ThemeConfig themeConfig;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: themeConfig.colors.primary2,
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              child: CircleAvatar(
                radius: 63.0,
                backgroundColor: themeConfig.colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Center(
              child: Text(
                "Name",
                style: themeConfig.textStyles.cardCaption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
