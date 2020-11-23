import 'package:drop_here_mobile/accounts/bloc/list_bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/ui/pages/add_products_to_route.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/ui/pages/shipment_details_page.dart';
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
              itemBuilder: (BuildContext context, int index) =>
                  ShipmentTile(shipment: state.shipments.elementAt(index), localeBundle: localeBundle)),
        ],
      ),
    );
  }
}

class ShipmentTile extends DhTile {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final ShipmentResponse shipment;
  final LocaleBundle localeBundle;

  ShipmentTile({this.shipment, this.localeBundle});

  @override
  onTap(BuildContext context) => () => Get.to(ShipmentDetailsPage(shipmentId: shipment.id));

  @override
  Widget get photo => IconInCircle(
        icon: Icons.list_alt,
        themeConfig: themeConfig,
      );

  @override
  bool get selected => false;

  @override
  String get subtitle1 => '${localeBundle.status}: ${describeEnum(shipment.status)}';

  @override
  String get subtitle2 => '${formatPrice(shipment.summarizedAmount)}';

  @override
  String get title => "Order No. ${shipment.id.toString()}";

  @override
  Widget get trailing => null;
}
