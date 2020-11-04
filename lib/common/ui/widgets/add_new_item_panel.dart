import 'package:drop_here_mobile/accounts/ui/pages/create_new_item_page.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddNewItemPanel extends StatelessWidget {
  final PanelController controller;

  const AddNewItemPanel({this.controller});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller,
      panel: CreateNewItemPage(controller: controller),
      minHeight: 0,
      maxHeight: 530,
      borderRadius:
          const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    );
  }
}
