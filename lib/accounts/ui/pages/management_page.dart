import 'package:drop_here_mobile/accounts/bloc/company_management_bloc.dart';
import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/sellers_list_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'clients_list_page.dart';
import 'company_page.dart';

class ManagementPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  DhListBloc bloc() => DhListBloc()..add(FetchClients());

  @override
  Widget build(BuildContext context, DhListBloc dhListBloc, _) {
    DhListBloc dhListBlocSellers = DhListBloc();
    CompanyManagementBloc companyManagementBloc = CompanyManagementBloc();
    final LocaleBundle locale = Localization.of(context).bundle;
    return SafeArea(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: DefaultTabController(
              length: 3,
              child: Scaffold(
                  body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 30.0, bottom: 12.0),
                    child: Text(
                      locale.management,
                      style: themeConfig.textStyles.primaryTitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: themeConfig.colors.white, borderRadius: BorderRadius.circular(20)),
                      //labelStyle: TextStyle(color: Colors.black),
                      //unselectedLabelColor: themeConfig.colors.primary1,
                      tabs: <Widget>[
                        Tab(
                            child: Text(locale.clients,
                                style: TextStyle(fontSize: 18.0, color: themeConfig.colors.black))),
                        Tab(
                            child: Text(locale.sellers,
                                style: TextStyle(fontSize: 18.0, color: themeConfig.colors.black))),
                        Tab(
                            child: Text(locale.company,
                                style: TextStyle(fontSize: 18.0, color: themeConfig.colors.black))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TabBarView(
                      children: [
                        ClientsListPage(
                          dhListBloc: dhListBloc,
                        ),
                        SellersListPage(
                          dhListBloc: dhListBlocSellers,
                        ),
                        CompanyPage(
                          companyManagementBloc: companyManagementBloc,
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ),
          )),
    );
  }

  Widget _buildTabBar(context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          decoration: BoxDecoration(
              //color: Theme.of(context).backgroundColor,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(50),
              //   topRight: Radius.circular(50),
              // ),
              ),
          padding: EdgeInsets.only(
            top: 50,
            left: 20,
            right: 20,
          ),
          height: 100,
          child: TabBar(
            indicator: BoxDecoration(
                color: themeConfig.colors.white, borderRadius: BorderRadius.circular(20)),
            //labelStyle: TextStyle(color: Colors.black),
            //unselectedLabelColor: themeConfig.colors.primary1,
            tabs: <Widget>[
              Tab(
                  child:
                      Text('A', style: TextStyle(fontSize: 18.0, color: themeConfig.colors.black))),
              Tab(
                  child:
                      Text('B', style: TextStyle(fontSize: 18.0, color: themeConfig.colors.black))),
              Tab(
                  child:
                      Text('C', style: TextStyle(fontSize: 18.0, color: themeConfig.colors.black))),
            ],
          ),
        ));
  }
}
