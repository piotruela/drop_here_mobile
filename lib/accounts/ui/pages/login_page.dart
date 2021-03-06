import 'package:drop_here_mobile/accounts/bloc/login_bloc/login_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/thresholds.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/snackbar.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginPage extends BlocWidget<LoginBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();
  final VoidCallback backAction;

  LoginPage({this.backAction});

  @override
  LoginBloc bloc() => LoginBloc();

  @override
  Widget build(BuildContext context, LoginBloc bloc, BlocWidgetState<LoginBloc> widgetState) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    return MainLayout(
      child: WillPopScope(
        onWillPop: () async {
          backAction ?? Get.back();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocListener<LoginBloc, LoginFormState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state is SuccessState) {
                if (state.accountType == AccountType.COMPANY) {
                  Get.offAll(ChooseProfilePage());
                } else {
                  Get.offAll(CustomerMapPage());
                }
              }
              if (state is ErrorState) {
                Scaffold.of(context).showSnackBar(dhSnackBar("Login error"));
              }
            },
            child: BlocBuilder<LoginBloc, LoginFormState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state is LoginLoadingState || state is SuccessState) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return _pageBody(context, bloc, key);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageBody(BuildContext context, LoginBloc bloc, GlobalKey<FormState> key) {
    return Center(
      child: ListView(
        children: [
          Form(
            key: key,
            child: Column(
              children: [
                DhBackButton(
                  padding: EdgeInsets.zero,
                  backAction: backAction,
                ),
                Padding(
                  padding: MediaQuery.of(context).size.width > Thresholds.width
                      ? const EdgeInsets.only(top: 70.0, bottom: 10.0)
                      : const EdgeInsets.only(top: 0.0, bottom: 6.0),
                  child: Text(Localization.of(context).bundle.loginPageHeader,
                      style: themeConfig.textStyles.secondaryTitle),
                ),
                DhTextFormField(
                  labelText: Localization.of(context).bundle.email,
                  initialValue: bloc.state?.form?.mail ?? '',
                  onChanged: (value) =>
                      bloc.add(FormChanged(form: bloc.state.form.copyWith(mail: value))),
                ),
                DhTextFormField(
                    obscureText: true,
                    labelText: Localization.of(context).bundle.password,
                    initialValue: bloc.state?.form?.password ?? '',
                    onChanged: (value) =>
                        bloc.add(FormChanged(form: bloc.state.form.copyWith(password: value)))),
                DhButton(
                  onPressed: () => bloc.add(
                      FormSubmitted(isValid: key.currentState.validate(), form: bloc.state.form)),
                  text: Localization.of(context).bundle.logIn,
                  backgroundColor: themeConfig.colors.primary1,
                ),
                Text(Localization.of(context).bundle.or,
                    style: themeConfig.textStyles.secondaryTitle),
                DhButton(
                  onPressed: () => bloc.add(FacebookSigningSubmitted()),
                  text: Localization.of(context).bundle.logInWithFacebook,
                  backgroundColor: themeConfig.colors.facebookColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
