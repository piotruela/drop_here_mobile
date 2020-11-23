import 'package:drop_here_mobile/accounts/bloc/list_bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/product_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/add_new_item_panel.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/ui/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductsListPage extends BlocWidget<DhListBloc> {
  final PanelController controller = PanelController();
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final DhListBloc dhListBloc = DhListBloc();
  @override
  DhListBloc bloc() => dhListBloc..add(FetchProducts());

  @override
  Widget build(BuildContext context, DhListBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 25.0),
                child: Text(
                  locale.products,
                  style: themeConfig.textStyles.primaryTitle,
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
          AddNewItemPanel(controller: controller)
        ],
      ),
      bottomNavigationBar: CompanyBottomBar(
        sectionIndex: 1,
        controller: controller,
      ),
    );
  }

  Widget buildColumnWithData(LocaleBundle locale, ProductsFetched state, BuildContext context, DhListBloc bloc) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.products.length,
          itemBuilder: (BuildContext context, int index) {
            final ProductResponse product = state.products[index];
            return ProductCard(
              product: product,
              popupOptions: [locale.delete],
              bloc: bloc,
              onTap: () => Get.to(ProductDetailsPage(
                product: product,
                backAction: () => Get.to(ProductsListPage()),
              )),
            );
          }),
    );
  }
}
