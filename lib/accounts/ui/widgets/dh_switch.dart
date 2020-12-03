import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnSwitch = Function(bool);

class DhSwitch extends StatefulWidget {
  final OnSwitch onSwitch;
  final bool initialPosition;

  const DhSwitch({this.onSwitch, this.initialPosition = false});

  @override
  _DhSwitchState createState() => _DhSwitchState(initialPosition);
}

class _DhSwitchState extends State<DhSwitch> {
  bool switchControl;
  bool initialPosition;

  _DhSwitchState(this.initialPosition);

  @override
  void initState() {
    super.initState();
    switchControl = initialPosition;
  }

  void toggleSwitch(bool value) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (switchControl == false) {
      setState(() {
        widget.onSwitch(true);
        switchControl = true;
      });
    } else {
      setState(() {
        widget.onSwitch(false);
        switchControl = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(children: [
        Transform.scale(
            scale: 1.0,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: themeConfig.colors.white,
              activeTrackColor: themeConfig.colors.primary1,
              inactiveThumbColor: themeConfig.colors.white,
              inactiveTrackColor: themeConfig.colors.black,
              //inactiveThumbImage: AssetImage(locator.get().radio),
              //activeThumbImage: AssetImage(locator.get().radio),
            )),
      ]),
    );
  }
}
