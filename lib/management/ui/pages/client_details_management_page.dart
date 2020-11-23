import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/management/bloc/client_details_management_bloc/client_details_management_bloc.dart';
import 'package:drop_here_mobile/routes/ui/pages/add_products_to_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';

class ClientDetailsManagementPage extends BlocWidget<ClientDetailsManagementBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final CompanyCustomerResponse customer;
  final bool block = true;
  final bool unblock = false;

  ClientDetailsManagementPage(this.customer);
  @override
  ClientDetailsManagementBloc bloc() =>
      ClientDetailsManagementBloc()..add(ClientDetailsInitial(customer));

  @override
  Widget build(BuildContext context, ClientDetailsManagementBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        backgroundColor: themeConfig.colors.background,
        body: BlocBuilder<ClientDetailsManagementBloc, ClientDetailsManagementState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) => ConditionalSwitch.single(
              context: context,
              valueBuilder: (_) => state.type,
              caseBuilders: {
                ClientDetailsManagementStateType.loading: (_) =>
                    Center(child: CircularProgressIndicator()),
                ClientDetailsManagementStateType.initial: (_) => _buildPageContent(locale, bloc),
                ClientDetailsManagementStateType.clientUpdated: (_) =>
                    _buildPageContent(locale, bloc),
              },
              fallbackBuilder: (_) => SizedBox.shrink()),
        ));
  }

  Widget _buildPageContent(LocaleBundle locale, ClientDetailsManagementBloc bloc) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userName(bloc.state.customerResponse.fullName),
        _avatar(),
        SizedBox(
          height: 15.0,
        ),
        companyInfoTile(locale.relationshipStatus,
            describeEnum(bloc.state.customerResponse.relationshipStatus)),
        //todo change to active
        bloc.state.customerResponse.relationshipStatus == RelationshipStatus.ACTIVE
            ? _spotsList(bloc.state.customerResponse.companyCustomerSpotMemberships, locale, bloc)
            : _userBlocked(locale, bloc),
      ],
    ));
  }

  Center _userBlocked(LocaleBundle locale, ClientDetailsManagementBloc bloc) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 35.0,
          ),
          Text(
            locale.thisUserIsBlocked,
            style: themeConfig.textStyles.primaryTitle,
          ),
          SizedBox(
            height: 15.0,
          ),
          _blockUserButton(
              locale.unblockUser,
              () => {bloc.add(BlockUser(bloc.state.customerResponse.customerId, unblock))},
              themeConfig.textStyles.active),
        ],
      ),
    );
  }

  Padding _userName(String userName) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        userName,
        style: themeConfig.textStyles.primaryTitle,
      ),
    );
  }

  Padding _avatar() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Center(
        child: Container(
          child: Icon(
            Icons.person,
            size: 70.0,
          ),
          width: 115.0,
          height: 115.0,
          decoration: new BoxDecoration(
            color: themeConfig.colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _spotsList(List<CompanyCustomerSpotMembershipResponse> spots, LocaleBundle locale,
      ClientDetailsManagementBloc bloc) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 8.0),
            child: Text(
              locale.spotsMemberships,
              style: themeConfig.textStyles.secondaryTitle,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: spots.length,
                      itemBuilder: (context, index) {
                        return SpotTile(spots[index], locale, bloc);
                      }),
                ],
              ),
            ),
          ),
          _blockUserButton(
              locale.blockUser,
              () => {bloc.add(BlockUser(bloc.state.customerResponse.customerId, block))},
              themeConfig.textStyles.blocked),
        ],
      ),
    );
  }

  Padding companyInfoTile(String leading, String trailing) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 15.0, left: 25.0, right: 25.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leading,
                style: themeConfig.textStyles.managementListTile,
              ),
              Text(
                trailing,
                style: themeConfig.textStyles.filledTextField,
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: themeConfig.colors.white, style: BorderStyle.solid))),
      ),
    );
  }

  Widget _blockUserButton(String text, Function onTap, TextStyle textStyle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: FlatButton(
          onPressed: onTap,
          child: Container(
            height: 30.0,
            width: 120.0,
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            decoration: BoxDecoration(
                color: themeConfig.colors.white,
                boxShadow: [
                  dhShadow(),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Center(
              child: Text(text, style: textStyle),
            ),
          ),
        ),
      ),
    );
  }
}

class SpotTile extends DhTile {
  final CompanyCustomerSpotMembershipResponse spot;
  final LocaleBundle locale;
  final ClientDetailsManagementBloc bloc;
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  SpotTile(this.spot, this.locale, this.bloc);

  @override
  onTap(BuildContext context) {
    return () {};
  }

  @override
  Widget get photo => IconInCircle(themeConfig: themeConfig, icon: Icons.store);

  @override
  bool get selected => false;

  @override
  String get subtitle1 => describeEnum(spot.membershipStatus);

  @override
  String get subtitle2 => null;

  @override
  String get title => spot.spotName;

  @override
  Widget get trailing {
    final List<PopupItem> popupOptions = [];
    if (spot.membershipStatus == MembershipStatus.BLOCKED ||
        spot.membershipStatus == MembershipStatus.PENDING) {
      popupOptions.add(PopupItem(locale.acceptUserOnSpot, () {
        bloc.add(ToggleSpotMembershipStatus(true, spot.spotUid));
      }));
    }
    if (spot.membershipStatus == MembershipStatus.ACTIVE ||
        spot.membershipStatus == MembershipStatus.PENDING) {
      popupOptions.add(PopupItem(locale.blockUserOnSpot, () {
        bloc.add(ToggleSpotMembershipStatus(false, spot.spotUid));
      }));
    }
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: themeConfig.colors.black,
        size: 30.0,
      ),
      onSelected: (value) => print(value),
      itemBuilder: (BuildContext context) {
        return popupOptions.map((PopupItem choice) {
          return PopupMenuItem<String>(
            value: choice.value,
            child: Text(
              choice.value,
              style: themeConfig.textStyles.popupMenu,
            ),
          );
        }).toList();
      },
    );
  }
}

class PopupItem {
  final String value;
  final Function onTap;
  PopupItem(this.value, this.onTap);
}
