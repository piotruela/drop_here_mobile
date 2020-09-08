import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DhButton extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final double height;
  final double width;
  final void Function() onPressed;
  final String text;
  final Color backgroundColor;
  final EdgeInsets padding;

  DhButton({Key key, this.height = 60, this.width = 330, this.onPressed, this.backgroundColor, this.text, this
      .padding = const EdgeInsets.only(top: 10, bottom: 10)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        width: width,
        child: RaisedButton(onPressed: onPressed,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Text(text, style: themeConfig.textStyles.button),),
      ),
    );
  }
}
