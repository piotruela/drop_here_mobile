import 'package:carousel_slider/carousel_slider.dart';
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
                      // addProductBloc.add(FormChanged(
                      //     productManagementRequest: addProductBloc.state.productManagementRequest
                      //         .copyWith(name: name, productCustomizationWrappers: [])));
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
                  carousel(locale),
                  secondaryTitle(locale.assignedSeller),
                  SellerCard(
                    title: 'piotr',
                    //TODO add popupOptions
                    popupOptions: ['todo'],
                  ),
                  secondaryTitle(locale.description),
                  DhTextArea(
                    onChanged: (String description) {
                      addRouteBloc.add(FormChanged(
                          routeRequest:
                              addRouteBloc.state.routeRequest.copyWith(description: description)));
                    },
                    value: addRouteBloc.state.routeRequest.description,
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

  Widget dropCard({LocaleBundle locale}) {
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
                    'Drop No. 2',
                    style: themeConfig.textStyles.title3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Gdańsk, wrzeszcz',
                    style: themeConfig.textStyles.title3Annotation,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    locale.members + ':',
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 6.0),
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
                        "15",
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
                        "15",
                        style: themeConfig.textStyles.title3Annotation,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  )
                  //SizedBox(height: 5.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider carousel(LocaleBundle locale) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          dropCard(locale: locale),
          dropCard(locale: locale),
          dropCard(locale: locale),
          IconInCircle(
            themeConfig: themeConfig,
            icon: Icons.add,
          )
        ]);
  }
}
