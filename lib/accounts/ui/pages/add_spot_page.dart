import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/bloc/add_spot_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddSpotPage extends BlocWidget<AddSpotBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  AddSpotBloc bloc() => AddSpotBloc();

  @override
  Widget build(BuildContext context, AddSpotBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SlidingUpPanel(
        defaultPanelState: PanelState.OPEN,
        maxHeight: 550,
        panel: ListView(
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
                  _spotNameField(locale, bloc),
                  labeledSwitch(
                      text: locale.passwordRequired,
                      onSwitch: (bool) => bloc.add(FormChanged(
                          spotManagementRequest:
                              bloc.state.spotManagementRequest.copyWith(requiresPassword: bool)))),
                  _passwordFieldView(locale, bloc),
                  labeledSwitch(
                      text: locale.acceptRequired,
                      onSwitch: (bool) => bloc.add(FormChanged(
                          spotManagementRequest:
                              bloc.state.spotManagementRequest.copyWith(requiresAccept: bool)))),
                  labeledSwitch(
                      text: locale.spotHidden,
                      onSwitch: (bool) => bloc.add(FormChanged(
                          spotManagementRequest:
                              bloc.state.spotManagementRequest.copyWith(hidden: bool)))),
                  secondaryTitle(locale.locationMandatory),
                  BlocBuilder<AddSpotBloc, AddSpotFormState>(
                    buildWhen: (previous, current) =>
                        previous.spotManagementRequest.xcoordinate !=
                        current.spotManagementRequest.xcoordinate,
                    builder: (context, state) {
                      return Conditional.single(
                          context: context,
                          conditionBuilder: (_) => state.spotManagementRequest?.xcoordinate == null,
                          widgetBuilder: (_) => _buildLocationPickerButton(context, locale, bloc),
                          fallbackBuilder: (_) => _buildPickedLocationView(bloc));
                    },
                  ),
                  _buildDescriptionField(locale, bloc),
                  /*secondaryTitle(locale.plannedRoutes), //TODO:Uncomment when able to add those parameters
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
                  ),*/
                  BlocBuilder<AddSpotBloc, AddSpotFormState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) => Center(
                      child: SubmitFormButton(
                          text: locale.addSpot,
                          isActive: bloc.state.isFilled,
                          onTap: () => bloc.add(FormSubmitted(
                              spotManagementRequest: bloc.state.spotManagementRequest))),
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPickerButton(
      BuildContext context, LocaleBundle localeBundle, AddSpotBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ColoredRoundedFlatButton(
          text: localeBundle.addLocationButton,
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            bloc.add(LocationChanged(
                spotManagementRequest: bloc.state.spotManagementRequest,
                locationResult: await showLocationPicker(
                    context, "AIzaSyAIXlbOX2W1TEKdG8M8zyvZc882lEApzLE",
                    automaticallyAnimateToCurrentLocation: false,
                    initialCenter: LatLng(54.397498, 18.589627))));
          }),
    );
  }

  Widget _buildPickedLocationView(AddSpotBloc bloc) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.pin_drop,
              color: themeConfig.colors.black,
            ),
            FutureBuilder(
                future: getAddressFromCoordinates(bloc.state.spotManagementRequest.xcoordinate,
                    bloc.state.spotManagementRequest.ycoordinate),
                initialData: "Loading location...",
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Text(
                    snapshot.data ?? "",
                    style: themeConfig.textStyles.filledTextField,
                  );
                }),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => bloc.add(FormChanged(
                    spotManagementRequest:
                        bloc.state.spotManagementRequest.copyWith(coordsNull: true)))),
          ],
        ),
        BlocBuilder<AddSpotBloc, AddSpotFormState>(
            buildWhen: (previous, current) =>
                previous.spotManagementRequest.estimatedRadiusMeters !=
                current.spotManagementRequest.estimatedRadiusMeters,
            builder: (context, state) => SizedBox.shrink())
      ],
    );
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
              spotManagementRequest: bloc.state.spotManagementRequest.copyWith(name: name))),
          /*onSuffixPressed: () => bloc.add(FormChanged(
              spotManagementRequest: bloc.state.spotManagementRequest.copyWith(nameNull: true))),*/ //TODO:Uncomment when fixed
        ),
      ],
    );
  }

  Widget _passwordFieldView(LocaleBundle locale, AddSpotBloc bloc) {
    return BlocBuilder<AddSpotBloc, AddSpotFormState>(
      buildWhen: (previous, current) =>
          previous.spotManagementRequest.requiresPassword !=
          current.spotManagementRequest.requiresPassword,
      builder: (context, state) => Conditional.single(
          context: context,
          conditionBuilder: (_) => state.spotManagementRequest.requiresPassword,
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

  Widget _buildDescriptionField(LocaleBundle localeBundle, AddSpotBloc bloc) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      secondaryTitle(localeBundle.description),
      DhPlainTextFormField(
        inputType: InputType.text,
        onChanged: (String description) => bloc.add(FormChanged(
            spotManagementRequest:
                bloc.state.spotManagementRequest.copyWith(description: description))),
      ),
    ]);
  }
}
