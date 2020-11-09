import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/info_text.dart';
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
  final _formKey = GlobalKey<FormState>();
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
    return Form(
      key: _formKey,
      child: AlertDialog(
        actions: [
          GestureDetector(
            child: Text("Cancel", style: themeConfig.textStyles.blocked.copyWith(fontSize: 20.0)),
            onTap: () => Navigator.pop(context, null),
          ),
          GestureDetector(
            child: Text("Submit", style: themeConfig.textStyles.active.copyWith(fontSize: 20.0)),
            onTap: () {
              if (_formKey.currentState.validate()) {
                Navigator.pop(context, customization);
              }
            },
          ),
        ],
        title: Align(child: Text("Add customization", style: themeConfig.textStyles.secondaryTitle)),
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
                  hintText: "e.g. Roll type",
                  isRequired: true,
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
                      chooseAction: () => setState(() => customization.type = CustomizationType.SINGLE)),
                  ChoosableButton(
                      text: "Multiple",
                      isChosen: describeEnum(customization?.type) == "MULTIPLE",
                      chooseAction: () => setState(() => customization.type = CustomizationType.MULTIPLE)),
                ],
              ),
              _sectionTitle("Values"),
              InfoText(text: "Click on customization to delete it"),
              _customizationsList(customizationValues),
              ChoosableButton(
                  text: "Add value +",
                  isChosen: false,
                  chooseAction: () async {
                    ProductCustomizationRequest customization = ProductCustomizationRequest();
                    customization = await showDialog(
                        context: context, child: CustomizationValueDialog(customization: customization));
                    if (customization != null) {
                      setState(() => customizationValues.add(customization));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customizationsList(List<ProductCustomizationRequest> customizationValue) {
    if (customizationValues.isEmpty) return SizedBox.shrink();
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

class CustomizationValueDialog extends StatefulWidget {
  final ProductCustomizationRequest customization;

  const CustomizationValueDialog({this.customization});

  @override
  _CustomizationValueDialogState createState() => _CustomizationValueDialogState();
}

class _CustomizationValueDialogState extends State<CustomizationValueDialog> {
  final _formKey = GlobalKey<FormState>();
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  ProductCustomizationRequest customization;

  @override
  void initState() {
    customization = widget.customization;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
          title: Text("Add value"),
          actions: [
            GestureDetector(
              child: Text("Cancel", style: themeConfig.textStyles.blocked.copyWith(fontSize: 20.0)),
              onTap: () => Navigator.pop(context, null),
            ),
            GestureDetector(
              child: Text("Submit", style: themeConfig.textStyles.active.copyWith(fontSize: 20.0)),
              onTap: () {
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context, customization);
                }
              },
            ),
          ],
          content: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              _sectionTitle("Value"),
              DhPlainTextFormField(
                inputType: InputType.text,
                initialValue: "",
                hintText: "e.g. wholemeal",
                isRequired: true,
                onChanged: (String value) => setState(() => customization.value = value),
              ),
              _sectionTitle("Price"),
              DhPlainTextFormField(
                inputType: InputType.number,
                initialValue: "",
                hintText: "e.g. 0.50",
                isRequired: true,
                onChanged: (String value) => setState(() => customization.price = double.parse(value)),
              ),
            ]),
          )),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: themeConfig.textStyles.secondaryTitle,
    );
  }
}
