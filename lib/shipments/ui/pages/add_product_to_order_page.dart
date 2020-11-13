import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/shipments/bloc/add_product_to_order/add_product_to_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductToOrderPage extends BlocWidget<AddProductToOrderBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  // final Set<OrderProductModel> selectedProducts;

  AddProductToOrderPage();

  @override
  AddProductToOrderBloc bloc() => AddProductToOrderBloc();
  // AddProductToOrderBloc()..add(FetchProducts(selectedProducts: selectedProducts ?? {}));

  @override
  Widget build(BuildContext context, AddProductToOrderBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              locale.addProductToOrder,
              style: themeConfig.textStyles.primaryTitle,
            ),
            textAndFlatButton(locale.productName, bloc.state.product.productResponse.name),
            textAndFlatButton(
                locale.pricePerUnit, bloc.state.product.productResponse.price.toString()),
            Text(
              locale.pieces,
              style: themeConfig.textStyles.secondaryTitle,
            ),
            Text(
              locale.customizations,
              style: themeConfig.textStyles.secondaryTitle,
            ),
          ],
        ),
      ),
    );
  }

  Column textAndFlatButton(String text, String buttonText) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: themeConfig.textStyles.dataAnnotation,
            ),
            RoundedFlatButton(
              text: buttonText,
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
