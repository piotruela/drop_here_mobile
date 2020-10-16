import 'package:drop_here_mobile/accounts/bloc/add_spot_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_floating_action_button.dart';
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
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'file:///E:/Piotr%20Maszota/inzynierka/drop_here_mobile/lib/common/ui/widgets/labeled_switch.dart';

class AddSpotPage extends BlocWidget<AddSpotBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  AddSpotBloc bloc() => AddSpotBloc();

  @override
  Widget build(BuildContext context, AddSpotBloc addSpotBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SlidingUpPanel(
        defaultPanelState: PanelState.OPEN,
        maxHeight: 550,
        body: Center(
          child: Text('background'),
        ),
        panel: SafeArea(
          child: BlocBuilder<AddSpotBloc, AddSpotFormState>(builder: (context, state) {
            return ListView(
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        locale.addSpot,
                        style: themeConfig.textStyles.primaryTitle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      _spotNameField(locale, addSpotBloc),
                      labeledSwitch(
                          text: locale.passwordRequired,
                          onSwitch: (bool) => addSpotBloc.add(FormChanged(
                              spotManagementRequest:
                                  state.spotManagementRequest.copyWith(requiredPassword: bool)))),
                      _passwordFieldView(locale, addSpotBloc),
                      labeledSwitch(
                          text: locale.acceptRequired,
                          onSwitch: (bool) => addSpotBloc.add(FormChanged(
                              spotManagementRequest:
                                  state.spotManagementRequest.copyWith(requiredAccept: bool)))),
                      labeledSwitch(
                          text: locale.spotHidden,
                          onSwitch: (bool) => addSpotBloc.add(FormChanged(
                              spotManagementRequest:
                                  state.spotManagementRequest.copyWith(hidden: bool)))),
                      secondaryTitle(locale.locationMandatory),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ColoredRoundedFlatButton(
                          text: locale.addLocationButton,
                        ),
                      ),
                      secondaryTitle(locale.description),
                      DhTextArea(
                          //TODO add onChanged
                          ),
                      secondaryTitle(locale.plannedRoutes),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ColoredRoundedFlatButton(
                          text: locale.addRouteButton,
                        ),
                      ),
                      secondaryTitle(locale.members),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ColoredRoundedFlatButton(
                          text: locale.addMemberButton,
                        ),
                      ),
                      Center(
                        child: BigColoredRoundedFlatButton(
                            text: locale.addSpot,
                            isActive: state.isFilled(),
                            //TODO check this function
                            onTap: () {
                              addSpotBloc.add(FormSubmitted());
                            }),
                      ),
                      SizedBox(
                        height: 15.0,
                      )
                    ]),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  BlocBuilder<AddSpotBloc, AddSpotFormState> floatingButton(String text, LocaleBundle locale) {
    return BlocBuilder<AddSpotBloc, AddSpotFormState>(
        buildWhen: (previous, current) => current.isFilled(),
        builder: (context, state) {
          return dhFloatingButton(text: locale.addSpot, enabled: state.isFilled());
        });
  }

  Widget _spotNameField(LocaleBundle locale, AddSpotBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondaryTitle(locale.nameMandatory),
        DhPlainTextFormField(
            inputType: InputType.text,
            hintText: locale.addSpotNameHint,
            onChanged: (String name) => bloc.add(FormChanged(
                spotManagementRequest: bloc.state.spotManagementRequest.copyWith(name: name)))),
      ],
    );
  }

  Widget _passwordFieldView(LocaleBundle locale, AddSpotBloc bloc) {
    return BlocBuilder<AddSpotBloc, AddSpotFormState>(
      buildWhen: (previous, current) =>
          previous.spotManagementRequest.requiredPassword !=
          current.spotManagementRequest.requiredPassword,
      builder: (context, state) => Conditional.single(
          context: context,
          conditionBuilder: (_) => state.spotManagementRequest.requiredPassword,
          widgetBuilder: (_) => _spotPasswordField(locale, bloc),
          fallbackBuilder: (_) => SizedBox.shrink()),
    );
  }

  Widget _spotPasswordField(LocaleBundle locale, AddSpotBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondaryTitle(locale.passwordMandatory),
        DhPlainTextFormField(
            inputType: InputType.text,
            hintText: locale.passwordHintText,
            onChanged: (String password) => bloc.add(FormChanged(
                spotManagementRequest:
                    bloc.state.spotManagementRequest.copyWith(password: password)))),
      ],
    );
  }
}
