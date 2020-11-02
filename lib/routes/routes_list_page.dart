import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/bloc/routes_list_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RoutesListPage extends BlocWidget<RoutesListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  RoutesListBloc bloc() => RoutesListBloc()..add(FetchRoutes());

  @override
  Widget build(BuildContext context, RoutesListBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 25.0),
              child: Text(
                locale.routes,
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
            BlocBuilder<RoutesListBloc, RoutesListState>(
              builder: (context, state) {
                if (state is RoutesListInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RoutesFetched) {
                  return buildColumnWithData(locale, state, context, bloc);
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
      LocaleBundle locale, RoutesFetched state, BuildContext context, RoutesListBloc bloc) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.routePage.numberOfElements,
              itemBuilder: (BuildContext context, int index) {
                return RouteCard(
                  route: state.routePage.content[index],
                  popupOptions: [locale.edit, locale.delete],
                );
              }),
        ],
      ),
    );
  }
}

class RouteCard extends StatelessWidget {
  final RouteShortResponse route;

  final List<String> popupOptions;

  const RouteCard({this.route, this.popupOptions});

  @override
  //TODO add shadow and change dots icon
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: Container(
        child: ListTile(
          leading: IconInCircle(
            themeConfig: themeConfig,
            icon: Icons.assistant_direction,
          ),
          title: Text(
            route.name,
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
              //TODO add status if available
              // Text(
              //   '${locale.status}: ${route.}',
              //   style: themeConfig.textStyles.cardSubtitle,
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
              // SizedBox(
              //   height: 6.0,
              // ),
              Text(
                '${locale.numberOfDrops}: ${route.dropsAmount}',
                style: themeConfig.textStyles.cardSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: themeConfig.colors.black,
              size: 30.0,
            ),
            onSelected: (_) {},
            itemBuilder: (BuildContext context) {
              return popupOptions.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: themeConfig.textStyles.popupMenu,
                  ),
                );
              }).toList();
            },
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
}
