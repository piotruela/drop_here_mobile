import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

class ValuePickedFlatButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const ValuePickedFlatButton({this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          //border: Border.all(color: themeConfig.colors.primary1),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: themeConfig.textStyles.valueChosenFlatButtonTextStyle,
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.edit,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
