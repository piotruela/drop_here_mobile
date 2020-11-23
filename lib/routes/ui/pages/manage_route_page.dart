import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/seller_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/common/ui/widgets/narrow_tile.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/routes/bloc/manage_route_bloc/manage_route_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/ui/pages/add_drop_to_route_page.dart';
import 'package:drop_here_mobile/routes/ui/pages/add_products_to_route.dart';
import 'package:drop_here_mobile/routes/ui/pages/choose_seller_page.dart';
import 'package:drop_here_mobile/routes/ui/widgets/drop_card.dart';
import 'package:drop_here_mobile/shipments/ui/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class EditRoutePage extends ManageRoutePage {
  final RouteResponse route;

  EditRoutePage({this.route});

  @override
  String get pageTitle => "Edit route";

  @override
  UnpreparedRouteRequest get initialRoute => route.toRouteRequest;

  @override
  List<ProductResponse> get products => route.products.map((e) => e.routeProductResponse).toList();

  int get routeId => route.id;

  @override
  String get submitButtonText => "Edit route";
}

class AddRoutePage extends ManageRoutePage {
  @override
  String get pageTitle => "Create route";

  @override
  UnpreparedRouteRequest get initialRoute =>
      UnpreparedRouteRequest(drops: [], acceptShipmentsAutomatically: false, products: []);

  int get routeId => null;

  @override
  String get submitButtonText => "Add route";
}

abstract class ManageRoutePage extends BlocWidget<ManageRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  bloc() => ManageRouteBloc()..add(InitializeForm(routeRequest: initialRoute, alreadyAddedProducts: products));

  String get pageTitle;

  UnpreparedRouteRequest get initialRoute;

  List<ProductResponse> get products => null;

  int get routeId;

  String get submitButtonText;

  @override
  Widget build(BuildContext context, ManageRouteBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
        body: BlocConsumer<ManageRouteBloc, ManageRouteState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (bloc.state.type == ManageRouteStateType.loading ||
            bloc.state.type == ManageRouteStateType.added_successfully) {
          return Center(child: CircularProgressIndicator());
        } else if (state.type == ManageRouteStateType.error) {
          return Text("ERROR");
        } else {
          return _buildContent(context, bloc, localeBundle);
        }
      },
      listenWhen: (previous, current) => previous.type != current.type,
      listener: (context, state) {
        if (bloc.state.type == ManageRouteStateType.added_successfully) {
          Get.to(DashboardPage(initialIndex: 0));
        } else {}
      },
    ));
  }

  Widget _buildContent(BuildContext context, ManageRouteBloc bloc, LocaleBundle localeBundle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          DhBackButton(padding: EdgeInsets.zero),
          Text(
            pageTitle,
            style: themeConfig.textStyles.primaryTitle,
          ),
          _field(
              label: localeBundle.nameMandatory,
              hint: localeBundle.routeNameExample,
              inputType: InputType.text,
              onChanged: (String name) =>
                  bloc.add(FormChanged(routeRequest: bloc.state.routeRequest.copyWith(name: name))),
              initialValue: bloc.state.routeRequest?.name ?? ""),
          labeledSwitch(
              text: "Auto-accept order",
              initialPosition: bloc.state.routeRequest.acceptShipmentsAutomatically,
              onSwitch: (value) =>
                  bloc.add(FormChanged(routeRequest: bloc.state.routeRequest.copyWith(autoAccept: value)))),
          secondaryTitle(localeBundle.dateMandatory),
          BlocBuilder<ManageRouteBloc, ManageRouteState>(
              buildWhen: (previous, current) => previous.routeRequest.date != current.routeRequest.date,
              builder: (context, state) => Conditional.single(
                  context: context,
                  conditionBuilder: (_) => state.routeRequest?.date != null,
                  widgetBuilder: (_) => ChoosableButton(
                      text: state.routeRequest.date, chooseAction: () async => chooseDate(context, bloc)),
                  fallbackBuilder: (_) =>
                      ChoosableButton(text: "Add date", chooseAction: () async => chooseDate(context, bloc)))),
          secondaryTitle("Drops"),
          dropsCarousel(context, localeBundle, bloc),
          secondaryTitle(localeBundle.assignedSeller),
          BlocBuilder<ManageRouteBloc, ManageRouteState>(
              buildWhen: (previous, current) => previous.routeRequest.profileUid != current.routeRequest.profileUid,
              builder: (context, state) => Conditional.single(
                    context: context,
                    conditionBuilder: (_) => state.routeRequest.profileUid == null,
                    widgetBuilder: (_) => ChoosableButton(
                        text: "Assign seller",
                        chooseAction: () async {
                          FocusScope.of(context).unfocus();
                          bloc.add(FormChanged(
                              routeRequest:
                                  bloc.state.routeRequest.copyWith(profileUid: await Get.to(ChooseSellerPage()))));
                        }),
                    fallbackBuilder: (_) => SellerCard(
                      title: state.sellerFullName ?? "",
                      trailing: Icon(Icons.edit),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        bloc.add(FormChanged(
                            routeRequest: bloc.state.routeRequest.copyWith(
                                profileUid: await Get.to(
                                    ChooseSellerPage(selectedProfileUid: state.routeRequest.profileUid)))));
                      },
                    ),
                  )),
          _field(
              label: localeBundle.description,
              hint: "This route is the best opportunity to get vegetables straight from",
              inputType: InputType.text,
              onChanged: (String description) =>
                  bloc.add(FormChanged(routeRequest: bloc.state.routeRequest.copyWith(description: description))),
              initialValue: bloc.state.routeRequest?.description ?? ""),
          secondaryTitle("Products"),
          productsCarousel(context, localeBundle, bloc),
          BlocBuilder<ManageRouteBloc, ManageRouteState>(
              buildWhen: (previous, current) => previous.isFilled != current.isFilled,
              builder: (context, state) => Center(
                    child: SubmitFormButton(
                      text: submitButtonText,
                      isActive: state.isFilled,
                      onTap: () => bloc.add(FormSubmitted(request: state.routeRequest, routeId: routeId)),
                    ),
                  )),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  void chooseDate(BuildContext context, ManageRouteBloc bloc) async {
    FocusScope.of(context).unfocus();
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: bloc.state.routeRequest?.date?.toDateTime ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10, 1, 1));
    if (dateTime != null) {
      bloc.add(FormChanged(
        routeRequest: bloc.state.routeRequest.copyWith(date: dateTime.toStringWithoutTime()),
      ));
    }
  }

  Widget _field({String label, String hint, InputType inputType, Function(String) onChanged, String initialValue}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: themeConfig.textStyles.secondaryTitle,
        ),
        DhPlainTextFormField(hintText: hint, inputType: inputType, onChanged: onChanged, initialValue: initialValue)
      ],
    );
  }

  Widget productsCarousel(BuildContext context, LocaleBundle localeBundle, ManageRouteBloc bloc) {
    return bloc.state.routeRequest.products.length == 0
        ? addProductButton(context, bloc)
        : CarouselSlider(options: options(), items: productItems(context, bloc));
  }

  Widget dropsCarousel(BuildContext context, LocaleBundle localeBundle, ManageRouteBloc bloc) {
    return bloc.state.routeRequest.drops.length == 0
        ? addDropButton(bloc)
        : CarouselSlider(options: dropsOptions(), items: dropsItems(context, bloc));
  }

  Widget addDropButton(ManageRouteBloc bloc) {
    return ChoosableButton(
      text: "Add drop",
      chooseAction: () async {
        final TimeOfDay minTime = bloc.state.routeRequest.drops.isNotEmpty
            ? bloc.state.routeRequest.drops.last.endTime.toTimeOfDay
            : TimeOfDay(hour: 00, minute: 00);
        RouteDropRequest drop = await Get.to(AddDropToRoutePage(
          drop: RouteDropRequest(),
          minTime: minTime,
        ));
        if (drop != null) {
          bloc.add(AddDrop(drop: drop));
        }
      },
    );
  }

  CarouselOptions options() {
    return CarouselOptions(
      aspectRatio: 14 / 7.4,
      enableInfiniteScroll: false,
      viewportFraction: 0.5,
      initialPage: 0,
    );
  }

  CarouselOptions dropsOptions() {
    return CarouselOptions(
      aspectRatio: 14 / 9.4,
      enableInfiniteScroll: false,
      viewportFraction: 0.5,
      initialPage: 0,
    );
  }

  List<Widget> dropsItems(BuildContext context, ManageRouteBloc bloc) {
    return [
      for (RouteDropRequest drop in bloc.state.routeRequest.drops ?? [])
        CompanyRouteDropCard(
          drop: drop,
          dropSpotName: bloc.state.spots.firstWhere((element) => element.id == drop.spotId, orElse: () => null)?.name,
          onClosePressed: () => bloc.add(RemoveDrop(drop: drop)),
        ),
      addDropButton(bloc),
    ];
  }

  List<Widget> productItems(BuildContext context, ManageRouteBloc bloc) {
    return [
      for (RouteProductRequest product in bloc.state.routeRequest.products ?? [])
        ProductInDropManagementTile(
          product: product,
          productName:
              bloc.state.products.firstWhere((element) => element.id == product.productId, orElse: () => null)?.name,
          closeAction: () => bloc.add(RemoveProduct(productId: product.productId)),
        ),
      addProductButton(context, bloc),
    ];
  }

  Widget addProductButton(BuildContext context, ManageRouteBloc bloc) {
    return ChoosableButton(
      text: "Add product",
      chooseAction: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        bloc.add(FormChanged(
            routeRequest: bloc.state.routeRequest.copyWith(
                products: await Get.to(AddProductsToRoutePage(
          selectedProducts: bloc.state.routeRequest.products,
        )))));
      },
    );
  }
}

class ProductInDropManagementTile extends NarrowTile {
  final RouteProductRequest product;
  final String productName;
  final VoidCallback closeAction;

  ProductInDropManagementTile({this.product, this.productName, this.closeAction});

  @override
  String get firstLineText => product.productAmountToString;

  @override
  IconData get iconType => Icons.shopping_basket_outlined;

  @override
  String get secondLineText => product.price.toString();

  @override
  String get tileTitle => productName;

  @override
  get onExitPressed => closeAction;
}
