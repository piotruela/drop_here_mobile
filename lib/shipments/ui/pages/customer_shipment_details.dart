import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/info_text.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_circled_info.dart';
import 'package:drop_here_mobile/common/ui/widgets/narrow_tile.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/shipments/bloc/customer_shipment_details_bloc/customer_shipment_details_bloc.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:drop_here_mobile/shipments/ui/pages/customer_shipments_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';

class CustomerShipmentDetailsPage extends BlocWidget<CustomerShipmentDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int shipmentId;

  CustomerShipmentDetailsPage({this.shipmentId});

  @override
  CustomerShipmentDetailsBloc bloc() =>
      CustomerShipmentDetailsBloc()..add(FetchShipmentDetails(shipmentId: shipmentId));

  @override
  Widget build(BuildContext context, CustomerShipmentDetailsBloc bloc, _) {
    return Scaffold(
      body: BlocBuilder<CustomerShipmentDetailsBloc, CustomerShipmentDetailsState>(
        buildWhen: (previous, current) => previous.type != current.type,
        builder: (context, state) => Conditional.single(
            context: context,
            conditionBuilder: (_) => state.type == CustomerShipmentDetailsStateType.shipment_fetched,
            widgetBuilder: (_) => _buildContent(context, bloc),
            fallbackBuilder: (_) => Center(child: CircularProgressIndicator())),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CustomerShipmentDetailsBloc bloc) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    final ShipmentResponse shipmentResponse = bloc.state.shipment;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DhBackButton(
              padding: EdgeInsets.zero,
              backAction: () => Get.to(CustomerShipmentsListPage()),
            ),
            Text(
              "Order No. ${shipmentResponse.id.toString()}",
              style: themeConfig.textStyles.primaryTitle,
            ),
            LabeledCircledInfoWithDivider(
              label: "Summarized price",
              text: formatPrice(shipmentResponse.summarizedAmount),
            ),
            LabeledCircledInfoWithDivider(
              label: "No. of products",
              text: shipmentResponse.products.length.toString(),
            ),
            LabeledCircledInfoWithDivider(
              label: "Company name",
              text: shipmentResponse.companyName,
            ),
            LabeledCircledInfo(
              label: "Status",
              text: describeEnum(shipmentResponse.status),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: ConditionalSwitch.list(
                        context: context,
                        valueBuilder: (_) => bloc.state.shipment.status,
                        caseBuilders: {
                          ShipmentStatus.PLACED: (BuildContext context) => <Widget>[
                                _changeStatusButton(bloc, CustomerDecision.CANCEL),
                              ],
                          ShipmentStatus.ACCEPTED: (BuildContext context) => <Widget>[
                                _changeStatusButton(bloc, CustomerDecision.CANCEL),
                              ],
                        },
                        fallbackBuilder: (_) => [InfoText(text: "You cannot change this state")])),
              ),
            ),
            annotationText("Customer comment"),
            Text(
              shipmentResponse.customerComment ?? localeBundle.noContent,
              style: themeConfig.textStyles.data,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: annotationText("Products"),
            ),
            productsCarousel(localeBundle, shipmentResponse.products),
            annotationText("Order flow"),
            orderFlowDiagram(shipmentResponse.flows),
          ],
        ),
      ),
    );
  }

  Text annotationText(String text) {
    return Text(
      text,
      style: themeConfig.textStyles.dataAnnotation,
    );
  }

  Widget productsCarousel(LocaleBundle localeBundle, List<ShipmentProductResponse> products) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 14 / 7.4,
        enableInfiniteScroll: false,
        viewportFraction: 0.38,
        initialPage: 0,
      ),
      items: products?.map((product) => ProductInShipmentDetails(product: product))?.toList(),
    );
  }

  Widget orderFlowDiagram(List<ShipmentFlowResponse> flows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < flows.length - 1; i++) _flowWithArrow(flows.elementAt(i)),
        ChoosableButtonWithSubText(
          text: describeEnum(flows.last.status),
          subText: flows.last.createdAt.toStringWithTime(),
        ),
      ],
    );
  }

  Widget _flowWithArrow(ShipmentFlowResponse flow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChoosableButtonWithSubText(
          text: describeEnum(flow.status),
          subText: flow.createdAt.toStringWithTime(),
        ),
        Icon(Icons.arrow_downward_sharp, size: 30.0)
      ],
    );
  }

  Widget _changeStatusButton(CustomerShipmentDetailsBloc bloc, CustomerDecision status) {
    return ChoosableButton(
        text: "${describeEnum(status)} order",
        chooseAction: () => bloc.add(UpdateShipmentStatus(shipmentId: bloc.state.shipment.id, decision: status)));
  }
}

class ProductInShipmentDetails extends NarrowTile {
  final ShipmentProductResponse product;

  ProductInShipmentDetails({this.product});

  @override
  String get firstLineText => "amount: ${removeDecimalZeroFormat(product.quantity)}";

  @override
  IconData get iconType => Icons.shopping_basket_outlined;

  @override
  String get secondLineText => formatPrice(product.summarizedPrice);

  @override
  String get tileTitle => product.productName;
}
