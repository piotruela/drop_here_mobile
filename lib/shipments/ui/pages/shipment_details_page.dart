import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/utils/double_utils.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/add_new_item_panel.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/info_text.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_circled_info.dart';
import 'package:drop_here_mobile/common/ui/widgets/narrow_tile.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/shipments/bloc/company_shipment_bloc/company_shipment_bloc.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_request.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/ui/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShipmentDetailsPage extends BlocWidget<CompanyShipmentBloc> {
  final int shipmentId;
  final PanelController panelController = PanelController();
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  ShipmentDetailsPage({this.shipmentId});

  @override
  CompanyShipmentBloc bloc() => CompanyShipmentBloc()..add(FetchShipmentDetails(shipmentId: shipmentId));

  @override
  Widget build(BuildContext context, CompanyShipmentBloc bloc, _) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<CompanyShipmentBloc, CompanyShipmentState>(
            buildWhen: (previous, current) => previous.type != current.type,
            builder: (context, state) => Conditional.single(
                context: context,
                conditionBuilder: (_) => state.type == CompanyShipmentStateType.shipment_fetched,
                widgetBuilder: (_) => _buildContent(context, bloc),
                fallbackBuilder: (_) => Center(child: CircularProgressIndicator())),
          ),
          AddNewItemPanel(controller: panelController)
        ],
      ),
      bottomNavigationBar: CompanyBottomBar(
        sectionIndex: 0,
      ),
    );
  }

  Widget _buildContent(BuildContext context, CompanyShipmentBloc bloc) {
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
              backAction: () => Get.to(DashboardPage(initialIndex: 1)),
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
              label: "Customer name",
              text: shipmentResponse.customerFullName,
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
                                _changeStatusButton(bloc, Decision.ACCEPT),
                                _changeStatusButton(bloc, Decision.REJECT),
                              ],
                          ShipmentStatus.ACCEPTED: (BuildContext context) => <Widget>[
                                _changeStatusButton(bloc, Decision.DELIVER),
                                _changeStatusButton(bloc, Decision.REJECT),
                              ],
                          ShipmentStatus.CANCEL_REQUESTED: (BuildContext context) => <Widget>[
                                _changeStatusButton(bloc, Decision.CANCEL),
                                _changeStatusButton(bloc, Decision.DELIVER),
                              ],
                        },
                        fallbackBuilder: (_) => [InfoText(text: "This state is final")])),
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

  Widget _changeStatusButton(CompanyShipmentBloc bloc, Decision status) {
    return ChoosableButton(
        text: "${describeEnum(status)} order",
        chooseAction: () =>
            bloc.add(UpdateShipmentStatus(shipmentId: bloc.state.shipment.id, companyDecision: status)));
  }
}

class ProductInShipmentDetails extends NarrowTile {
  final ShipmentProductResponse product;

  ProductInShipmentDetails({this.product});

  @override
  String get firstLineText => product.quantity.toString();

  @override
  IconData get iconType => Icons.shopping_basket_outlined;

  @override
  String get secondLineText => product.summarizedPrice.formatPrice();

  @override
  String get tileTitle => product.productName;
}
