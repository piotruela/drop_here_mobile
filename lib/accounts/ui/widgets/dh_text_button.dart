import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DhTextButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final EdgeInsets padding;

  DhTextButton({Key key, this.text, this.onTap, this.padding = const EdgeInsets.all(4.0)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Text(text, style: themeConfig.textStyles.clickableText),
      ),
    );
  }
}
