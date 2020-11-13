import 'package:drop_here_mobile/accounts/ui/pages/add_products_to_route.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/bloc/routes_list_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/ui/pages/route_details_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RoutesListPage extends BlocWidget<RoutesListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  RoutesListBloc bloc() => RoutesListBloc()..add(FetchRoutes());

  @override
  Widget build(BuildContext context, RoutesListBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DhSearchBar(bloc),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: FiltersFlatButton(
            themeConfig: themeConfig,
            locale: localeBundle,
            bloc: bloc,
          ),
        ),
        BlocBuilder<RoutesListBloc, RoutesListState>(
          builder: (context, state) {
            if (state.type == RoutesListStateType.initial) {
              return Center(child: CircularProgressIndicator());
            } else if (state.type == RoutesListStateType.routes_fetched ||
                state.type == RoutesListStateType.route_deleted) {
              return buildColumnWithData(localeBundle, state, context, bloc);
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget buildColumnWithData(LocaleBundle locale, RoutesListState state, BuildContext context, RoutesListBloc bloc) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.routePage.numberOfElements,
          itemBuilder: (BuildContext context, int index) {
            return RouteCard(
              route: state.routePage.content[index],
              bloc: bloc,
              locale: locale,
            );
          }),
    );
  }
}

class RouteCard extends DhTile {
  final RouteShortResponse route;
  final RoutesListBloc bloc;
  final LocaleBundle locale;
  RouteCard({this.route, this.bloc, this.locale});
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  onTap(BuildContext context) => () => Get.to(RouteDetailsPage(routeId: route.id));

  @override
  Widget get photo => IconInCircle(
        icon: Icons.assistant_direction,
        themeConfig: themeConfig,
      );

  @override
  bool get selected => false;

  @override
  String get subtitle1 => '${locale.status}: ${describeEnum(route.status)}';

  @override
  String get subtitle2 => '${locale.numberOfDrops}: ${route.dropsAmount}';

  @override
  String get title => route.name;

  @override
  Widget get trailing => PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: themeConfig.colors.black,
          size: 30.0,
        ),
        onSelected: (_) {},
        itemBuilder: (context) => <PopupMenuItem<String>>[
          new PopupMenuItem<String>(
              child: GestureDetector(
            child: Text(Localization.of(context).bundle.delete),
            onTap: () {
              bloc.add(DeleteRoute(route.id.toString()));
              Navigator.pop(context);
            },
          )),
        ],
      );
}
