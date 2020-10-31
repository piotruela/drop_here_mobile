import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_card.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/bloc/company_spots_bloc.dart';
import 'package:drop_here_mobile/spots/bloc/customer_spots_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomerSpotDetailsPage extends AbsSpotDetailsPage {
  final SpotBaseCustomerResponse spot;
  final PanelController controller;
  final CustomerSpotsBloc customerSpotsBloc;

  CustomerSpotDetailsPage({this.spot, this.controller, this.customerSpotsBloc});

  @override
  Widget buildColumnWithData(LocaleBundle locale, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          closeIcon(controller),
          buildSpotTitle(),
          buildLocationInfo(),
          textAndFlatButton(locale.passwordRequired, requiresPassword ? locale.yes : locale.no),
          Divider(),
          textAndFlatButton(locale.acceptRequired, requiresAccept ? locale.yes : locale.no),
          Divider(),
          buildInfoWithLabel(locale, locale.description, description),
          Align(child: conditionalWidget(context))
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

  @override
  get closePanelAction => null;

  Widget conditionalWidget(BuildContext context) {
    if (spot.membershipStatus == null) {
      return SubmitFormButton(
          isActive: true,
          onTap: () async {
            SpotJoinRequest request = await showDialog(
                context: context,
                child: _joiningDialog(context, spot.requiresPassword, spot.requiresAccept));
            if (request != null) {
              customerSpotsBloc.add(SendSpotJoiningRequest(
                  spotUid: spot.uid, companyUid: spot.companyUid, request: request));
            }
          },
          text: "Join");
    } else if (spot.membershipStatus == MembershipStatus.PENDING) {
      return warningText(Colors.yellow, "Your joining request is waiting\nto be approved by owner");
    } else if (spot.membershipStatus == MembershipStatus.BLOCKED) {
      return warningText(themeConfig.colors.blocked, "Company blocked you\nfrom this spot");
    } else {
      return warningText(themeConfig.colors.active, "YOU ARE MEMBER");
    }
  }

  Widget warningText(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(Icons.warning, color: color),
        ),
        Text(text, style: themeConfig.textStyles.secondaryTitle.copyWith(color: color))
      ],
    );
  }

  Widget _joiningDialog(BuildContext context, bool passwordRequired, bool acceptRequired) {
    SpotJoinRequest request = SpotJoinRequest();
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(child: Text("Joining spot", style: themeConfig.textStyles.secondaryTitle)),
            Text(
              "Notification settings",
              style: themeConfig.textStyles.dataAnnotation,
            ),
            labeledSwitch(
                text: "When canceled",
                initialPosition: false,
                onSwitch: (bool) => request.receiveCancelledNotifications = bool),
            labeledSwitch(
                text: "When delayed",
                initialPosition: false,
                onSwitch: (bool) => request.receiveDelayedNotifications = bool),
            labeledSwitch(
                text: "When finished",
                initialPosition: false,
                onSwitch: (bool) => request.receiveFinishedNotifications = bool),
            labeledSwitch(
                text: "When prepared",
                initialPosition: false,
                onSwitch: (bool) => request.receivePreparedNotifications = bool),
            passwordRequired
                ? DhPlainTextFormField(
                    inputType: InputType.text,
                    hintText: "Aezakmi",
                    onChanged: (String password) => request.password = password)
                : SizedBox.shrink(),
            acceptRequired
                ? warningText(
                    themeConfig.colors.black, "Your joining must be\napproved by the owner")
                : SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  child: Text("Cancel", style: themeConfig.textStyles.blocked),
                  onPressed: () => Navigator.pop(context, null),
                ),
                RaisedButton(
                  child: Text("Submit", style: themeConfig.textStyles.active),
                  onPressed: () => Navigator.pop(context, request),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CompanySpotDetailsPage extends AbsSpotDetailsPage {
  final SpotCompanyResponse spot;
  final PanelController controller;
  final CompanySpotsBloc bloc;
  final SpotMembershipPage members;

  CompanySpotDetailsPage({this.spot, this.controller, this.bloc, this.members});

  @override
  String get name => spot.name;

  @override
  String get description => spot.description;

  @override
  Widget get iconButton => GestureDetector(
      onTap: () => {},
      child: CircleAvatar(
        backgroundColor: themeConfig.colors.black,
        child: CircleAvatar(
          backgroundColor: themeConfig.colors.white,
          radius: 18.0,
          child: Icon(
            Icons.edit,
            color: Colors.black,
            size: 20.0,
          ),
        ),
      ));
  @override
  bool get requiresAccept => spot.requiresAccept;

  @override
  bool get requiresPassword => spot.requiresPassword;

  @override
  double get xcoord => spot.xcoordinate;

  @override
  double get ycoord => spot.ycoordinate;

  @override
  get closePanelAction => () => bloc.add(CloseSpotDetailsPanel());

  @override
  Widget buildColumnWithData(LocaleBundle locale, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          closeIcon(controller),
          buildSpotTitle(),
          buildLocationInfo(),
          textAndFlatButton(
              locale.passwordRequired, spot.requiresPassword ? locale.yes : locale.no),
          spot.requiresPassword ? _PasswordInfo(password: spot.password) : SizedBox.shrink(),
          Divider(),
          textAndFlatButton(locale.acceptRequired, requiresAccept ? locale.yes : locale.no),
          Divider(),
          textAndFlatButton(locale.hidden, spot.hidden ? locale.yes : locale.no),
          Divider(),
          buildInfoWithLabel(locale, locale.description, description),
          Divider(),
          Text(
            locale.members,
            style: themeConfig.textStyles.dataAnnotation,
          ),
          _buildMembersList()
        ],
      ),
    );
  }

  Widget _buildMembersList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: members.content.length * 7,
      itemBuilder: (BuildContext context, int index) {
        return DhCard(
          title: members.content[0].firstName,
          isActive: members.content[0].membershipStatus == MembershipStatus.ACTIVE,
        );
      },
    );
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

  VoidCallback get closePanelAction;

  BoxDecoration get _panelDecoration => BoxDecoration(
      color: themeConfig.colors.white,
      borderRadius:
          const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)));

  @override
  Widget build(BuildContext context) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Container(
      decoration: _panelDecoration,
      child: buildColumnWithData(localeBundle, context),
    );
  }

  Widget buildColumnWithData(LocaleBundle locale, BuildContext context);

  @protected
  Widget buildSpotTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
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
      Text(
        label,
        style: themeConfig.textStyles.dataAnnotation,
      ),
      Text(
        content ?? locale.noContent,
        style: themeConfig.textStyles.data,
      )
    ]);
  }

  @protected
  Widget closeIcon(PanelController controller) {
    return Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
            child: Icon(
              Icons.close,
              size: 40,
            ),
            onTap: () {
              controller.hide();
              closePanelAction?.call();
            }));
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
