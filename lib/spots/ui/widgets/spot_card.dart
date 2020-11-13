import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSpotCard extends SpotCard {
  final SpotBaseCustomerResponse spot;

  CustomerSpotCard({this.spot, onSelectedItem, onTap}) : super(onSelectedItem: onSelectedItem, onTap: onTap);

  @override
  String get id => spot.uid;

  @override
  String get name => spot.name;

  @override
  double get xcoordinate => spot.xcoordinate;

  @override
  double get ycoordinate => spot.ycoordinate;
}

class CompanyDropSpotCard extends SpotCard {
  final SpotCompanyResponse spot;

  CompanyDropSpotCard({this.spot, onTap}) : super(onTap: onTap);

  @override
  String get id => spot.id.toString();

  @override
  String get name => spot.name;

  @override
  double get xcoordinate => spot.xcoordinate;

  @override
  double get ycoordinate => spot.ycoordinate;

  @override
  Widget get trailing => SizedBox.shrink();
}

class CompanySpotListCard extends SpotCard {
  final SpotCompanyResponse spot;

  CompanySpotListCard({this.spot, onSelectedItem, onTap}) : super(onSelectedItem: onSelectedItem, onTap: onTap);

  @override
  String get id => spot.id.toString();

  @override
  String get name => spot.name;

  @override
  double get xcoordinate => spot.xcoordinate;

  @override
  double get ycoordinate => spot.ycoordinate;
}

abstract class SpotCard extends StatelessWidget {
  final Function(String) onSelectedItem;
  final VoidCallback onTap;

  String get name;
  String get id;
  double get xcoordinate;
  double get ycoordinate;

  Widget get trailing => PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 30.0,
        ),
        onSelected: (value) => onSelectedItem(value),
        itemBuilder: (context) => <PopupMenuItem<String>>[
          new PopupMenuItem<String>(
              value: id, child: GestureDetector(child: Text(Localization.of(context).bundle.delete))),
        ],
      );

  EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0);

  const SpotCard({this.onSelectedItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: ListTile(
              leading: IconInCircle(
                themeConfig: themeConfig,
                icon: Icons.store,
              ),
              title: Text(
                name,
                style: themeConfig.textStyles.secondaryTitle,
              ),
              subtitle: FutureBuilder(
                  future: getAddressFromCoordinates(xcoordinate, ycoordinate),
                  initialData: "Loading location...",
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      style: themeConfig.textStyles.cardSubtitle,
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
              trailing: trailing),
          decoration: BoxDecoration(
            color: themeConfig.colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              dhShadow(),
            ],
          ),
        ),
      ),
    );
  }
}
