import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSpotDropCard extends DropCard {
  final DropCustomerSpotResponse drop;

  CustomerSpotDropCard({this.drop});

  @override
  String get startTime => drop.startTime.toTime();

  @override
  String get endTime => drop.endTime.toTime();

  @override
  String get name => drop.name;

  @override
  get onExitPressed => null;

  @override
  String get spotName => null;
}

abstract class DropCard extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  VoidCallback get onExitPressed;
  String get name;
  String get spotName;
  String get startTime;
  String get endTime;
  Widget get extraField => SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22.0, bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.0,
            ),
            Stack(
              children: [
                Container(
                  width: 114.0,
                  child: IconInCircle(
                    themeConfig: themeConfig,
                    icon: Icons.thumbs_up_down,
                  ),
                ),
                onExitPressed != null
                    ? Positioned(
                        top: 0,
                        right: 2,
                        child: GestureDetector(
                          onTap: onExitPressed,
                          child: Icon(Icons.close),
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: themeConfig.textStyles.title3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  extraField,
                  infoLine(Icons.calendar_today, themeConfig.colors.active, startTime),
                  infoLine(Icons.calendar_today, themeConfig.colors.blocked, endTime),
                  SizedBox(
                    height: 4.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoLine(IconData icon, Color iconColor, String text) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: Icon(
            icon,
            color: iconColor,
            size: 15.0,
          ),
        ),
        Text(
          text,
          style: themeConfig.textStyles.title3Annotation,
        ),
      ],
    );
  }
}
