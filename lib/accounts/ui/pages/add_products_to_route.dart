import 'package:drop_here_mobile/accounts/bloc/add_products_to_route_bloc.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_switch.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddProductsToRoutePage extends BlocWidget<AddProductsToRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final Function addProducts;
  final List<LocalProduct> selectedProducts;

  AddProductsToRoutePage(this.addProducts, this.selectedProducts);
  @override
  AddProductsToRouteBloc bloc() =>
      AddProductsToRouteBloc()..add(FetchProducts(selectedProducts.toSet()));

  @override
  Widget build(BuildContext context, AddProductsToRouteBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SubmitFormButton(
        isActive: true,
        text: locale.submit,
        onTap: () {
          ProductsFetched state = bloc.state;
          addProducts(state.selectedProducts);
          Get.back();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Text(
                locale.addProductsToRoute,
                style: themeConfig.textStyles.primaryTitle,
              ),
            ),
            DhSearchBar(bloc),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FiltersFlatButton(
                themeConfig: themeConfig,
                locale: locale,
                bloc: bloc,
              ),
            ),
            BlocBuilder<AddProductsToRouteBloc, AddProductsToRouteState>(
              builder: (context, state) {
                if (state is AddProductsToRouteInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchingError) {
                  return Container(
                      child: Column(
                    children: [
                      Text('try again'),
                      RaisedButton(
                          onPressed: () => bloc.add(FetchProducts(selectedProducts.toSet())))
                    ],
                  ));
                } else if (state is ProductsFetched) {
                  return buildColumnWithData(locale, context, bloc, state);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  SafeArea buildColumnWithData(LocaleBundle locale, BuildContext context,
      AddProductsToRouteBloc bloc, ProductsFetched state) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.productsPage.numberOfElements,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  index: index,
                  state: state,
                  bloc: bloc,
                );
              })
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductsFetched state;
  final int index;
  final AddProductsToRouteBloc bloc;

  const ProductCard({this.state, this.index, this.bloc});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
        child: Container(
          child: ListTile(
            leading: productPhoto(context, state.localProducts[index].photo),
            title: Text(
              state.productsPage.content[index].name,
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
                  '${locale.category}: ${state.productsPage.content[index].category}',
                  style: themeConfig.textStyles.cardSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 6.0,
                ),
                state.selectedProducts.contains(state.localProducts[index])
                    ? Text(
                        '${locale.price}: ${state.selectedProducts.firstWhere((element) => element == state.localProducts[index]).price.toString()}${locale.currency}/${state.localProducts[index].unit}',
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
                    onChanged: (bool value) {
                      if (value) {
                        dhShowDialog(context, themeConfig, locale);
                        print(state.selectedProducts.contains(state.productsPage.content[index]));
                      } else {
                        bloc.add(RemoveProductFromSelected(
                            state.localProducts.toList()[index],
                            state.productsPage,
                            state.selectedProducts,
                            state.localProducts.toSet()));
                        print(state.selectedProducts.contains(state.productsPage.content[index]));
                      }
                    },
                    value: state.selectedProducts.contains(state.localProducts[index]),
                  ),
                  showAmount(themeConfig, locale),
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

  Future dhShowDialog(BuildContext context, ThemeConfig themeConfig, LocaleBundle locale) {
    TextEditingController amountController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.localProducts[index].name,
                  style: themeConfig.textStyles.secondaryTitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.unlimited,
                      style: themeConfig.textStyles.contentTitle,
                    ),
                    DhSwitch(
                      initialPosition: state.localProducts[index].unlimited ?? false,
                      onSwitch: (bool value) {
                        bloc.add(ToggleAmount(
                          value,
                          state.localProducts[index],
                          state.productsPage,
                          state.selectedProducts,
                          state.localProducts.toSet(),
                        ));
                        print(value);
                      },
                    ),
                  ],
                ),
                state.localProducts[index].unlimited == null ||
                        state.localProducts[index].unlimited == false
                    ? rowWithTextField(locale.amount, themeConfig, amountController)
                    : SizedBox.shrink(),
                rowWithTextField(locale.pricePerUnit, themeConfig, priceController),
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  amountController.text.toString() != null && amountController.text.toString() != ''
                      ? state.localProducts[index].amount =
                          double.parse(amountController.text.toString())
                      : null;

                  state.localProducts[index].price = double.parse(priceController.text.toString());
                  print(double.parse(priceController.text.toString()));
                  bloc.add(AddProductToSelected(state.localProducts[index], state.productsPage,
                      state.selectedProducts, state.localProducts.toSet()));
                  Navigator.of(context).pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 14.0),
                  child: Text(
                    locale.submit,
                    style: themeConfig.textStyles.submitButtonTextStyle,
                  ),
                ),
              )
            ],
          );
        });
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

  Widget showAmount(ThemeConfig themeConfig, LocaleBundle locale) {
    if (state.localProducts[index].unlimited ?? false)
      return Text(
        locale.amount + ': ' + locale.unlimited,
        style: themeConfig.textStyles.cardSubtitle,
      );
    return state.selectedProducts.contains(state.localProducts[index]) &&
            state.localProducts[index].amount != null
        ? Text(
            locale.amount +
                ': ' +
                state.localProducts[index].amount.toString() +
                state.localProducts[index].unit,
            style: themeConfig.textStyles.cardSubtitle,
          )
        : SizedBox.shrink();
  }
}
