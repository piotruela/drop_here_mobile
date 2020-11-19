import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DhTextFormField extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String labelText;
  final EdgeInsets padding;
  final String initialValue;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final bool obscureText;

  DhTextFormField(
      {Key key,
      this.labelText,
      this.padding = const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 10.0),
      this.onChanged,
      this.validator,
      this.initialValue,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 80,
        child: TextFormField(
            obscureText: obscureText,
            initialValue: initialValue,
            onChanged: onChanged,
            validator: validator ?? (val) => _defaultValidator(val, context),
            style: themeConfig.textStyles.secondaryTitle
                .copyWith(color: themeConfig.colors.black, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                fillColor: themeConfig.colors.white,
                filled: true,
                labelText: labelText,
                labelStyle: themeConfig.textStyles.textFieldHint,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(width: 2.0, color: Colors.red),
                ))),
      ),
    );
  }

  String _defaultValidator(String value, BuildContext context) =>
      value.isEmpty ? labelText + Localization.of(context).bundle.isRequired : null;
}
