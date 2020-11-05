import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizationDialog extends StatefulWidget {
  final ProductCustomizationWrapperRequest customization;

  const CustomizationDialog({this.customization});
  @override
  _CustomizationDialogState createState() => _CustomizationDialogState();
}

class _CustomizationDialogState extends State<CustomizationDialog> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  ProductCustomizationWrapperRequest customization;

  @override
  void initState() {
    customization = widget.customization;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(child: Text("Add customization", style: themeConfig.textStyles.secondaryTitle)),
          labeledSwitch(
              text: "Obligatory",
              initialPosition: customization.required,
              onSwitch: (unlimited) {
                setState(() {
                  customization.required = unlimited;
                });
              }),
          Text("Name"),
          DhPlainTextFormField(
              inputType: InputType.text,
              initialValue: customization.heading,
              hintText: "Roll type",
              onChanged: (String heading) => setState(
                    () => customization.heading = heading,
                  )),
          Text("Type"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChoosableButton(
                  text: "Single",
                  isChosen: describeEnum(customization?.type) == "SINGLE",
                  chooseAction: () =>
                      setState(() => customization.type = CustomizationType.SINGLE)),
              ChoosableButton(
                  text: "Multiple",
                  isChosen: describeEnum(customization?.type) == "MULTIPLE",
                  chooseAction: () =>
                      setState(() => customization.type = CustomizationType.MULTIPLE)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                child: Text("Cancel", style: themeConfig.textStyles.blocked),
                onPressed: () => Navigator.pop(context, null),
              ),
              RaisedButton(
                child: Text("Submit", style: themeConfig.textStyles.active),
                onPressed: () => Navigator.pop(context, customization),
              ),
            ],
          )
        ],
      ),
    );
  }
}
