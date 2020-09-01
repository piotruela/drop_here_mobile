import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class DhButton extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  final double height;
  final double width;
  final void Function() onPressed;
  final String text;
  final Color backgroundColor;

  DhButton({Key key, this.height = 60, this.width = 330, this.onPressed, this.backgroundColor, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RaisedButton(onPressed: onPressed,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text(text, style: themeConfig.textStyles.dhButton),),
    );
  }
}
