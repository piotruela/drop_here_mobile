import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_card.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/subscription.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SellersListPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final DhListBloc dhListBloc;

  SellersListPage({this.dhListBloc});

  @override
  DhListBloc bloc() => dhListBloc;

  @override
  void init(BuildContext context, Bloc bloc, SubscriptionManager subscriptionManager) {
    super.init(context, bloc, subscriptionManager);
    dhListBloc.add(FetchSellers());
  }

  @override
  Widget build(BuildContext context, DhListBloc dhListBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DhSearchBar(dhListBloc),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FiltersFlatButton(
                themeConfig: themeConfig,
                locale: locale,
                bloc: dhListBloc,
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
              return buildColumnWithData(locale, state, context, dhListBloc);
            }
            return Container();
          },
        ),
      ],
    );
  }

  FlatButton addSellerButton(LocaleBundle locale) {
    return FlatButton(
      onPressed: () {},
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
          child: Text(
            locale.addSeller,
            style: themeConfig.textStyles.coloredFlatButton,
          ),
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
                return DhCard(
                  title: state.sellers[index].name + ' ' + state.sellers[index].surname,
                  isActive: state.sellers[index].isActive,
                  popupOptions: [
                    state.sellers[index].isActive ? locale.markAsInactive : locale.markAsActive,
                  ],
                );
              }),
        ],
      ),
    );
  }
}
