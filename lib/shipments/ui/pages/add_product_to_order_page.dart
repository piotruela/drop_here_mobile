import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/model/order_product_model.dart';
import 'package:drop_here_mobile/shipments/bloc/add_product_to_order/add_product_to_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductsToOrderPage extends BlocWidget<AddProductToOrderBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final Set<OrderProductModel> selectedProducts;

  AddProductsToOrderPage(this.selectedProducts);

  @override
  AddProductToOrderBloc bloc() =>
      AddProductToOrderBloc()..add(FetchProducts(selectedProducts: selectedProducts ?? {}));

  @override
  Widget build(BuildContext context, AddProductToOrderBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold();
  }
}
