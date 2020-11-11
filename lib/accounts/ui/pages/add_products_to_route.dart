import 'package:drop_here_mobile/accounts/bloc/add_products_to_route_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddProductsToRoutePage extends BlocWidget<AddProductsToRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final List<RouteProductRequest> selectedProducts;

  AddProductsToRoutePage({this.selectedProducts});
  @override
  AddProductsToRouteBloc bloc() => AddProductsToRouteBloc()..add(FetchProducts(selectedProducts: selectedProducts));

  @override
  Widget build(BuildContext context, AddProductsToRouteBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SubmitFormButton(
        isActive: true,
        text: localeBundle.submit,
        onTap: () => Get.back(result: bloc.state.selectedProducts),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localeBundle.addProductsToRoute,
              style: themeConfig.textStyles.primaryTitle,
            ),
            BlocBuilder<AddProductsToRouteBloc, AddProductsToRouteState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state.type == AddProductsToRouteStateType.initial ||
                    state.type == AddProductsToRouteStateType.loading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: [
                      for (ProductResponse product in bloc.state.products ?? [])
                        AddProductToRouteCard(
                            bloc: bloc,
                            product: product,
                            productRequest: bloc.state.selectedProducts
                                .firstWhere((element) => element.productId == product.id, orElse: () => null))
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductToRouteCard extends DhTile {
  final AddProductsToRouteBloc bloc;
  final ProductResponse product;
  final RouteProductRequest productRequest;
  AddProductToRouteCard({this.bloc, this.product, this.productRequest});

  @override
  String get title => product.name;

  @override
  String get subtitle1 => "${product.category}";

  @override
  Widget get trailing => productRequest != null ? Text("Price: ${productRequest.price}zł") : null;

  @override
  Widget get photo => Icon(Icons.shopping_basket_outlined);

  @override
  bool get selected => productRequest != null;

  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 7.0);

  @override
  String get subtitle2 => productRequest?.productAmountToString;

  @override
  onTap(BuildContext context) => selected
      ? () => bloc.add(ProductUnchecked(productId: product.id))
      : () async {
          final RouteProductRequest productWithAmount = await showDialog(
              context: context,
              child: AmountDialog(
                bloc: bloc,
                product: productRequest ?? RouteProductRequest(productId: product.id),
              ));
          if (productWithAmount != null) {
            bloc.add(ProductSelected(product: productWithAmount));
          }
        };
}

abstract class DhTile extends StatelessWidget {
  String get title;
  String get subtitle1;
  String get subtitle2;
  Widget get trailing;
  Widget get photo;
  EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0);
  bool get selected;
  VoidCallback onTap(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return GestureDetector(
      onTap: onTap(context),
      child: Padding(
        padding: padding,
        child: Container(
          child: ListTile(
            leading: _productPhoto(),
            title: Text(
              title,
              style: themeConfig.textStyles.secondaryTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _subtitleText(subtitle1),
                _subtitleText(subtitle2),
              ],
            ),
            trailing: trailing,
          ),
          decoration: BoxDecoration(
            border: selected ? Border.all(width: 2.0, color: themeConfig.colors.primary1) : null,
            color: themeConfig.colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              dhShadow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subtitleText(String text) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: text != null
          ? Text(
              text,
              style: themeConfig.textStyles.cardSubtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : SizedBox.shrink(),
    );
  }

  Widget _productPhoto() {
    return Container(
      width: 74.0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 74,
          maxHeight: 84,
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: photo),
      ),
    );
  }
}

class AmountDialog extends StatefulWidget {
  final AddProductsToRouteBloc bloc;
  final RouteProductRequest product;

  AmountDialog({this.bloc, this.product});

  @override
  _AmountDialogState createState() => _AmountDialogState();
}

class _AmountDialogState extends State<AmountDialog> {
  bool _limited;
  RouteProductRequest product;

  @override
  void initState() {
    _limited = widget.product.limitedAmount;
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(child: Text("Set price and amount", style: themeConfig.textStyles.secondaryTitle)),
          labeledSwitch(
              text: "Limited",
              initialPosition: product.limitedAmount,
              onSwitch: (unlimited) {
                setState(() {
                  _limited = unlimited;
                  product.limitedAmount = _limited;
                });
              }),
          Text("Price per unit"),
          DhPlainTextFormField(
              inputType: InputType.number,
              initialValue: product.price?.toString() ?? "",
              hintText: "9.99",
              onChanged: (String price) => setState(
                    () => product.price = double.parse(price),
                  )),
          _limited ? _buildConditionalFields(product) : SizedBox.shrink(),
          Align(
            child: SubmitFormButton(
              text: "Submit",
              onTap: () => Navigator.pop(context, product),
              isActive: (!_limited || (product.amount != null && product.amount.toString() != "")) &&
                  (product.price != null && product.price.toString() != ""),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionalFields(RouteProductRequest product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Amount"),
        DhPlainTextFormField(
            inputType: InputType.number,
            initialValue: product?.amount?.toString() ?? "",
            hintText: "15",
            onChanged: (String amount) => setState(
                  () => product.amount = double.parse(amount),
                )),
      ],
    );
  }
}
