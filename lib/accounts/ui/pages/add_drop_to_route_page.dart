import 'package:drop_here_mobile/accounts/bloc/add_drop_to_route_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/value_picked_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddDropToRoutePage extends BlocWidget<AddDropToRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final Function addDrop;

  AddDropToRoutePage({@required this.addDrop});
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
                              conditionBuilder: (_) => state.drop?.spotId == null,
                              widgetBuilder: (_) =>
                                  _buildSpotAddButton(locale, context, addDropToRouteBloc),
                              fallbackBuilder: (_) => Text('TODO'),
                            )),
                    //TODO add check if endTime is after startTime
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
                            text: locale.addRoute,
                            isActive: state.isFilled,
                            //TODO check this function
                            onTap: () {
                              if (state.isFilled) {
                                addDropToRouteBloc.add(FormSubmitted());
                              }
                            }),
                      ),
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

  BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState> endTimeButton(
      LocaleBundle locale, AddDropToRouteBloc addDropToRouteBloc) {
    return BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
        buildWhen: (previous, current) => previous.drop.endTime != current.drop.endTime,
        builder: (context, state) => Conditional.single(
            context: context,
            conditionBuilder: (_) => state.drop.endTime == null,
            widgetBuilder: (_) =>
                _buildTimePickerButton(locale, context, addDropToRouteBloc, PickTime.end),
            fallbackBuilder: (_) => ValuePickedFlatButton(
                  text: state.drop.endTime,
                  onTap: () {
                    chooseTime(context, addDropToRouteBloc, PickTime.end);
                  },
                )));
  }

  BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState> startTimeButton(
      LocaleBundle locale, AddDropToRouteBloc addDropToRouteBloc) {
    return BlocBuilder<AddDropToRouteBloc, AddDropToRouteFormState>(
        buildWhen: (previous, current) => previous.drop.startTime != current.drop.startTime,
        builder: (context, state) => Conditional.single(
            context: context,
            conditionBuilder: (_) => state.drop.startTime == null,
            widgetBuilder: (_) =>
                _buildTimePickerButton(locale, context, addDropToRouteBloc, PickTime.start),
            fallbackBuilder: (_) => ValuePickedFlatButton(
                  text: state.drop.startTime,
                  onTap: () {
                    chooseTime(context, addDropToRouteBloc, PickTime.start);
                  },
                )));
  }

  Text secondaryTitle(String text) {
    return Text(
      text,
      style: themeConfig.textStyles.secondaryTitle,
    );
  }

  ColoredRoundedFlatButton _buildSpotAddButton(
      LocaleBundle locale, BuildContext context, AddDropToRouteBloc bloc) {
    return ColoredRoundedFlatButton(
      text: locale.addSpotButton,
      onTap: () {
        //TODO go to spot choice
      },
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
      initialTime: bloc.state.drop.startTime != null
          ? stringToTimeOfDay(bloc.state.drop.startTime)
          : TimeOfDay.now(),
    );
    //TODO add with another state
    bloc.add(FormChanged(
        drop: pickTime == PickTime.start
            ? bloc.state.drop.copyWith(startTime: formatTimeOfDay(timeOfDay))
            : bloc.state.drop.copyWith(endTime: formatTimeOfDay(timeOfDay))));
  }
}

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

enum PickTime { start, end }
