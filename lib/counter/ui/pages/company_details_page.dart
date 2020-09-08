import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class CompanyDetailsPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeConfig.colors.primary1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 27.0, vertical: 14.0),
            child: Text(
              Localization.of(context).bundle.companyDetails,
              style: themeConfig.textStyles.secondaryTitle,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: themeConfig.colors.primary1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 5)
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 64.0,
                          child: ClipOval(
                            child: CircleAvatar(
                              backgroundColor: themeConfig.colors.white,
                              radius: 64.0,
                              child: Icon(
                                Icons.person,
                                color: themeConfig.colors.primary1,
                                size: 110.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: themeConfig.colors.secondary,
                            child: CircleAvatar(
                              backgroundColor: themeConfig.colors.white,
                              radius: 18.0,
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DhListTile(
            themeConfig: themeConfig,
            icon: Icons.person,
            title: "Name",
            trailing: "drop.here",
          ),
          DhListTile(
            themeConfig: themeConfig,
            icon: Icons.map,
            title: "Country",
            trailing: "Poland",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sellers.length,
              itemBuilder: (context, i) {
                return Theme(
                  data: ThemeData(
                    accentColor: Colors.black,
                  ),
                  child: ExpansionTile(
                    backgroundColor: Colors.black,
                    title: Text(
                      sellers[i].title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    children: <Widget>[
                      Column(
                        children: _buildExpandableContent(sellers[i]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildExpandableContent(Seller vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          trailing: Text(content),
          title: new Text(
            'Name',
            style: new TextStyle(fontSize: 18.0),
          ),
          leading: CircleAvatar(
            child: Text(getInitials(content).toUpperCase()),
          ),
        ),
      );

    return columnContent;
  }

  String getInitials(name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords > names.length) {
      numWords = names.length;
    }
    for (int i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }
}

class Seller {
  final String title;
  List<String> contents = [];

  Seller(this.title, this.contents);
}

List<Seller> sellers = [
  new Seller(
    'Sellers',
    ['Seller no. 1', 'Seller no. 2', 'Seller no. 7', 'Seller no. 10'],
  ),
  // new Seller(
  //   'Cars',
  //   ['Seller no. 3', 'Seller no. 4', 'Seller no. 6'],
  //   Icons.directions_car,
  // ),
];

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
