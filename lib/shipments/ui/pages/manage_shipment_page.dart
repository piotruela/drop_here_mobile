import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/secondary_title.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
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
import 'package:drop_here_mobile/shipments/ui/pages/add_product_page.dart';
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

  @override
  String get companyUid => drop.spot.companyUid;

  @override
  String get dropUid => drop.uid;
}

class EditShipmentPage extends ManageShipmentPage {
  final ShipmentResponse order;
  final String dropUid;

  EditShipmentPage({this.order, this.dropUid});

  @override
  CustomerShipmentEvent get initializingEvent => InitializeEditOrder(dropUid: dropUid, order: order);

  @override
  String get pageTitle => "Edit order";

  @override
  String get companyUid => order.companyUid;
}

abstract class ManageShipmentPage extends BlocWidget<CustomerShipmentBloc> {
  String get pageTitle;
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  CustomerShipmentEvent get initializingEvent;

  String get companyUid;

  String get dropUid;

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
              widgetBuilder: (_) => _buildContent(context, bloc, bloc.state),
              fallbackBuilder: (_) => Center(child: CircularProgressIndicator()))),
    );
  }

  Widget _buildContent(BuildContext context, CustomerShipmentBloc bloc, CustomerShipmentState state) {
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
            productsCarousel(context, localeBundle, bloc, state),
            annotationText("Comment"),
            DhPlainTextFormField(
                hintText: "Comment your order",
                maxLength: 250,
                inputType: InputType.text,
                onChanged: (value) =>
                    BlocProvider.of<CustomerShipmentBloc>(context).add(CommentChanged(comment: value)),
                initialValue: state.comment),
            LabeledCircledColoredInfo(label: "Summarized price", text: formatPrice(state.sum)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                child: SubmitFormButton(
                  isActive: state.selectedProducts.isNotEmpty,
                  text: "Place order",
                  onTap: () => bloc.add(SubmitForm(
                    companyUid: companyUid,
                    dropUid: dropUid,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productsCarousel(
      BuildContext context, LocaleBundle localeBundle, CustomerShipmentBloc bloc, CustomerShipmentState state) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 14 / 5.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          for (ShipmentProductRequest product in state.selectedProducts ?? [])
            ProductInShipmentManagementCard(
              product: state.drop.products.firstWhere((element) => element.id == product.routeProductId),
              amount: product.quantity,
              deleteProductAction: () => bloc.add(RemoveProduct(product: product)),
            ),
          ChoosableButton(
              text: "Add product",
              chooseAction: () async {
                bloc.add(AddProduct(
                    productRequest: await Get.to(AddProductPage(
                  products: state.drop.products,
                ))));
              })
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
  final VoidCallback deleteProductAction;

  ProductInShipmentManagementCard({this.product, this.amount, this.deleteProductAction});

  @override
  String get firstLineText => "amount: ${removeDecimalZeroFormat(amount)}";

  @override
  IconData get iconType => Icons.shopping_basket_outlined;

  @override
  String get secondLineText => "";

  @override
  String get tileTitle => product.routeProductResponse.name;

  @override
  get onExitPressed => deleteProductAction;
}
