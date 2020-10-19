import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/product_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProductsListPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final DhListBloc dhListBloc = DhListBloc();
  @override
  DhListBloc bloc() => dhListBloc..add(FetchProducts());

  @override
  Widget build(BuildContext context, DhListBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 25.0),
              child: Text(
                locale.products,
                style: themeConfig.textStyles.primaryTitle,
              ),
            ),
            DhSearchBar(dhListBloc),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FiltersFlatButton(
                themeConfig: themeConfig,
                locale: locale,
                bloc: dhListBloc,
              ),
            ),
            BlocBuilder<DhListBloc, DhListState>(
              builder: (context, state) {
                if (state is DhListInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ListLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchingError) {
                  return Container(child: Text(state.error));
                } else if (state is ProductsFetched) {
                  return buildColumnWithData(locale, state, context, dhListBloc);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  SafeArea buildColumnWithData(
      LocaleBundle locale, ProductsFetched state, BuildContext context, DhListBloc bloc) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  title: state.products[index].name,
                  category: state.products[index].category,
                  price: state.products[index].price,
                  unit: state.products[index].unit,
                  popupOptions: [locale.delete, locale.edit],
                  photo: state.products[index].photo,
                );
              }),
        ],
      ),
    );
  }
}
