import 'dart:collection';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_drop_to_route_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_products_to_route.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/seller_card.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/value_picked_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/bloc/add_route_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class AddRoutePage extends BlocWidget<AddRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  @override
  bloc() => AddRouteBloc();

  @override
  Widget build(BuildContext context, AddRouteBloc addRouteBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      backgroundColor: themeConfig.colors.white,
      body: SafeArea(
        child: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              Localization.of(context).bundle.planRoute,
              style: themeConfig.textStyles.primaryTitle,
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  secondaryTitle(locale.nameMandatory),
                  DhPlainTextFormField(
                    hintText: locale.routeNameExample,
                    onChanged: (String name) {
                      addRouteBloc.add(FormChanged(
                          routeRequest: addRouteBloc.state.routeRequest.copyWith(name: name)));
                    },
                  ),
                  secondaryTitle(locale.dateMandatory),
                  BlocBuilder<AddRouteBloc, AddRouteFormState>(
                      buildWhen: (previous, current) =>
                          previous.routeRequest.date != current.routeRequest.date,
                      builder: (context, state) => Conditional.single(
                          context: context,
                          conditionBuilder: (_) => state.routeRequest.date == null,
                          widgetBuilder: (_) =>
                              _buildDatePickerButton(locale, context, addRouteBloc),
                          fallbackBuilder: (_) => ValuePickedFlatButton(
                                text: state.routeRequest.date.toString().substring(0, 10),
                                onTap: () {
                                  chooseDate(context, addRouteBloc);
                                },
                              ))),
                  secondaryTitle(locale.dropsMandatory),
                  BlocBuilder<AddRouteBloc, AddRouteFormState>(
                      // buildWhen: (previous, current) =>
                      //     previous.drops?.length != current.drops?.length,
                      builder: (context, state) => dropsCarousel(
                          locale, addRouteBloc.state.routeRequest.drops, addRouteBloc)),
                  //carousel(locale),
                  SizedBox(height: 6.0),
                  secondaryTitle(locale.assignedSeller),
                  SizedBox(height: 6.0),
                  SellerCard(
                    title: 'piotr',
                    //TODO add popupOptions
                    popupOptions: ['todo'],
                  ),
                  SizedBox(height: 6.0),
                  secondaryTitle(locale.description),
                  DhTextArea(
                    onChanged: (String description) {
                      addRouteBloc.add(FormChanged(
                          routeRequest:
                              addRouteBloc.state.routeRequest.copyWith(description: description)));
                    },
                    value: addRouteBloc.state.routeRequest.description,
                  ),
                  SizedBox(height: 6.0),
                  secondaryTitle(locale.productsMandatory),
                  SizedBox(height: 6.0),
                  productsCarousel(locale, addRouteBloc),
                  SizedBox(
                    height: 40.0,
                  ),
                  BlocBuilder<AddRouteBloc, AddRouteFormState>(
                    buildWhen: (previous, current) => previous.isFilled != current.isFilled,
                    builder: (context, state) => Center(
                      child: SubmitFormButton(
                          text: locale.addRoute,
                          isActive: state.isFilled,
                          //TODO check this function
                          onTap: () {
                            if (state.isFilled) {
                              addRouteBloc.add(FormSubmitted());
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  ColoredRoundedFlatButton _buildDatePickerButton(
      LocaleBundle locale, BuildContext context, AddRouteBloc bloc) {
    return ColoredRoundedFlatButton(
      text: locale.pickADate,
      onTap: () {
        chooseDate(context, bloc);
      },
    );
  }

  void chooseDate(BuildContext context, AddRouteBloc bloc) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10, 1, 1));
    bloc.add(FormChanged(
      routeRequest: bloc.state.routeRequest.copyWith(date: dateTime),
    ));
  }

  Text secondaryTitle(String text) {
    return Text(
      text,
      style: themeConfig.textStyles.secondaryTitle,
    );
  }

  Widget dropCard({LocaleBundle locale, RouteDropRequest drop}) {
    return Padding(
      padding: const EdgeInsets.only(right: 22.0, bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.0,
            ),
            Container(
              width: 114.0,
              child: IconInCircle(
                themeConfig: themeConfig,
                icon: Icons.thumbs_up_down,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drop.name,
                    style: themeConfig.textStyles.title3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  //TODO add when drop localization available
                  // FutureBuilder(
                  //     future: getAddressFromCoordinates(drop., spot.ycoordinate) ?? '',
                  //     initialData: "Loading location...",
                  //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  //       return Text(
                  //         snapshot.data ?? "",
                  //         style: themeConfig.textStyles.title3Annotation,
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 1,
                  //       );
                  //     }),
                  SizedBox(height: 6.0),
                  //TODO add when drop members available
                  // Text(
                  //   locale.members + ':' + drop.members,
                  //   style: themeConfig.textStyles.title3Annotation,
                  // ),
                  // SizedBox(height: 6.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: themeConfig.colors.active,
                        size: 10.0,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        drop.startTime ?? '',
                        style: themeConfig.textStyles.title3Annotation,
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: themeConfig.colors.blocked,
                        size: 10.0,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        drop.endTime ?? '',
                        style: themeConfig.textStyles.title3Annotation,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  //SizedBox(height: 5.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider dropsCarousel(
      LocaleBundle locale, List<RouteDropRequest> drops, AddRouteBloc bloc) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          for (RouteDropRequest drop in drops ?? []) dropCard(locale: locale, drop: drop),
          GestureDetector(
            onTap: () {
              Get.to(AddDropToRoutePage(
                addDrop: (RouteDropRequest drop) {
                  bloc.add(FormChanged(
                      routeRequest: bloc.state.routeRequest.drops != null
                          ? bloc.state.routeRequest
                              .copyWith(drops: bloc.state.routeRequest.drops..add(drop))
                          : bloc.state.routeRequest.copyWith(drops: [drop])));
                },
              ));
            },
            child: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.add,
            ),
          )
        ]);
  }

  CarouselSlider productsCarousel(LocaleBundle locale, AddRouteBloc bloc) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          for (LocalProduct product in bloc.state.products ?? [])
            productCard(
              locale: locale,
              product: product,
              photo: File(
                  //TODO change this file
                  '/data/user/0/com.example.drop_here_mobile/cache/image_picker5158575234322302316.jpg'),
            ),
          GestureDetector(
            onTap: () {
              Get.to(AddProductsToRoutePage((LinkedHashSet<LocalProduct> selectedProducts) {
                // if (bloc.state.products == null) {
                //   bloc.add(FormChanged(routeRequest: bloc.state.));
                //   bloc.state.copyWith(products: []);
                // }
                //bloc.state.products.addAll(selectedProducts);
                bloc.add(AddProducts(products: selectedProducts.toList()));
                //bloc.add(FormChanged(routeRequest: bloc.state.routeRequest.))
              }, bloc.state.products));
              // Get.to(AddDropToRoutePage(
              //   addDrop: (RouteDropRequest drop) {
              //     bloc.add(FormChanged(
              //         routeRequest: bloc.state.routeRequest.drops != null
              //             ? bloc.state.routeRequest
              //                 .copyWith(drops: bloc.state.routeRequest.drops..add(drop))
              //             : bloc.state.routeRequest.copyWith(drops: [drop])));
              //   },
              // )
              // );
            },
            child: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.add,
            ),
          )
        ]);
  }

  Widget productCard({File photo, LocalProduct product, LocaleBundle locale}) {
    return Padding(
      padding: const EdgeInsets.only(right: 22.0, bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 154,
              height: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                child: Image.file(
                  photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    product.name,
                    style: themeConfig.textStyles.title3,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    product.price.toString() + '/' + product.unit,
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    product.limitedAmount == null || product.limitedAmount == false
                        ? locale.unlimited
                        : product.amount.toString(),
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  //SizedBox(height: 5.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
