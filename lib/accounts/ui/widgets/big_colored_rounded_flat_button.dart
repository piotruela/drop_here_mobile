import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitFormButton extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String text;
  final Function onTap;
  final bool isActive;

  SubmitFormButton({this.text, this.onTap, @required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Text(
          text,
          style: isActive
              ? themeConfig.textStyles.bigColoredButtonActiveTextStyle
              : themeConfig.textStyles.bigColoredButtonNotActiveTextStyle,
        ),
      ),
    );
  }
}
