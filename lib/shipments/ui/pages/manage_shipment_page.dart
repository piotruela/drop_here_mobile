import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/secondary_title.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/double_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_circled_info.dart';
import 'package:drop_here_mobile/common/ui/widgets/narrow_tile.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/shipments/bloc/customer_shipment_bloc/customer_shipment_bloc.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class CreateShipmentPage extends ManageShipmentPage {
  final DropDetailedCustomerResponse drop;

  CreateShipmentPage({this.drop});

  @override
  CustomerShipmentEvent get initializingEvent => InitializeCreateOrder(drop: drop);
  @override
  String get pageTitle => "New order";
}

class EditShipmentPage extends ManageShipmentPage {
  final ShipmentResponse order;
  final String dropUid;

  EditShipmentPage({this.order, this.dropUid});

  @override
  CustomerShipmentEvent get initializingEvent => InitializeEditOrder(dropUid: dropUid, order: order);

  @override
  String get pageTitle => "Edit order";
}

abstract class ManageShipmentPage extends BlocWidget<CustomerShipmentBloc> {
  String get pageTitle;
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  CustomerShipmentEvent get initializingEvent;

  @override
  CustomerShipmentBloc bloc() => CustomerShipmentBloc()..add(initializingEvent);

  @override
  Widget build(BuildContext context, CustomerShipmentBloc bloc, _) {
    return Scaffold(
      body: BlocBuilder<CustomerShipmentBloc, CustomerShipmentState>(
          buildWhen: (previous, current) => previous.type != current.type,
          builder: (context, state) => Conditional.single(
              context: context,
              conditionBuilder: (_) => state.type != CustomerShipmentStateType.loading,
              widgetBuilder: (_) => _buildContent(context, bloc.state),
              fallbackBuilder: (_) => Center(child: CircularProgressIndicator()))),
    );
  }

  Widget _buildContent(BuildContext context, CustomerShipmentState state) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DhBackButton(
              padding: EdgeInsets.zero,
            ),
            Text(
              pageTitle,
              style: themeConfig.textStyles.primaryTitle,
            ),
            secondaryTitle("Products"),
            productsCarousel(context, localeBundle, state),
            annotationText("Comment"),
            DhPlainTextFormField(
                hintText: "Comment your order",
                inputType: InputType.text,
                onChanged: (value) =>
                    BlocProvider.of<CustomerShipmentBloc>(context).add(CommentChanged(comment: value)),
                initialValue: state.comment),
            LabeledCircledColoredInfo(label: "Summarized price", text: "0 zł")
          ],
        ),
      ),
    );
  }

  Widget productsCarousel(BuildContext context, LocaleBundle localeBundle, CustomerShipmentState state) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 14 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          /*for (ShipmentProductRequest product in state.selectedProducts ?? [])
            ProductInShipmentManagementCard(
                product: state.drop.products
                    .firstWhere((element) => element.routeProductResponse.id == product.routeProductId),
                amount: product.quantity),*/
          ChoosableButton(text: "Add product +", chooseAction: () => {})
        ]);
  }

  Text annotationText(String text) => Text(
        text,
        style: themeConfig.textStyles.dataAnnotation,
      );
}

class ProductInShipmentManagementCard extends NarrowTile {
  final RouteProductRouteResponse product;
  final double amount;

  ProductInShipmentManagementCard({this.product, this.amount});

  @override
  String get firstLineText => amount.toString();

  @override
  IconData get iconType => Icons.shopping_basket_outlined;

  @override
  String get secondLineText => (product.amount * product.price).formatPrice();

  @override
  String get tileTitle => product.routeProductResponse.name;
}
