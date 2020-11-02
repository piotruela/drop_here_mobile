import 'package:drop_here_mobile/accounts/bloc/add_products_to_route_bloc.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddProductsToRoutePage extends BlocWidget<AddProductsToRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final Set<LocalProduct> selectedProducts;

  AddProductsToRoutePage(this.selectedProducts);
  @override
  AddProductsToRouteBloc bloc() =>
      AddProductsToRouteBloc()..add(FetchProducts(selectedProducts: selectedProducts));

  @override
  Widget build(BuildContext context, AddProductsToRouteBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SubmitFormButton(
        isActive: true,
        text: localeBundle.submit,
        onTap: () => Get.back(result: selectedProducts),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Text(
                localeBundle.addProductsToRoute,
                style: themeConfig.textStyles.primaryTitle,
              ),
            ),
            DhSearchBar(bloc),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FiltersFlatButton(
                themeConfig: themeConfig,
                locale: localeBundle,
                bloc: bloc,
              ),
            ),
            BlocBuilder<AddProductsToRouteBloc, AddProductsToRouteState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state.type == AddProductsToRouteStateType.initial ||
                    state.type == AddProductsToRouteStateType.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.type == AddProductsToRouteStateType.error) {
                  return Container(
                      child: Column(
                    children: [
                      Text('try again'),
                      RaisedButton(
                          onPressed: () =>
                              bloc.add(FetchProducts(selectedProducts: selectedProducts)))
                    ],
                  ));
                } else {
                  return buildColumnWithData(localeBundle, context, bloc, state);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColumnWithData(LocaleBundle localeBundle, BuildContext context,
      AddProductsToRouteBloc bloc, AddProductsToRouteState state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.productsPage?.numberOfElements,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            bloc: bloc,
            product: state.localProducts?.elementAt(index),
            pricePerAmount: state.selectedProducts
                ?.lookup(state.localProducts.elementAt(index))
                ?.pricePerAmount,
          );
        });
  }
}

class ProductCard extends StatelessWidget {
  final LocalProduct product;
  final VoidCallback onTap;
  final String pricePerAmount;
  final AddProductsToRouteBloc bloc;

  const ProductCard({this.product, this.onTap, this.pricePerAmount, this.bloc});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return GestureDetector(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
        child: Container(
          child: ListTile(
            leading: productPhoto(context, product.photo),
            title: Text(
              product.name,
              style: themeConfig.textStyles.secondaryTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${localeBundle.category}: ${product.category}',
                  style: themeConfig.textStyles.cardSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 6.0,
                ),
                pricePerAmount != null
                    ? Text(
                        product.unlimited ? "unlimited" : product.amount.toString(),
                        style: themeConfig.textStyles.cardSubtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : SizedBox.shrink(),
              ],
            ),
            trailing: Container(
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: pricePerAmount != null,
                      onChanged: (bool) async {
                        if (pricePerAmount.isNull) {
                          bloc.add(ProductSelected(product: product));
                          LocalProduct productWithAmount = await showDialog(
                              context: context,
                              child: AmountDialog(
                                initialUnlimited: product.unlimited,
                                productWithAmount: product,
                                bloc: bloc,
                              ));
                          if (productWithAmount != null) {
                            bloc.add(AmountSelected(product: productWithAmount));
                          }
                        } else {
                          bloc.add(ProductUnchecked(product: product));
                        }
                      }),
                  Text(pricePerAmount ?? "")
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
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

  Padding rowWithTextField(String text, ThemeConfig themeConfig, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: themeConfig.textStyles.dataAnnotation,
          ),
          Container(
              width: 60.0,
              height: 25.0,
              child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: themeConfig.colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: themeConfig.colors.black),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: themeConfig.colors.black),
                    ),
                  )))
        ],
      ),
    );
  }

  Widget productPhoto(BuildContext context, Image photo) {
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
  final bool initialUnlimited;
  final LocalProduct productWithAmount;

  AmountDialog({this.bloc, this.initialUnlimited, this.productWithAmount});

  @override
  _AmountDialogState createState() => _AmountDialogState();
}

class _AmountDialogState extends State<AmountDialog> {
  bool _unlimited;
  LocalProduct product;

  @override
  void initState() {
    _unlimited = widget.initialUnlimited;
    product = widget.productWithAmount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              child: Text(widget.productWithAmount.name,
                  style: themeConfig.textStyles.secondaryTitle)),
          labeledSwitch(
              text: localeBundle.unlimited,
              initialPosition: widget.initialUnlimited,
              onSwitch: (unlimited) {
                setState(() {
                  _unlimited = unlimited;
                  product.unlimited = unlimited;
                  widget.bloc.add(UnlimitedToggleChanged(unlimited: _unlimited));
                });
              }),
          !_unlimited ? _buildConditionalFields(product) : SizedBox.shrink(),
          Align(
            child: RaisedButton(
              child: Text("Submit", style: themeConfig.textStyles.active),
              onPressed: () => Navigator.pop(context, product),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionalFields(LocalProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Amount"),
        DhPlainTextFormField(
            inputType: InputType.number,
            hintText: "420",
            onChanged: (String amount) => product.amount = double.parse(amount)),
        Text("Price per unit"),
        DhPlainTextFormField(
            inputType: InputType.number,
            hintText: "123",
            onChanged: (String price) => product.price = double.parse(price)),
      ],
    );
  }
}
