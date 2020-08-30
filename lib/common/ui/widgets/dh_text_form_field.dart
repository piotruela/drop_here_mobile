import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class DhTextFormField extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  final String labelText;
  final EdgeInsets padding;

  DhTextFormField({Key key, this.labelText, this.padding = EdgeInsets.zero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        child: TextFormField(
            style: themeConfig.textStyles.secondaryTitle.copyWith(color: themeConfig.colors.secondary),
            decoration: InputDecoration(
              fillColor: themeConfig.colors.white, filled: true,
              labelText: labelText,
              labelStyle: themeConfig.textStyles.textFieldHint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  width: 2.0,
                ),
              ),
            )),
      ),
    );
  }
}
