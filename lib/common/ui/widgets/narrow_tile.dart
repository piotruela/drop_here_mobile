import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NarrowTile extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  IconData get iconType;

  String get tileTitle;

  String get firstLineText;

  String get secondLineText;

  VoidCallback get onExitPressed => null;

  VoidCallback get tileClickedAction => () => {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: tileClickedAction,
              child: Column(
                children: [
                  Container(
                    width: 114.0,
                    child: IconInCircle(
                      themeConfig: themeConfig,
                      icon: Icons.shopping_basket_outlined,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tileTitle,
                          style: themeConfig.textStyles.title3.copyWith(fontSize: 14.0),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          firstLineText,
                          style: themeConfig.textStyles.title3Annotation.copyWith(fontSize: 12.0),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          secondLineText,
                          style: themeConfig.textStyles.title3Annotation.copyWith(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
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
      ),
    );
  }
}
