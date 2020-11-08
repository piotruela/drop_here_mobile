import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabeledCircledInfo extends StatelessWidget {
  final String label;
  final String text;

  const LabeledCircledInfo({this.label, this.text});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: themeConfig.textStyles.dataAnnotation,
        ),
        RoundedFlatButton(
          text: text,
        ),
      ],
    );
  }
}
