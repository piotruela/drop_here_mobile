import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpotCard extends StatelessWidget {
  final SpotCompanyResponse spot;
  final VoidCallback onTap;
  final Function(String) onSelectedItem;

  SpotCard({this.spot, this.onTap, this.onSelectedItem});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: ListTile(
            leading: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.store,
            ),
            title: Text(
              spot.name,
              style: themeConfig.textStyles.secondaryTitle,
            ),
            subtitle: FutureBuilder(
                future: getAddressFromCoordinates(spot.xcoordinate, spot.ycoordinate),
                initialData: "Loading location...",
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Text(
                    snapshot.data ?? "",
                    style: themeConfig.textStyles.cardSubtitle,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
            trailing: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: themeConfig.colors.black,
                size: 30.0,
              ),
              onSelected: (value) => onSelectedItem(value),
              itemBuilder: (context) => <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                    value: spot.id.toString(),
                    child: GestureDetector(child: Text(Localization.of(context).bundle.delete))),
              ],
            ),
          ),
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
