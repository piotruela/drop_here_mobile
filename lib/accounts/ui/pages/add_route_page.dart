import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/secondary_title.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/seller_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/bloc/manage_route_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/routes/routes_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class AddRoutePage extends ManageRoutePage {
  @override
  String get pageTitle => "Create route";

  @override
  UnpreparedRouteRequest get initialRoute => UnpreparedRouteRequest();
}

abstract class ManageRoutePage extends BlocWidget<ManageRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  bloc() => ManageRouteBloc()..add(InitializeForm(routeRequest: initialRoute));

  String get pageTitle;

  UnpreparedRouteRequest get initialRoute;

  @override
  Widget build(BuildContext context, ManageRouteBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
        body: BlocConsumer<ManageRouteBloc, ManageRouteState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (bloc.state.type == ManageRouteStateType.loading) {
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
          Get.to(RoutesListPage());
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
          Text(
            pageTitle,
            style: themeConfig.textStyles.primaryTitle,
          ),
          _field(
              label: localeBundle.nameMandatory,
              hint: localeBundle.routeNameExample,
              inputType: InputType.text,
              onChanged: (String name) =>
                  bloc.add(FormChanged2(routeRequest: bloc.state.routeRequest.copyWith(name: name))),
              initialValue: bloc.state.routeRequest?.name ?? ""),
          secondaryTitle(localeBundle.dateMandatory),
          BlocBuilder<ManageRouteBloc, ManageRouteState>(
              buildWhen: (previous, current) => previous.routeRequest.date != current.routeRequest.date,
              builder: (context, state) => Conditional.single(
                  context: context,
                  conditionBuilder: (_) => state.routeRequest?.date != null,
                  widgetBuilder: (_) => ChoosableButton(
                      text: state.routeRequest.date.toStringWithoutTime(),
                      chooseAction: () async => chooseDate(context, bloc)),
                  fallbackBuilder: (_) =>
                      ChoosableButton(text: "Add date +", chooseAction: () async => chooseDate(context, bloc)))),
          secondaryTitle(localeBundle.assignedSeller),
          BlocBuilder<ManageRouteBloc, ManageRouteState>(
              buildWhen: (previous, current) => previous.routeRequest.profileUid != current.routeRequest.profileUid,
              builder: (context, state) => Conditional.single(
                    context: context,
                    conditionBuilder: (_) => state.routeRequest.profileUid == null,
                    widgetBuilder: (_) => ChoosableButton(
                        text: "Asign seller +",
                        chooseAction: () {
                          FocusScope.of(context).unfocus();
                          bloc.add(FormChanged2(
                              routeRequest: bloc.state.routeRequest
                                  .copyWith(profileUid: bloc.state.sellerProfiles.first.profileUid)));
                        }),
                    fallbackBuilder: (_) => SellerCard(
                      title: state.sellerFullName ?? "",
                      trailing: Icon(Icons.edit),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        bloc.add(RemoveSeller());
                      },
                    ),
                  )),
          _field(
              label: localeBundle.description,
              hint: "This route is the best opportunity to get vegetables straight from",
              inputType: InputType.text,
              onChanged: (String description) =>
                  bloc.add(FormChanged2(routeRequest: bloc.state.routeRequest.copyWith(description: description))),
              initialValue: bloc.state.routeRequest?.description ?? ""),
          secondaryTitle("Products"),
          productsCarousel(context, localeBundle, bloc)
        ],
      ),
    );
  }

  void chooseDate(BuildContext context, ManageRouteBloc bloc) async {
    FocusScope.of(context).unfocus();
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: bloc.state.routeRequest?.date ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10, 1, 1));
    bloc.add(FormChanged2(
      routeRequest: bloc.state.routeRequest.copyWith(date: dateTime),
    ));
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

  CarouselSlider productsCarousel(BuildContext context, LocaleBundle localeBundle, ManageRouteBloc bloc) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          //for (RouteProductRequest product in bloc.state.routeRequest.products ?? [])
          ChoosableButton(
            text: "Add product +",
            chooseAction: () async {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
        ]);
  }
}

/*
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
                      addRouteBloc.add(FormChanged(routeRequest: addRouteBloc.state.routeRequest.copyWith(name: name)));
                    },
                  ),
                  secondaryTitle(locale.dateMandatory),
                  BlocBuilder<AddRouteBloc, AddRouteFormState>(
                      buildWhen: (previous, current) => previous.routeRequest.date != current.routeRequest.date,
                      builder: (context, state) => Conditional.single(
                          context: context,
                          conditionBuilder: (_) => state.routeRequest.date == null,
                          widgetBuilder: (_) => _buildDatePickerButton(locale, context, addRouteBloc),
                          fallbackBuilder: (_) => ValuePickedFlatButton(
                                text: state.routeRequest.date.toString().substring(0, 10),
                                onTap: () {
                                  chooseDate(context, addRouteBloc);
                                },
                              ))),
                  secondaryTitle(locale.dropsMandatory),
                  BlocBuilder<AddRouteBloc, AddRouteFormState>(
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) => dropsCarousel(locale, addRouteBloc, context)),
                  SizedBox(height: 6.0),
                  secondaryTitle(locale.assignedSeller),
                  SizedBox(height: 6.0),
                  BlocBuilder<AddRouteBloc, AddRouteFormState>(
                      buildWhen: (previous, current) => previous.fullName() != current.fullName(),
                      builder: (context, state) => Conditional.single(
                            context: context,
                            conditionBuilder: (_) => state.fullName() == null,
                            widgetBuilder: (_) => _chooseSeller(locale, context, addRouteBloc),
                            fallbackBuilder: (_) => SellerCard(
                              title: state.fullName(),
                              //TODO add popupOptions
                              trailing: Icon(Icons.edit),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                getToChoseSellerPage(addRouteBloc);
                              },
                            ),
                          )),
                  SizedBox(height: 6.0),
                  secondaryTitle(locale.description),
                  DhTextArea(
                    onChanged: (String description) {
                      addRouteBloc.add(FormChanged(
                          routeRequest: addRouteBloc.state.routeRequest.copyWith(description: description)));
                    },
                    value: addRouteBloc.state.routeRequest.description,
                  ),
                  SizedBox(height: 6.0),
                  secondaryTitle(locale.productsMandatory),
                  SizedBox(height: 6.0),
                  productsCarousel(locale, addRouteBloc, context),
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
                              addRouteBloc.add(FormSubmitted(routeRequest: addRouteBloc.state.routeRequest));
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

  Widget _buildDatePickerButton(LocaleBundle locale, BuildContext context, AddRouteBloc bloc) {
    return ColoredRoundedFlatButton(
      text: locale.pickADate,
      onTap: () {
        chooseDate(context, bloc);
      },
    );
  }

  void chooseDate(BuildContext context, AddRouteBloc bloc) async {
    FocusScope.of(context).unfocus();
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate:
            bloc.state.routeRequest.date != null ? DateTime.parse(bloc.state.routeRequest.date) : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10, 1, 1));
    bloc.add(FormChanged(
      routeRequest: bloc.state.routeRequest.copyWith(date: dateTime.toString().substring(0, 10)),
    ));
  }

  Widget _chooseSeller(LocaleBundle locale, BuildContext context, AddRouteBloc bloc) {
    FocusScope.of(context).unfocus();
    return ColoredRoundedFlatButton(
      text: locale.chooseSeller,
      onTap: () {
        getToChoseSellerPage(bloc);
        //TODO add function
      },
    );
  }

  void getToChoseSellerPage(AddRouteBloc bloc) {
    Get.to(ChooseSellerPage(
      addSeller: (String profileUid, String sellerFirstName, String sellerLastName) {
        bloc.add(FormChanged(
            routeRequest: bloc.state.routeRequest.copyWith(profileUid: profileUid),
            sellerFirstName: sellerFirstName,
            sellerLastName: sellerLastName));
      },
    ));
  }

  Widget dropCard({LocaleBundle locale, LocalDrop drop, AddRouteBloc bloc}) {
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
            Stack(
              children: [
                Container(
                  width: 114.0,
                  child: IconInCircle(
                    themeConfig: themeConfig,
                    icon: Icons.thumbs_up_down,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 2,
                  child: GestureDetector(
                    onTap: () {
                      print('cli');
                      bloc.add(RemoveDrop(drop));
                    },
                    child: Icon(Icons.close),
                  ),
                )
              ],
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
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: themeConfig.colors.primary1,
                        size: 10.0,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        drop.spotName ?? '',
                        style: themeConfig.textStyles.title3Annotation,
                      ),
                    ],
                  ),
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

  CarouselSlider dropsCarousel(LocaleBundle locale, AddRouteBloc bloc, BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          for (LocalDrop drop in bloc.state.drops ?? []) dropCard(locale: locale, drop: drop, bloc: bloc),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(AddDropToRoutePage(
                  addDrop: (LocalDrop drop) {
                    bloc.add(AddDrop(
                      drop,
                    ));
                  },
                  lastDropEndTime: bloc.state.drops?.length != 0
                      ? DateFormat("HH:mm").parse(
                          bloc.state.drops.last.endTime,
                        )
                      : null));
            },
            child: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.add,
            ),
          )
        ]);
  }

  CarouselSlider productsCarousel(LocaleBundle locale, AddRouteBloc bloc, BuildContext context) {
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
            ),
          GestureDetector(
            onTap: () async {
              bloc.add(AddProducts(products: await Get.to(AddProductsToRoutePage(bloc.state.products.toSet()))));
              FocusScope.of(context).requestFocus(FocusNode());
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                child: product.photo != null
                    ? productPhoto(product.photo)
                    : IconInCircle(
                        themeConfig: themeConfig,
                        icon: Icons.shopping_basket,
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
                    product.price.toString() + locale.currency + '/' + product.unit,
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    product.unlimited == null || product.unlimited == false
                        ? product.amount.toString() + product.unit
                        : locale.unlimited,
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productPhoto(Image photo) {
    return Container(
      width: 74.0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 74,
          maxHeight: 84,
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: photo),
      ),
    );
  }
}
*/
