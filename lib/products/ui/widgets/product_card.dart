import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductCard extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  VoidCallback get onExitPressed;
  String get name;
  String get firstLine;
  String get secondLine;
  bool get hasRemoveIcon;
  Widget get photo;

  @override
  Widget build(BuildContext context) {
    LocaleBundle locale = Localization.of(context).bundle;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 154,
              height: 96,
              child: ClipRRect(
                child: SizedBox(width: 150, height: 150, child: ClipOval(child: photo)),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: themeConfig.textStyles.title3,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    firstLine,
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 6.0),
                  secondLine ??
                      Text(
                        secondLine,
                        style: themeConfig.textStyles.title3Annotation,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productPhoto(Image photo) {
    return Container(
      width: 74.0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 74,
          maxHeight: 84,
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: photo),
      ),
    );
  }
}
