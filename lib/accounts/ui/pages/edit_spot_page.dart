import 'package:drop_here_mobile/accounts/bloc/edit_spot_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/row_text_and_slider.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/full_width_photo.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EditSpotPage extends BlocWidget<EditSpotBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  EditSpotBloc bloc() => EditSpotBloc();

  @override
  Widget build(BuildContext context, EditSpotBloc editSpotBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        body: SlidingUpPanel(
      body: Center(child: Text('background')),
      panel: SafeArea(
        child: BlocBuilder<EditSpotBloc, EditSpotFormState>(builder: (context, state) {
          return Padding(
              padding: EdgeInsets.only(left: 23.0, right: 23.0),
              child: ListView(
                children: [
                  Text(
                    locale.editSpot,
                    style: themeConfig.textStyles.primaryTitle,
                  ),
                  SizedBox(height: 23.0),
                  Text(
                    locale.nameMandatory,
                    style: themeConfig.textStyles.secondaryTitle,
                  ),
                  DhPlainTextFormField(
                    onChanged: (String name) {
                      editSpotBloc
                          .add(FormChanged(spot: state.spotManagementRequest.copyWith(name: name)));
                    },
                    initialValue: state.spotManagementRequest.name,
                  ),
                  rowTextAndSlider(
                      text: locale.passwordRequired,
                      initialPosition: state.spotManagementRequest.requiredPassword),
                  secondaryTitle(locale.passwordMandatory),
                  DhPlainTextFormField(
                    onChanged: (String password) {
                      editSpotBloc.add(FormChanged(
                          spot: state.spotManagementRequest.copyWith(password: password)));
                    },
                  ),
                  rowTextAndSlider(
                      text: locale.acceptRequired,
                      initialPosition: state.spotManagementRequest.requiredAccept),
                  rowTextAndSlider(
                      text: locale.spotHidden, initialPosition: state.spotManagementRequest.hidden),
                  secondaryTitle(locale.locationMandatory),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: themeConfig.colors.black,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          FutureBuilder(
                              future: getAddressFromCoordinates(
                                  state.spotManagementRequest.ycoordinate,
                                  state.spotManagementRequest.xcoordinate),
                              initialData: "Loading location...",
                              builder: (BuildContext context, AsyncSnapshot<String> text) {
                                return Text(
                                  text.data ?? "",
                                  style: themeConfig.textStyles.filledTextField,
                                );
                              }),
                        ],
                      ),
                      GestureDetector(
                        //TODO add onTap
                        onTap: () {},
                        child: Icon(
                          Icons.close,
                          color: themeConfig.colors.black,
                        ),
                      )
                    ],
                  ),
                  fullWidthPhoto(context, state.locationMap),
                  SizedBox(height: 8.0),
                  secondaryTitle(locale.description),
                  DhTextArea(
                      //TODO add onChanged
                      //value: state.spotManagementRequest.description,
                      ),
                  Center(
                    child: BigColoredRoundedFlatButton(
                        text: locale.submit,
                        isActive: state.isFilled(),
                        //TODO check this function
                        onTap: () {
                          editSpotBloc.add(FormSubmitted());
                        }),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ));
        }),
      ),
    ));
  }
}
