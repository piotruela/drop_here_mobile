import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DhTextFormField extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String labelText;
  final EdgeInsets padding;
  final void Function(String) onChanged;
  final TextEditingController controller;
  final String Function(String) validator;

  DhTextFormField({Key key, this.labelText, this.padding = const EdgeInsets.only(left:40.0, right: 40.0,
      bottom: 10.0), this.onChanged, this.controller, this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 80,
        child: TextFormField(
          controller: controller,
            validator: validator ?? _defaultValidator,
            onChanged: onChanged,
            style: themeConfig.textStyles.secondaryTitle.copyWith(color: themeConfig.colors.black, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              fillColor: themeConfig.colors.white, filled: true,
              labelText: labelText,
              labelStyle: themeConfig.textStyles.textFieldHint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                    width: 2.0
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.red
                ),
              )
            )),
      ),
    );
  }
  String _defaultValidator(String value) => value.isEmpty
      ? labelText + " is required"
      : null;
}
