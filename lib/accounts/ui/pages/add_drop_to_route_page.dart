import 'package:drop_here_mobile/accounts/ui/pages/choose_spot_for_drop_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/secondary_title.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/info_text.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/bloc/add_drop_to_route_bloc/add_drop_to_route_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/spots/ui/widgets/spot_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class AddDropToRoutePage extends BlocWidget<AddDropToRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final RouteDropRequest drop;
  final TimeOfDay minTime;

  AddDropToRoutePage({this.drop, this.minTime});

  @override
  bloc() => AddDropToRouteBloc()..add(CreateDropPageEntered(drop: drop));

  @override
  Widget build(BuildContext context, AddDropToRouteBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 23.0),
          child: ListView(
            children: [
              Column(
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
                    onChanged: (value) => bloc.add(FormChanged(drop: bloc.state.drop.copyWith(name: value))),
                  ),
                  secondaryTitle(locale.spotMandatory),
                  BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
                      builder: (context, state) => Conditional.single(
                            context: context,
                            conditionBuilder: (_) => state.selectedSpot == null,
                            widgetBuilder: (_) => _buildSpotAddButton(locale, context, bloc),
                            fallbackBuilder: (_) => CompanyDropSpotCard(
                              spot: state.selectedSpot,
                              onTap: () async => bloc.add(SpotSelected(
                                  spot: await Get.to(ChooseSpotForDropPage(selectedSpot: bloc.state.selectedSpot)))),
                            ),
                          )),
                  secondaryTitle(locale.startTimeMandatory),
                  InfoText(text: "Start time have to be after ${minTime.format(context)}"),
                  BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
                      buildWhen: (previous, current) => previous.drop?.startTime != current.drop?.startTime,
                      builder: (context, state) => startTimePicker(bloc, context)),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: Conditional.list(
                          context: context,
                          conditionBuilder: (_) => bloc.state.drop?.startTime != null,
                          widgetBuilder: (_) => [
                                secondaryTitle(locale.endTimeMandatory),
                                InfoText(text: "End time have to be after ${bloc.state.drop?.startTime}"),
                                BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
                                    buildWhen: (previous, current) => previous.drop.endTime != current.drop.endTime,
                                    builder: (context, state) => endTimePicker(bloc, context)),
                              ],
                          fallbackBuilder: (_) => [SizedBox.shrink()])),
                  secondaryTitle(locale.descriptionMandatory),
                  DhPlainTextFormField(
                    onChanged: (value) => bloc.add(FormChanged(drop: bloc.state.drop.copyWith(description: value))),
                  ),
                  BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
                    buildWhen: (previous, current) => previous.isFilled != current.isFilled,
                    builder: (context, state) => Align(
                      child: SubmitFormButton(
                        text: "Add drop",
                        onTap: () => bloc.add(FormSubmitted()),
                        isActive: bloc.state.isFilled,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget startTimePicker(AddDropToRouteBloc bloc, BuildContext context) {
    return ChoosableButton(
        text: bloc.state?.drop?.startTime ?? "Start time",
        chooseAction: () async {
          TimeOfDay pickedTime = await showTimePicker(
              initialEntryMode: TimePickerEntryMode.input, context: context, initialTime: TimeOfDay.now());
          if (pickedTime != null) {
            if (minTime.isAfter(pickedTime)) {
              pickedTime = await showDialog(
                  context: context, child: wrongTimeDialog(context: context, minTime: minTime, proposeTime: true));
            }
            if (pickedTime != null) {
              bloc.add(FormChanged(
                  drop: bloc.state.drop.copyWith(startTime: pickedTime.format(context), endTimeNull: true)));
            }
          }
        });
  }

  Widget endTimePicker(AddDropToRouteBloc bloc, BuildContext context) {
    TimeOfDay minEndTime = bloc.state.drop?.startTime?.toTimeOfDay;
    return ChoosableButton(
        text: bloc.state.drop?.endTime ?? "End time",
        chooseAction: () async {
          TimeOfDay pickedTime = await showTimePicker(
              initialEntryMode: TimePickerEntryMode.input, context: context, initialTime: TimeOfDay.now());
          if (pickedTime != null) {
            if (minEndTime.isAfter(pickedTime)) {
              pickedTime =
                  await showDialog(context: context, child: wrongTimeDialog(context: context, minTime: minEndTime));
            }
            if (pickedTime != null) {
              bloc.add(FormChanged(drop: bloc.state.drop.copyWith(endTime: pickedTime.format(context))));
            }
          }
        });
  }

  Widget wrongTimeDialog({BuildContext context, TimeOfDay minTime, bool proposeTime = false}) {
    return AlertDialog(
        title: Text("Wrong date"),
        actions: [
          proposeTime
              ? RaisedButton(
                  child: Text("Set to ${minTime.format(context)}"), onPressed: () => Navigator.pop(context, minTime))
              : SizedBox.shrink(),
          RaisedButton(child: Text("I'll pick other time"), onPressed: () => Navigator.pop(context, null))
        ],
        content: Text("Start time of this drop, have to be after " + minTime.format(context)));
  }

  ColoredRoundedFlatButton _buildSpotAddButton(LocaleBundle locale, BuildContext context, AddDropToRouteBloc bloc) {
    return ColoredRoundedFlatButton(
      text: locale.addSpotButton,
      onTap: () async =>
          bloc.add(SpotSelected(spot: await Get.to(ChooseSpotForDropPage(selectedSpot: bloc.state.selectedSpot)))),
    );
  }
}
