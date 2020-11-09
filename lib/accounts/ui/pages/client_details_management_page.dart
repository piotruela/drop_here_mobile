import 'package:drop_here_mobile/accounts/bloc/client_details_management_bloc/client_details_management_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_products_to_route.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';

class ClientDetailsManagementPage extends BlocWidget<ClientDetailsManagementBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final CompanyCustomerResponse customer;

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
                ClientDetailsManagementStateType.initial: (_) => _buildPageContent(locale),
              },
              fallbackBuilder: (_) => SizedBox.shrink()),
        ));
  }

  Widget _buildPageContent(LocaleBundle locale) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userName(),
        _avatar(),
        SizedBox(
          height: 15.0,
        ),
        companyInfoTile(locale.relationshipStatus, describeEnum(customer.relationshipStatus)),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 8.0),
          child: Text(
            locale.spotsMemberships,
            style: themeConfig.textStyles.secondaryTitle,
          ),
        ),
        _spotsList(),
      ],
    ));
  }

  Padding _userName() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        customer.fullName,
        style: themeConfig.textStyles.primaryTitle,
      ),
    );
  }

  Padding _avatar() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Center(
        child: Container(
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

  Expanded _spotsList() {
    return Expanded(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            SpotTile(customer.companyCustomerSpotMemberships.first),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: customer.companyCustomerSpotMemberships.length,
                itemBuilder: (context, index) {
                  return SpotTile(customer.companyCustomerSpotMemberships[index]);
                })
          ],
        ),
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
}

class SpotTile extends DhTile {
  final CompanyCustomerSpotMembershipResponse spot;
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  SpotTile(this.spot);

  @override
  onTap(BuildContext context) {
    print('a');
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
  Widget get trailing => Icon(Icons.more_vert);
}
