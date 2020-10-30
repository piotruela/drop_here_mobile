import 'package:drop_here_mobile/accounts/ui/pages/edit_spot_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/edit_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/bloc/spot_details_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomerSpotDetailsPage extends AbsSpotDetailsPage {
  final SpotBaseCustomerResponse spot;
  final PanelController controller;

  CustomerSpotDetailsPage({this.spot, this.controller});

  @override
  Widget buildColumnWithData(LocaleBundle locale) {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 40,
                ),
                onPressed: () => controller.hide(),
              )),
          buildSpotTitle(),
          buildLocationInfo(),
          textAndFlatButton(locale.passwordRequired, requiresPassword ? locale.yes : locale.no),
          Divider(),
          textAndFlatButton(locale.acceptRequired, requiresAccept ? locale.yes : locale.no),
          Divider(),
          buildInfoWithLabel(locale, locale.description, description),
          Align(child: conditionalWidget())
        ],
      ),
    );
  }

  @override
  Widget get iconButton => null;

  @override
  String get name => spot.name;

  @override
  bool get requiresAccept => spot.requiresAccept;

  @override
  bool get requiresPassword => spot.requiresPassword;

  @override
  double get xcoord => spot.xcoordinate;

  @override
  double get ycoord => spot.ycoordinate;

  @override
  String get description => spot.description;

  Widget conditionalWidget() {
    if (spot.membershipStatus == null) {
      return SizedBox(
          child: ColoredRoundedFlatButton(
              text: "Join",
              style: themeConfig.textStyles.bigColoredButtonActiveTextStyle,
              onTap: () => {}));
    } else {
      return SizedBox.shrink();
    }
  }
}

abstract class AbsSpotDetailsPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  String get name;

  Widget get iconButton;

  double get xcoord;

  double get ycoord;

  bool get requiresPassword;

  bool get requiresAccept;

  String get description;

  Widget buildColumnWithData(LocaleBundle locale) {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0),
      child: ListView(
        children: [
          buildSpotTitle(),
          buildLocationInfo(),
          textAndFlatButton(locale.passwordRequired, requiresPassword ? locale.yes : locale.no),
          Divider(),
          textAndFlatButton(locale.acceptRequired, requiresAccept ? locale.yes : locale.no),
          Divider(),
          buildInfoWithLabel(locale, locale.description, description),
          Divider(),
          Text(
            locale.plannedDrops,
            style: themeConfig.textStyles.dataAnnotation,
          ),
          Divider(),
          Text(
            locale.members,
            style: themeConfig.textStyles.dataAnnotation,
          ),
        ],
      ),
    );
  }

  BoxDecoration get _panelDecoration => BoxDecoration(
      color: themeConfig.colors.white,
      borderRadius:
          const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)));

  @override
  Widget build(BuildContext context) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Container(
      decoration: _panelDecoration,
      child: buildColumnWithData(localeBundle),
    );
  }

  @protected
  Widget buildSpotTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Text(
            name,
            style: themeConfig.textStyles.primaryTitle,
          ),
          iconButton ?? SizedBox.shrink()
        ],
      ),
    );
  }

  @protected
  Widget buildLocationInfo() {
    return Row(
      children: [
        Icon(
          Icons.pin_drop,
          color: themeConfig.colors.black,
        ),
        FutureBuilder(
            future: getAddressFromCoordinates(xcoord, ycoord),
            initialData: "Loading location...",
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text(
                snapshot.data ?? "",
                style: themeConfig.textStyles.filledTextField,
              );
            })
      ],
    );
  }

  @protected
  Widget textAndFlatButton(String text, String flatButtonText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: themeConfig.textStyles.dataAnnotation,
        ),
        RoundedFlatButton(
          text: flatButtonText,
        ),
      ],
    );
  }

  @protected
  Widget buildInfoWithLabel(LocaleBundle locale, String label, String content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          label,
          style: themeConfig.textStyles.dataAnnotation,
        ),
      ),
      Text(
        content ?? locale.noContent,
        style: themeConfig.textStyles.data,
      )
    ]);
  }
}

class SpotDetailsPage extends BlocWidget<SpotDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final SpotCompanyResponse spot;

  SpotDetailsPage({this.spot});

  @override
  SpotDetailsBloc bloc() => SpotDetailsBloc()..add(FetchSpotDetails(spot: spot));

  @override
  Widget build(BuildContext context, SpotDetailsBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return (Scaffold(
      body: SafeArea(
        child: BlocBuilder<SpotDetailsBloc, SpotDetailsState>(
          builder: (context, state) {
            if (state is SpotDetailsInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SpotDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SpotDetailsFetchingError) {
              return Container(child: Text(state.error));
            } else if (state is SpotDetailsFetched) {
              return buildColumnWithData(locale, state);
            }
            return Container();
          },
        ),
      ),
    ));
  }

  Widget buildColumnWithData(LocaleBundle locale, SpotDetailsFetched state) {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0),
      child: ListView(
        children: [
          _buildSpotTitle(),
          _buildLocationInfo(),
          textAndFlatButton(
              locale.passwordRequired, state.spot.requiresPassword ? locale.yes : locale.no),
          spot.requiresPassword ? _PasswordInfo(password: spot.password) : SizedBox.shrink(),
          Divider(),
          textAndFlatButton(
              locale.acceptRequired, state.spot.requiresAccept ? locale.yes : locale.no),
          Divider(),
          textAndFlatButton(locale.hidden, state.spot.hidden ? locale.yes : locale.no),
          Divider(),
          _buildInfoWithLabel(locale, locale.description, null),
          Divider(),
          Text(
            locale.plannedDrops,
            style: themeConfig.textStyles.dataAnnotation,
          ),
          Divider(),
          Text(
            locale.members,
            style: themeConfig.textStyles.dataAnnotation,
          ),
        ],
      ),
    );
  }

  Widget _buildSpotTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Text(
            spot.name,
            style: themeConfig.textStyles.primaryTitle,
          ),
          editButton(onPressed: () => Get.to(EditSpotPage(spot: spot)))
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        Icon(
          Icons.pin_drop,
          color: themeConfig.colors.black,
        ),
        FutureBuilder(
            future: getAddressFromCoordinates(spot.xcoordinate, spot.ycoordinate),
            initialData: "Loading location...",
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text(
                snapshot.data ?? "",
                style: themeConfig.textStyles.filledTextField,
              );
            })
      ],
    );
  }

  Widget _buildInfoWithLabel(LocaleBundle locale, String label, String content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          label,
          style: themeConfig.textStyles.dataAnnotation,
        ),
      ),
      Text(
        content ?? locale.noContent,
        style: themeConfig.textStyles.data,
      )
    ]);
  }

  Widget textAndFlatButton(String text, String flatButtonText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: themeConfig.textStyles.dataAnnotation,
        ),
        RoundedFlatButton(
          text: flatButtonText,
        ),
      ],
    );
  }
}

class _PasswordInfo extends StatefulWidget {
  final String password;

  _PasswordInfo({this.password});

  @override
  _PasswordInfoState createState() => _PasswordInfoState(show: false);
}

class _PasswordInfoState extends State<_PasswordInfo> {
  bool show;

  _PasswordInfoState({this.show});

  @override
  void initState() {
    super.initState();
    show = show;
  }

  @override
  Widget build(BuildContext context) {
    ThemeConfig themeConfig = Get.find<ThemeConfig>();
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              localeBundle.password,
              style: themeConfig.textStyles.dataAnnotation,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                show
                    ? widget.password
                    : List.generate(widget.password.length, (index) => "*").join(),
                style: themeConfig.textStyles.data,
              ),
            ),
          ],
        ),
        ColoredRoundedFlatButton(
          text: show ? localeBundle.hidePassword : localeBundle.showPassword,
          onTap: () => setState(() => show = !show),
        )
      ],
    );
  }
}
