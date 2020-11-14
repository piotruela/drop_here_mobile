import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabeledCircledInfoWithDivider extends LabeledCircledInfo {
  final String label;
  final String text;

  LabeledCircledInfoWithDivider({this.label, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [super.build(context), Divider()],
    );
  }
}

//Widget with label on left side, and text inside rounded grey border on right side
class LabeledCircledInfo extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String label;
  final String text;

  LabeledCircledInfo({this.label, this.text});

  @override
  Widget build(BuildContext context) {
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
