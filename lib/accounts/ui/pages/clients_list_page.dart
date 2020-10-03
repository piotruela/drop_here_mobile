import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/services/clients_list_service.dart';
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
  @override
  Widget build(BuildContext context, DhListBloc dhListBloc, _) {
    dhListBloc.add(FetchClients());
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: BlocBuilder<DhListBloc, DhListState>(
        builder: (context, state) {
          if (state is DhListInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FetchingError) {
            return Container(child: Text(state.error));
          } else if (state is ClientsFetched) {
            return buildColumnWithData(locale, state);
          }
          return Container();
        },
      ),
    );
  }

  SafeArea buildColumnWithData(LocaleBundle locale, ClientsFetched state) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              locale.persons,
              style: themeConfig.textStyles.primaryTitle,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              FlatButton(
                child: Container(
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  width: 190.0,
                  height: 40.0,
                  alignment: Alignment.center,
                  child: Text(
                    locale.clients,
                    style: themeConfig.textStyles.secondaryTitle,
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  locale.sellers,
                  style: themeConfig.textStyles.secondaryTitle,
                ),
              ),
            ],
          ),
          DhSearchBar(),
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

  @override
  DhListBloc bloc() => DhListBloc(FakeClientsListService());
}
