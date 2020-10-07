import 'package:drop_here_mobile/accounts/bloc/product_details_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends BlocWidget<ProductDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  bloc() => ProductDetailsBloc()..add(FetchProductDetails());

  @override
  Widget build(BuildContext context, ProductDetailsBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(builder: (context, state) {
      if (state is ProductDetailsInitial) {
        return CircularProgressIndicator();
      } else if (state is ProductDetailsFetched) {
        return buildColumnWithData(state, locale, context);
      }
      return Container();
    }));
  }

  SafeArea buildColumnWithData(
      ProductDetailsFetched state, LocaleBundle locale, BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 10.0),
            child: Text(
              state.product.name,
              style: themeConfig.textStyles.primaryTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 2.0),
            child: Text(
              state.product.category,
              style: themeConfig.textStyles.category,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Image.network(
                //TODO change image
                'https://picsum.photos/850?image=9',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                descriptionAndData(locale, state, locale.description, state.product.description),
                descriptionAndData(locale, state, locale.unitType, state.product.unit),
                descriptionAndData(
                    locale, state, locale.pricePerUnit, state.product.price.toString()),
                descriptionAndData(
                    locale, state, locale.unitFraction, state.product.unitFraction.toString()),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                  child: Text(
                    locale.availableInDrops,
                    style: themeConfig.textStyles.title2,
                  ),
                ),
                Row(
                  children: [
                    mapCard(),
                    mapCard(),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mapCard() {
    return Padding(
      padding: const EdgeInsets.only(right: 22.0),
      child: Container(
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 154,
              height: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drop No. 2',
                    style: themeConfig.textStyles.title3,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Monaday, 8 am - 1pm',
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Available: 30kg',
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 10.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column descriptionAndData(
      LocaleBundle locale, ProductDetailsFetched state, String description, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 9.0,
        ),
        Text(
          description,
          style: themeConfig.textStyles.dataAnnotation,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          data,
          style: themeConfig.textStyles.data,
        ),
      ],
    );
  }
}
