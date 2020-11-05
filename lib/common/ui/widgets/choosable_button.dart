import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosableButton extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String text;
  final bool isChosen;
  final VoidCallback chooseAction;

  ChoosableButton({this.text, this.isChosen, this.chooseAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: isChosen ? null : chooseAction,
        child: Container(
          height: 30.0,
          decoration: BoxDecoration(
              color: themeConfig.colors.white,
              boxShadow: [
                dhShadow(),
              ],
              border: isChosen ? Border.all(width: 1.0, color: themeConfig.colors.primary1) : null,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Center(
            child: Text(text,
                style: isChosen
                    ? themeConfig.textStyles.coloredFlatButton
                    : themeConfig.textStyles.coloredFlatButton.copyWith(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
/*
Container(
child: ConstrainedBox(
constraints: BoxConstraints(
minWidth: 300.0,
maxWidth: 300.0,
minHeight: 30.0,
maxHeight: 100.0,
),
child: AutoSizeText(
"yourText",
style: TextStyle(fontSize: 30.0),
),
),
);*/
