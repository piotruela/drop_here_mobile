import 'package:drop_here_mobile/accounts/bloc/add_products_to_route_bloc.dart';
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

  AddProductsToRoutePage();
  @override
  AddProductsToRouteBloc bloc() =>
      AddProductsToRouteBloc()..add(FetchProducts()); //..add(FetchProducts());

  @override
  Widget build(BuildContext context, AddProductsToRouteBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      floatingActionButton: SubmitFormButton(
        isActive: true,
        text: locale.submit,
        onTap: () {
          //TODO add function
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
                      RaisedButton(onPressed: () => bloc.add(FetchProducts()))
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
              itemCount: state.products.numberOfElements,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  title: state.products.content[index].name,
                  unit: state.products.content[index].unit,
                  category: state.products.content[index].category,
                  price: state.products.content[index].price,
                );
              })
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final double price;
  final String unit;
  final Image photo;

  const ProductCard({this.title, this.category, this.price, this.unit, this.photo});

  @override
  //TODO add shadow and change dots icon
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: Container(
        child: ListTile(
          leading: productPhoto(context),
          title: Text(
            title,
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
                '${locale.category}: $category',
                style: themeConfig.textStyles.cardSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                '${locale.price}: ${price.toString()}${locale.currency}/$unit',
                style: themeConfig.textStyles.cardSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Checkbox(
            onChanged: (bool value) {},
            value: false,
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
    );
  }

  Widget productPhoto(BuildContext context) {
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
