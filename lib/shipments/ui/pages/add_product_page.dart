import 'package:drop_here_mobile/accounts/ui/widgets/product_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/info_text.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_circled_info.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final List<RouteProductRouteResponse> products;

  AddProductPage({this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DhBackButton(
                padding: EdgeInsets.zero,
              ),
              Text(
                "Select product",
                style: themeConfig.textStyles.primaryTitle,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                for (RouteProductRouteResponse product in products ?? [])
                  ProductCard(
                    product: product.routeProductResponse,
                    onTap: () async {
                      print("Clicked ${product.routeProductResponse.name}");
                      final ShipmentProductRequest returned =
                          await showDialog(context: context, child: AddProductToShipmentDialog(product: product));
                      Get.back(result: returned);
                    },
                  )
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class AddProductToShipmentDialog extends StatefulWidget {
  final RouteProductRouteResponse product;

  const AddProductToShipmentDialog({this.product});

  @override
  _AddProductToShipmentDialogState createState() => _AddProductToShipmentDialogState();
}

class _AddProductToShipmentDialogState extends State<AddProductToShipmentDialog> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  ShipmentProductRequest request = ShipmentProductRequest(customizations: []);
  List<ProductCustomizationResponse> customizations = [];

  @override
  void initState() {
    request.quantity = widget.product.routeProductResponse.unitFraction;
    request.routeProductId = widget.product.routeProductResponse.id;
    super.initState();
  }

  void setSelectedCustomization(ProductCustomizationResponse customization, bool remove) {
    setState(() {
      if (remove)
        customizations.remove(customization);
      else
        customizations.add(customization);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RouteProductRouteResponse product = widget.product;
    final double maxAmount = product.limitedAmount ? product.amount : product.routeProductResponse.unitFraction * 100;
    return AlertDialog(
      title: Align(
          child: Column(
        children: [
          Text(widget.product.routeProductResponse.name),
          LabeledCircledColoredInfo(
              label: "Summarized price",
              text: "${removeDecimalZeroFormat(product.price * request.quantity + calculateCustomizationsPrice())} zł")
        ],
      )),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledCircledInfo(
              label: "Price",
              text: widget.product.pricePerUnit,
            ),
            Align(child: Text("Amount")),
            Slider(
              min: product.routeProductResponse.unitFraction,
              max: maxAmount,
              divisions: maxAmount ~/ product.routeProductResponse.unitFraction - 1,
              value: request.quantity,
              label: removeDecimalZeroFormat(request.quantity),
              onChanged: (value) => setState(() => request.quantity = value),
            ),
            LabeledCircledInfo(
              label: "Selected amount",
              text: removeDecimalZeroFormat(request.quantity),
            ),
            Align(child: Text("Customizations")),
            Column(
                children: widget.product.routeProductResponse.customizationsWrappers
                    .map((customization) => customization.type == CustomizationType.SINGLE
                        ? SingleTypeCustomization(customization: customization, setValue: setSelectedCustomization)
                        : MultiTypeCustomization(
                            customization: customization,
                            setValue: setSelectedCustomization,
                          ))
                    .toList()),
          ],
        ),
      ),
      actions: [
        GestureDetector(
          child: Text("Cancel", style: themeConfig.textStyles.blocked.copyWith(fontSize: 20.0)),
          onTap: () => Navigator.pop(context, null),
        ),
        GestureDetector(
          child: Text("Submit", style: themeConfig.textStyles.active.copyWith(fontSize: 20.0)),
          onTap: () => Navigator.pop(context, [prepareToReturn(),product.price * request.quantity + calculateCustomizationsPrice()]),
        ),
      ],
    );
  }

  ShipmentProductRequest prepareToReturn() {
    for (ProductCustomizationResponse customization in customizations)
      request.customizations.add(ShipmentCustomizationRequest(id: customization.id));
    return request;
  }

  double calculateCustomizationsPrice() {
    if (customizations.isNotEmpty) {
      return customizations.map((e) => e.price * request.quantity).reduce((value, element) => value + element);
    }
    return 0;
  }
}

class SingleTypeCustomization extends StatefulWidget {
  final ProductCustomizationWrapperResponse customization;
  final Function(ProductCustomizationResponse, bool) setValue;

  const SingleTypeCustomization({this.customization, this.setValue});

  @override
  _SingleTypeCustomizationState createState() => _SingleTypeCustomizationState();
}

class _SingleTypeCustomizationState extends State<SingleTypeCustomization> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  ProductCustomizationWrapperResponse customization;
  ProductCustomizationResponse selectedValue;

  @override
  void initState() {
    customization = widget.customization;
    selectedValue = customization.required ? customization.customizations.first : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${customization.heading} ${customization.required ? "(required)" : ""}",
          style: themeConfig.textStyles.dataAnnotation,
        ),
        InfoText(text: "Choose ${customization.type == CustomizationType.SINGLE ? "one" : "many"}"),
        for (ProductCustomizationResponse customizationValue in customization.customizations ?? [])
          RadioListTile(
            toggleable: !customization.required,
            value: customizationValue,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(customizationValue.value),
            selected: selectedValue == customizationValue,
            subtitle: Text(formatPrice(customizationValue.price)),
            groupValue: selectedValue,
            onChanged: (value) => setState(() {
              if (value == null && !customization.required) {
                widget.setValue.call(selectedValue, true);
                selectedValue = null;
              } else {
                widget.setValue.call(selectedValue, true);
                selectedValue = value;
                widget.setValue.call(value, false);
              }
            }),
          )
      ],
    );
  }
}

class MultiTypeCustomization extends StatefulWidget {
  final ProductCustomizationWrapperResponse customization;
  final Function(ProductCustomizationResponse, bool) setValue;

  const MultiTypeCustomization({this.customization, this.setValue});

  @override
  _MultiTypeCustomizationState createState() => _MultiTypeCustomizationState();
}

class _MultiTypeCustomizationState extends State<MultiTypeCustomization> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  ProductCustomizationWrapperResponse customization;
  List<ProductCustomizationResponse> selectedValues;

  @override
  void initState() {
    customization = widget.customization;
    selectedValues = customization.required ? [customization.customizations.first] : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${customization.heading} ${customization.required ? "(required)" : ""}",
          style: themeConfig.textStyles.dataAnnotation,
        ),
        InfoText(text: "Choose ${customization.type == CustomizationType.SINGLE ? "one" : "many"}"),
        for (ProductCustomizationResponse customizationValue in customization.customizations ?? [])
          CheckboxListTile(
            value: selectedValues.contains(customizationValue),
            title: Text(customizationValue.value),
            selected: selectedValues.contains(customizationValue),
            subtitle: Text(formatPrice(customizationValue.price)),
            onChanged: (value) => setState(() {
              value ? selectedValues.add(customizationValue) : selectedValues.remove(customizationValue);
              value ? widget.setValue.call(customizationValue, false) : widget.setValue.call(customizationValue, true);
            }),
          )
      ],
    );
  }
}
