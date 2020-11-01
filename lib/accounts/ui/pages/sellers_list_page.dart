import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/model/seller.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_card.dart';
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

class SellersListPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  DhListBloc bloc() => DhListBloc()..add(FetchSellers());

  @override
  Widget build(BuildContext context, DhListBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DhSearchBar(bloc),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FiltersFlatButton(
                themeConfig: themeConfig,
                locale: locale,
                bloc: bloc,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: addSellerButton(locale),
            ),
          ],
        ),
        BlocBuilder<DhListBloc, DhListState>(
          builder: (context, state) {
            if (state is DhListInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FetchingError) {
              return Container(child: Text(state.error));
            } else if (state is SellersFetched) {
              return buildColumnWithData(locale, state, context, bloc);
            }
            return Container();
          },
        ),
      ],
    );
  }

  FlatButton addSellerButton(LocaleBundle locale) {
    return FlatButton(
      onPressed: () => Get.to(CreateRegularProfilePage()),
      child: Container(
        height: 30.0,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: themeConfig.colors.white,
            boxShadow: [
              dhShadow(),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Center(
          child: Text(locale.addSeller, style: themeConfig.textStyles.coloredFlatButton),
        ),
      ),
    );
  }

  SafeArea buildColumnWithData(
      LocaleBundle locale, SellersFetched state, BuildContext context, DhListBloc bloc) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.sellers.length,
              itemBuilder: (BuildContext context, int index) {
                final Seller seller = state.sellers.elementAt(index);
                return DhCard(
                  title: seller.fullName,
                  status: seller.status,
                );
              }),
        ],
      ),
    );
  }
}
