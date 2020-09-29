import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DhSearchBar extends StatelessWidget {
  const DhSearchBar();

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: themeConfig.textStyles.textFieldHint,
          filled: true,
          fillColor: themeConfig.colors.addSthHere,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0)),
        ),
      ),
    );
  }
}
