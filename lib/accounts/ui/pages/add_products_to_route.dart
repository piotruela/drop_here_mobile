import 'package:drop_here_mobile/accounts/bloc/add_products_to_route_bloc.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
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
  AddProductsToRouteBloc bloc() => AddProductsToRouteBloc()
    ..add(FetchProducts(selectedProducts.toSet())); //..add(FetchProducts());

  @override
  Widget build(BuildContext context, AddProductsToRouteBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      floatingActionButton: SubmitFormButton(
        isActive: true,
        text: locale.submit,
        onTap: () {
          //TODO add function
          ProductsFetched state = bloc.state;
          addProducts(state.selectedProducts);
          //addSpot(bloc.state.spots[bloc.state.radioValue]);
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
                if (state is ProductsInitial) {
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
    return Padding(
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
              Text(
                '${locale.price}: ${state.productsPage.content[index].price.toString()}${locale.currency}/${state.productsPage.content[index].unit}',
                style: themeConfig.textStyles.cardSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          trailing:
              // BlocBuilder<AddProductsToRouteBloc, AddProductsToRouteState>(
              //   //buildWhen: (previous, current) => previous. != current.isFilled(),
              //   builder: (context, s) =>
              Checkbox(
            onChanged: (bool value) {
              if (value) {
                LocalProduct product = LocalProduct(state.productsPage.content[index]);
                //LocalProduct p1 = state.localProducts[index];
                //state.selectedProducts.add(product);
                bloc.add(AddProductToSelected(state.productsPage.content[index], state.productsPage,
                    state.selectedProducts, state.localProducts.toSet()));
                print(state.selectedProducts.contains(state.productsPage.content[index]));
              } else {
                state.selectedProducts.remove(state.productsPage.content[index]);
                bloc.add(RemoveProductFromSelected(state.productsPage.content[index],
                    state.productsPage, state.selectedProducts, state.localProducts.toSet()));

                print(state.selectedProducts.contains(state.productsPage.content[index]));
              }
            },
            value: state.selectedProducts.contains(LocalProduct(state.productsPage.content[index])),
          ),
          //),
          // trailing: Checkbox(
          //   onChanged: (bool value) {
          //     if (value) {
          //       state.selectedProducts.add(state.products.content[index]);
          //     } else {
          //       state.selectedProducts.remove(state.products.content[index]);
          //     }
          //   },
          //   value: state.selectedProducts.contains(state.products.content[index]),
          // ),
        ),
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
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
        // child: ClipRRect(
        //     borderRadius: BorderRadius.circular(10.0),
        //     child: Container(
        //       child: Text('a'),
        //     )),
      ),
    );
  }
}
