import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/sellers_list_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'clients_list_page.dart';

class ManagementPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  DhListBloc bloc() => DhListBloc()..add(FetchClients());

  @override
  Widget build(BuildContext context, DhListBloc dhListBloc, _) {
    DhListBloc dhListBlocSellers = DhListBloc();
    final LocaleBundle locale = Localization.of(context).bundle;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: themeConfig.colors.primary1,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(locale.clients),
                ),
                Tab(
                  child: Text(locale.sellers),
                ),
                Tab(
                  child: Text(locale.company),
                ),
              ],
            ),
            title: Text(
              locale.management,
            ),
          ),
          backgroundColor: themeConfig.colors.background,
          body: TabBarView(
            children: [
              ClientsListPage(
                dhListBloc: dhListBloc,
              ),
              SellersListPage(
                dhListBloc: dhListBlocSellers,
              ),
              Container(),
            ],
          )),
    );
  }
}
