import 'package:drop_here_mobile/accounts/bloc/list_bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ShipmentsListPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  DhListBloc bloc() => DhListBloc()..add(FetchShipments());

  @override
  Widget build(BuildContext context, DhListBloc bloc, _) {
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
        BlocBuilder<DhListBloc, DhListState>(
          builder: (context, state) {
            if (state is DhListInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FetchingError) {
              return Container(child: Text(state.error));
            } else if (state is ShipmentsFetched) {
              return buildColumnWithData(localeBundle, state, context, bloc);
            }
            return Container();
          },
        ),
      ],
    );
  }

  SafeArea buildColumnWithData(
      LocaleBundle localeBundle, ShipmentsFetched state, BuildContext context, DhListBloc bloc) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.shipments.length,
              itemBuilder: (BuildContext context, int index) => Text(state.shipments.elementAt(index).id.toString())),
        ],
      ),
    );
  }
}
