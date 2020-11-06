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
  List<ProductCustomizationRequest> customizationValues;

  @override
  void initState() {
    customization = widget.customization;
    customizationValues = widget.customization.customizations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        GestureDetector(
          child: Text("Cancel", style: themeConfig.textStyles.blocked.copyWith(fontSize: 20.0)),
          onTap: () => Navigator.pop(context, null),
        ),
        GestureDetector(
          child: Text("Submit", style: themeConfig.textStyles.active.copyWith(fontSize: 20.0)),
          onTap: () => Navigator.pop(context, customization),
        ),
      ],
      title: Text("Add customization", style: themeConfig.textStyles.secondaryTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labeledSwitch(
                text: "Obligatory",
                initialPosition: customization.required,
                onSwitch: (unlimited) {
                  setState(() {
                    customization.required = unlimited;
                  });
                }),
            _sectionTitle("Name"),
            DhPlainTextFormField(
                inputType: InputType.text,
                initialValue: customization.heading,
                hintText: "Roll type",
                onChanged: (String heading) => setState(
                      () => customization.heading = heading,
                    )),
            _sectionTitle("Type"),
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
            _sectionTitle("Values"),
            Row(
              children: [
                Icon(
                  Icons.info,
                  size: 15.0,
                ),
                Text(
                  "Click on customization to delete it",
                  style: themeConfig.textStyles.cardSubtitle,
                )
              ],
            ),
            _customizationsList(customizationValues),
            ChoosableButton(
                text: "Add value +",
                isChosen: false,
                chooseAction: () async {
                  ProductCustomizationRequest customization = ProductCustomizationRequest();
                  await showDialog(
                      context: context,
                      child: AlertDialog(
                          title: Text("Add value"),
                          actions: [
                            GestureDetector(
                              child: Text("Submit",
                                  style: themeConfig.textStyles.active.copyWith(fontSize: 20.0)),
                              onTap: () => Navigator.pop(context, customization),
                            ),
                          ],
                          content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _sectionTitle("Value"),
                                DhPlainTextFormField(
                                  inputType: InputType.text,
                                  initialValue: "",
                                  hintText: "Simple",
                                  onChanged: (String value) => customization.value = value,
                                ),
                                _sectionTitle("Price"),
                                DhPlainTextFormField(
                                  inputType: InputType.number,
                                  initialValue: "",
                                  hintText: "9.99",
                                  onChanged: (String value) =>
                                      customization.price = double.parse(value),
                                ),
                              ])));
                  setState(() => customizationValues.add(customization));
                }),
          ],
        ),
      ),
    );
  }

  Widget _customizationsList(List<ProductCustomizationRequest> customizationValue) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      for (ProductCustomizationRequest customization in customizationValues)
        ChoosableButton(
          text: "${customization.value}, ${customization.price}zł",
          isChosen: false,
          chooseAction: () => setState(() => customizationValues.remove(customization)),
        )
    ]);
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: themeConfig.textStyles.secondaryTitle,
    );
  }
}
