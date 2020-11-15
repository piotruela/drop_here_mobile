import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/bloc/edit_spot_bloc/edit_spot_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditSpotPage extends BlocWidget<EditSpotBloc> {
  final SpotCompanyResponse spot;
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  EditSpotPage({this.spot});

  @override
  EditSpotBloc bloc() => EditSpotBloc(spot: spot, id: spot.id.toString());

  @override
  Widget build(BuildContext context, EditSpotBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: ListView(
        children: [
          DhBackButton(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    bloc.add(FormChanged(spot: bloc.state.spotManagementRequest.copyWith(name: name)));
                  },
                  initialValue: spot.name,
                ),
                labeledSwitch(
                    text: locale.passwordRequired,
                    initialPosition: spot.requiresPassword,
                    onSwitch: (value) => bloc.add(FormChanged(
                        spot: bloc.state.spotManagementRequest.copyWith(requiresPassword: value, passwordNull: true)))),
                _passwordFieldView(locale, bloc),
                labeledSwitch(
                    text: locale.acceptRequired,
                    initialPosition: bloc.state.spotManagementRequest.requiresAccept,
                    onSwitch: (value) =>
                        bloc.add(FormChanged(spot: bloc.state.spotManagementRequest.copyWith(requiresAccept: value)))),
                labeledSwitch(
                    text: locale.spotHidden,
                    initialPosition: bloc.state.spotManagementRequest.hidden,
                    onSwitch: (value) =>
                        bloc.add(FormChanged(spot: bloc.state.spotManagementRequest.copyWith(hidden: value)))),
                secondaryTitle(locale.locationMandatory),
                BlocBuilder<EditSpotBloc, EditSpotFormState>(
                  buildWhen: (previous, current) =>
                      previous.spotManagementRequest.xcoordinate != current.spotManagementRequest.xcoordinate,
                  builder: (context, state) {
                    return Conditional.single(
                        context: context,
                        conditionBuilder: (_) => state.spotManagementRequest?.xcoordinate == null,
                        widgetBuilder: (_) => _buildLocationPickerButton(context, locale, bloc),
                        fallbackBuilder: (_) => _buildPickedLocationView(bloc));
                  },
                ),
                _buildDescriptionField(locale, bloc),
                BlocBuilder<EditSpotBloc, EditSpotFormState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) => Center(
                    child: SubmitFormButton(
                        text: locale.addSpot,
                        isActive: bloc.state.isFilled,
                        onTap: () => bloc.add(FormSubmitted(spot: bloc.state.spotManagementRequest))),
                  ),
                ),
                SizedBox(
                  height: 150.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPickerButton(BuildContext context, LocaleBundle localeBundle, EditSpotBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ColoredRoundedFlatButton(
          text: localeBundle.addLocationButton,
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            bloc.add(LocationChanged(
                spot: bloc.state.spotManagementRequest,
                locationResult: await showLocationPicker(context, "AIzaSyAIXlbOX2W1TEKdG8M8zyvZc882lEApzLE",
                    automaticallyAnimateToCurrentLocation: false, initialCenter: LatLng(54.397498, 18.589627))));
          }),
    );
  }

  Widget _buildPickedLocationView(EditSpotBloc bloc) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.pin_drop,
              color: themeConfig.colors.black,
            ),
            FutureBuilder(
                future: getAddressFromCoordinates(
                    bloc.state.spotManagementRequest.xcoordinate, bloc.state.spotManagementRequest.ycoordinate),
                initialData: "Loading location...",
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Flexible(
                    child: Text(
                      snapshot.data ?? "",
                      style: themeConfig.textStyles.filledTextField,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () =>
                    bloc.add(FormChanged(spot: bloc.state.spotManagementRequest.copyWith(coordsNull: true)))),
          ],
        ),
        BlocBuilder<EditSpotBloc, EditSpotFormState>(
            buildWhen: (previous, current) =>
                previous.spotManagementRequest.estimatedRadiusMeters !=
                current.spotManagementRequest.estimatedRadiusMeters,
            builder: (context, state) => SizedBox.shrink())
      ],
    );
  }

  Widget _passwordFieldView(LocaleBundle locale, EditSpotBloc bloc) {
    return BlocBuilder<EditSpotBloc, EditSpotFormState>(
      buildWhen: (previous, current) =>
          previous.spotManagementRequest.requiresPassword != current.spotManagementRequest.requiresPassword,
      builder: (context, state) => Conditional.single(
          context: context,
          conditionBuilder: (_) => state.spotManagementRequest.requiresPassword,
          widgetBuilder: (_) => _spotPasswordField(locale, bloc),
          fallbackBuilder: (_) => SizedBox.shrink()),
    );
  }

  Widget _spotPasswordField(LocaleBundle locale, EditSpotBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondaryTitle(locale.passwordMandatory),
        DhPlainTextFormField(
            initialValue: bloc.state.spotManagementRequest.password,
            inputType: InputType.text,
            hintText: locale.passwordHintText,
            onChanged: (String password) =>
                bloc.add(FormChanged(spot: bloc.state.spotManagementRequest.copyWith(password: password)))),
      ],
    );
  }

  Widget _buildDescriptionField(LocaleBundle localeBundle, EditSpotBloc bloc) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      secondaryTitle(localeBundle.description),
      DhPlainTextFormField(
        inputType: InputType.text,
        onChanged: (String description) =>
            bloc.add(FormChanged(spot: bloc.state.spotManagementRequest.copyWith(description: description))),
      ),
    ]);
  }
}
