import 'package:drop_here_mobile/accounts/bloc/add_drop_to_route_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

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
                      // onChanged: (String name) {
                      //   addDropToRouteBloc.add(FormChanged(
                      //       routeRequest: addDropToRouteBloc.state.routeRequest.copyWith(name: name)));
                      // },
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
                              fallbackBuilder: (_) => Text('eh'),
                            )),
                    secondaryTitle(locale.timeMandatory),
                    _buildTimePickerButton(locale, context, addDropToRouteBloc),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
      LocaleBundle locale, BuildContext context, AddDropToRouteBloc bloc) {
    return ColoredRoundedFlatButton(
      text: locale.pickTime,
      onTap: () {
        chooseDate(context, bloc);
      },
    );
  }

  void chooseDate(BuildContext context, AddDropToRouteBloc bloc) async {
    TimeOfDay dateTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    //TODO add with another state
    // bloc.add(FormChanged(
    //   routeRequest: bloc.state.routeRequest.copyWith(date: dateTime),
    // ),
  }
}
