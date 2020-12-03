import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_circled_info.dart';
import 'package:drop_here_mobile/common/ui/widgets/snackbar.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/management/bloc/customer_details_bloc/customer_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomerDetailsPage extends BlocWidget<CustomerDetailsBloc> {
  final ThemeConfig _themeConfig = Get.find<ThemeConfig>();

  @override
  CustomerDetailsBloc bloc() => CustomerDetailsBloc()..add(FetchCustomerDetails());
  @override
  Widget build(BuildContext context, CustomerDetailsBloc bloc, _) {
    LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: dhSnackBar(locale.tapBackButtonAgainHint),
        child: BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
          buildWhen: (previous, current) => previous.type != current.type,
          builder: (context, state) => Conditional.single(
              context: context,
              conditionBuilder: (_) => state.type == CustomerDetailsStateType.fetched,
              widgetBuilder: (_) => _buildContent(context, bloc),
              fallbackBuilder: (_) => Center(child: CircularProgressIndicator())),
        ),
      ),
      bottomNavigationBar: CustomerBottomBar(sectionIndex: 2),
    );
  }

  Widget _buildContent(BuildContext context, CustomerDetailsBloc bloc) {
    final AccountInfoResponse accountInfo = bloc.state.accountInfo;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My account details",
            style: _themeConfig.textStyles.primaryTitle,
          ),
          _avatar(bloc),
          Align(
            child: Text(
              bloc.state.customerInfo.customerFullName,
              style: _themeConfig.textStyles.primaryTitle,
            ),
          ),
          SizedBox(height: 20.0),
          LabeledCircledInfoWithDivider(label: "Mail", text: accountInfo.mail),
          LabeledCircledInfoWithDivider(label: "Customer since", text: accountInfo.createdAt.toStringWithoutTime()),
          LabeledCircledInfo(label: "Mail status", text: describeEnum(accountInfo.accountMailStatus)),
          Align(child: ChoosableButton(text: "Log out", isChosen: false, chooseAction: () => bloc.add(LogOut()))),
        ],
      ),
    );
  }

  Widget _avatar(CustomerDetailsBloc bloc) {
    final AssetsConfig assetsConfig = Get.find<AssetsConfig>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Center(
        child: Container(
          width: 115.0,
          height: 115.0,
          child: Stack(children: [
            Center(
              child: Icon(
                Icons.person,
                size: 70.0,
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  width: 115,
                  height: 115,
                  fadeInDuration: Duration(milliseconds: 100),
                  placeholder: kTransparentImage,
                  image: bloc.state.photo,
                ),
              ),
            ),
          ]),
          decoration: new BoxDecoration(
            color: _themeConfig.colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
