import 'package:drop_here_mobile/accounts/bloc/add_drop_to_route_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_spot_for_drop_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/secondary_title.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/value_picked_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddDropToRoutePage extends BlocWidget<AddDropToRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final Function addDrop;
  final DateTime lastDropEndTime;

  AddDropToRoutePage({@required this.addDrop, this.lastDropEndTime});
  @override
  bloc() => AddDropToRouteBloc();

  @override
  Widget build(BuildContext context, AddDropToRouteBloc addDropToRouteBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 23.0, right: 23.0),
          child: ListView(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.addDropToRoute,
                      style: themeConfig.textStyles.primaryTitle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    secondaryTitle(locale.nameMandatory),
                    DhPlainTextFormField(
                      hintText: locale.dropNameExample,
                      onChanged: (String name) {
                        addDropToRouteBloc.add(
                            FormChanged(drop: addDropToRouteBloc.state.drop.copyWith(name: name)));
                      },
                    ),
                    secondaryTitle(locale.spotMandatory),
                    SizedBox(
                      height: 6.0,
                    ),
                    BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
                        builder: (context, state) => Conditional.single(
                              context: context,
                              conditionBuilder: (_) => state.spot?.name == null,
                              widgetBuilder: (_) =>
                                  _buildSpotAddButton(locale, context, addDropToRouteBloc),
                              fallbackBuilder: (_) => SpotCard(state.spot, addDropToRouteBloc),
                            )),
                    secondaryTitle(locale.startTimeMandatory),
                    startTimeButton(locale, addDropToRouteBloc),
                    secondaryTitle(locale.endTimeMandatory),
                    endTimeButton(locale, addDropToRouteBloc),
                    SizedBox(height: 6.0),
                    secondaryTitle(locale.description),
                    DhTextArea(
                      onChanged: (String description) {
                        addDropToRouteBloc.add(
                          FormChanged(
                              drop:
                                  addDropToRouteBloc.state.drop.copyWith(description: description)),
                        );
                      },
                      value: addDropToRouteBloc.state.drop?.description,
                    ),
                    BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
                      buildWhen: (previous, current) => previous.isFilled != current.isFilled,
                      builder: (context, state) => Center(
                          child: SubmitFormButton(
                              text: locale.addDrop,
                              isActive: state.isFilled,
                              onTap: () {
                                if (state.isFilled) {
                                  DateFormat format = DateFormat("HH:mm");
                                  DateTime start =
                                      format.parse(addDropToRouteBloc.state.drop.startTime);
                                  DateTime end =
                                      format.parse(addDropToRouteBloc.state.drop.endTime);
                                  if (end.isBefore(start)) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(locale.endTimeBeforeStartTime),
                                    ));
                                  } else if (lastDropEndTime != null &&
                                      start.isBefore(lastDropEndTime)) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(locale.dropStartTimeBeforePreviousDropEndTime),
                                    ));
                                  } else {
                                    addDropToRouteBloc.add(FormSubmitted());
                                    addDrop(addDropToRouteBloc.state.drop);
                                    Get.back();
                                  }
                                }
                              })),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget endTimeButton(LocaleBundle locale, AddDropToRouteBloc addDropToRouteBloc) {
    return BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
        buildWhen: (previous, current) => previous.drop.endTime != current.drop.endTime,
        builder: (context, state) => Conditional.single(
            context: context,
            conditionBuilder: (_) => state.drop.endTime == null,
            widgetBuilder: (_) =>
                _buildTimePickerButton(locale, context, addDropToRouteBloc, PickTime.END),
            fallbackBuilder: (_) => ValuePickedFlatButton(
                  text: state.drop.endTime,
                  onTap: () {
                    chooseTime(context, addDropToRouteBloc, PickTime.END);
                  },
                )));
  }

  Widget startTimeButton(LocaleBundle locale, AddDropToRouteBloc addDropToRouteBloc) {
    return BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
        buildWhen: (previous, current) => previous.drop.startTime != current.drop.startTime,
        builder: (context, state) => Conditional.single(
            context: context,
            conditionBuilder: (_) => state.drop.startTime == null,
            widgetBuilder: (_) =>
                _buildTimePickerButton(locale, context, addDropToRouteBloc, PickTime.START),
            fallbackBuilder: (_) => ValuePickedFlatButton(
                  text: state.drop.startTime,
                  onTap: () {
                    chooseTime(context, addDropToRouteBloc, PickTime.START);
                  },
                )));
  }

  ColoredRoundedFlatButton _buildSpotAddButton(
      LocaleBundle locale, BuildContext context, AddDropToRouteBloc bloc) {
    return ColoredRoundedFlatButton(
      text: locale.addSpotButton,
      onTap: () => navigateToChooseSpotForDropPage(bloc),
    );
  }

  ColoredRoundedFlatButton _buildTimePickerButton(
      LocaleBundle locale, BuildContext context, AddDropToRouteBloc bloc, PickTime pickTime) {
    return ColoredRoundedFlatButton(
      text: locale.pickTime,
      onTap: () {
        chooseTime(context, bloc, pickTime);
      },
    );
  }

  void chooseTime(BuildContext context, AddDropToRouteBloc bloc, PickTime pickTime) async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    //TODO add with another state
    bloc.add(FormChanged(
        drop: pickTime == PickTime.START
            ? bloc.state.drop.copyWith(startTime: formatTimeOfDay(timeOfDay))
            : bloc.state.drop.copyWith(endTime: formatTimeOfDay(timeOfDay))));
  }
}

TimeOfDay timeConvert(String normTime) {
  int hour;
  int minute;
  String ampm = normTime.substring(normTime.length - 2);
  String result = normTime.substring(0, normTime.indexOf(' '));
  if (ampm == 'AM' && int.parse(result.split(":")[1]) != 12) {
    hour = int.parse(result.split(':')[0]);
    if (hour == 12) hour = 0;
    minute = int.parse(result.split(":")[1]);
  } else {
    hour = int.parse(result.split(':')[0]) - 12;
    if (hour <= 0) {
      hour = 24 + hour;
    }
    minute = int.parse(result.split(":")[1]);
  }
  return TimeOfDay(hour: hour, minute: minute);
}

enum PickTime { START, END }

void navigateToChooseSpotForDropPage(AddDropToRouteBloc bloc) {
  Get.to(ChooseSpotForDropPage(
    addSpot: (SpotCompanyResponse spot) {
      bloc.add(FormChanged(spot: spot, drop: bloc.state.drop.copyWith(spotId: spot.id)));
    },
  ));
}

class SpotCard extends StatelessWidget {
  final SpotCompanyResponse spot;
  final AddDropToRouteBloc bloc;
  const SpotCard(this.spot, this.bloc);

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return GestureDetector(
      onTap: () => navigateToChooseSpotForDropPage(bloc),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Container(
          child: ListTile(
            leading: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.store,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                spot.name,
                style: themeConfig.textStyles.secondaryTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spot.description ?? '',
                  style: themeConfig.textStyles.cardSubtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                FutureBuilder(
                    future: getAddressFromCoordinates(spot.xcoordinate, spot.ycoordinate) ?? '',
                    initialData: "Loading location...",
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return Text(
                        snapshot.data ?? "",
                        style: themeConfig.textStyles.cardSubtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }),
                SizedBox(height: 4.0),
              ],
            ),
            trailing: Icon(Icons.edit),
          ),
          decoration: BoxDecoration(
            color: themeConfig.colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              dhShadow(),
            ],
          ),
        ),
      ),
    );
  }
}
