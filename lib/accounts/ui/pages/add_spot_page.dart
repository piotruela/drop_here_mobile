import 'package:drop_here_mobile/accounts/bloc/add_spot_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_floating_action_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/row_text_and_slider.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddSpotPage extends BlocWidget<AddSpotBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  AddSpotBloc bloc() => AddSpotBloc();

  @override
  Widget build(BuildContext context, AddSpotBloc addSpotBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SlidingUpPanel(
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
                      secondaryTitle(locale.nameMandatory),
                      DhPlainTextFormField(
                          inputType: InputType.text,
                          hintText: locale.addSpotNameHint,
                          onChanged: (String name) => addSpotBloc.add(FormChanged(
                              spotManagementRequest:
                                  state.spotManagementRequest.copyWith(name: name)))),
                      rowTextAndSlider(text: locale.passwordRequired),
                      secondaryTitle(locale.passwordMandatory),
                      DhPlainTextFormField(
                          inputType: InputType.text,
                          hintText: locale.passwordHintText,
                          onChanged: (String password) => addSpotBloc.add(FormChanged(
                              spotManagementRequest:
                                  state.spotManagementRequest.copyWith(password: password)))),
                      rowTextAndSlider(text: locale.acceptRequired),
                      rowTextAndSlider(text: locale.spotHidden),
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
}
