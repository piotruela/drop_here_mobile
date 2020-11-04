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
      AddProductsToRouteBloc()..add(FetchProducts(selectedProducts: selectedProducts ?? {}));

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
      body: Column(
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
    );
  }

  Widget buildColumnWithData(LocaleBundle localeBundle, BuildContext context,
      AddProductsToRouteBloc bloc, AddProductsToRouteState state) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.productsPage?.numberOfElements,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
              bloc: bloc,
              product: state.localProducts?.elementAt(index),
              selected1: state.selectedProducts
                  .any((element) => element.name == state.localProducts?.elementAt(index)?.name),
            );
          }),
    );
  }
}

class ProductCard extends DhTile {
  final AddProductsToRouteBloc bloc;
  final LocalProduct product;
  final bool selected1;
  ProductCard({this.bloc, this.product, this.selected1});

  @override
  String get title => product.name;

  @override
  String get subtitle1 => "Category: ${product.category}";

  @override
  Widget get trailing => selected1
      ? Column(
          children: [
            Text("Price: ${product.pricePerAmount}"),
            Text("Amount: ${product.unlimited ? "unlimited" : product.amount}"),
          ],
        )
      : null;

  @override
  Image get photo => product.photo;

  @override
  bool get selected => selected1;

  @override
  String get subtitle2 => null;

  @override
  onTap(BuildContext context) => selected
      ? () => bloc.add(ProductUnchecked(product: product))
      : () async {
          bloc.add(ProductSelected(product: product));
          final LocalProduct productWithAmount = await showDialog(
              context: context,
              child: AmountDialog(
                  initialUnlimited: product.unlimited, bloc: bloc, selectedProduct: product));
          if (productWithAmount != null) {
            bloc.add(AmountSelected(product: productWithAmount));
          }
        };
}

abstract class DhTile extends StatelessWidget {
  String get title;
  String get subtitle1;
  String get subtitle2;
  Widget get trailing;
  Image get photo;
  bool get selected;
  VoidCallback onTap(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return GestureDetector(
      onTap: onTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
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
  final bool initialUnlimited;
  final LocalProduct selectedProduct;

  AmountDialog({this.bloc, this.initialUnlimited, this.selectedProduct});

  @override
  _AmountDialogState createState() => _AmountDialogState();
}

class _AmountDialogState extends State<AmountDialog> {
  bool _unlimited;
  LocalProduct product;

  @override
  void initState() {
    _unlimited = widget.initialUnlimited;
    product = widget.selectedProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              child:
                  Text(widget.selectedProduct.name, style: themeConfig.textStyles.secondaryTitle)),
          labeledSwitch(
              text: localeBundle.unlimited,
              initialPosition: widget.initialUnlimited,
              onSwitch: (unlimited) {
                setState(() {
                  _unlimited = unlimited;
                  product.unlimited = _unlimited;
                });
              }),
          Text("Price per unit"),
          DhPlainTextFormField(
              inputType: InputType.number,
              initialValue: product.price.toString(),
              hintText: "9.99",
              onChanged: (String price) => setState(
                    () => product.price = double.parse(price),
                  )),
          !_unlimited ? _buildConditionalFields(product) : SizedBox.shrink(),
          Align(
            child: SubmitFormButton(
              text: "Submit",
              onTap: () => Navigator.pop(context, product),
              isActive:
                  (_unlimited || (product.amount != null && product.amount.toString() != "")) &&
                      (product.price != null && product.price.toString() != ""),
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
            initialValue: product?.amount?.toString() ?? "",
            hintText: "15",
            onChanged: (String amount) => setState(
                  () => product.amount = double.parse(amount),
                )),
      ],
    );
  }
}
