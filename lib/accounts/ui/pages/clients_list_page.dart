import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_card.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ClientsListPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final DhListBloc dhListBloc;

  ClientsListPage({this.dhListBloc});

  @override
  DhListBloc bloc() => dhListBloc;

  @override
  Widget build(BuildContext context, DhListBloc dhListBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DhSearchBar(dhListBloc),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: GestureDetector(
            onTap: () => {dhListBloc.add(FilterClients())},
            child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: themeConfig.colors.addSthHere),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.filter_list),
                  Text(
                    locale.filters,
                  ),
                ],
              ),
            ),
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
            } else if (state is ClientsFetched) {
              return buildColumnWithData(locale, state, context, dhListBloc);
            }
            return Container();
          },
        ),
      ],
    );
  }

  FlatButton buildFlatButton(BuildContext context, String text, ThemeConfig themeConfig) {
    return FlatButton(
      onPressed: () => {},
      child: Container(
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        width: (MediaQuery.of(context).size.width - 130) / 3,
        height: 40.0,
        alignment: Alignment.center,
        child: Text(
          text,
          style: themeConfig.textStyles.secondaryTitle,
        ),
      ),
    );
  }

  SafeArea buildColumnWithData(
      LocaleBundle locale, ClientsFetched state, BuildContext context, DhListBloc bloc) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.clients.length,
              itemBuilder: (BuildContext context, int index) {
                return DhCard(
                  title: state.clients[index].name,
                  isActive: state.clients[index].isActive,
                  dropsNumber: state.clients[index].numberOfDropsMember,
                );
              }),
        ],
      ),
    );
  }
}
