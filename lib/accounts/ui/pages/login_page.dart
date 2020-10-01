import 'package:drop_here_mobile/accounts/bloc/login_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/sandbox_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginPage extends BlocWidget<LoginBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();

  @override
  LoginBloc bloc() => LoginBloc();

  @override
  Widget build(BuildContext context, LoginBloc bloc, BlocWidgetState<LoginBloc> widgetState) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<LoginBloc, LoginFormState>(
          bloc: bloc,
          listenWhen: (previous, current) => previous != current && current is SuccessState,
          listener: (context, state) {
            if (state is SuccessState) {
              Get.to(ChooseProfilePage());
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Login error")));
            }
          },
          child: Center(
            child: ListView(
              children: [
                Form(
                  key: key,
                  child: BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0, bottom: 10),
                          child: Text(Localization.of(context).bundle.loginPageHeader,
                              style: themeConfig.textStyles.secondaryTitle),
                        ),
                        DhTextFormField(
                          labelText: Localization.of(context).bundle.email,
                          onChanged: (value) =>
                              bloc.add(FormChanged(form: bloc.state.form.copyWith(mail: value))),
                        ),
                        DhTextFormField(
                            labelText: Localization.of(context).bundle.password,
                            onChanged: (value) => bloc
                                .add(FormChanged(form: bloc.state.form.copyWith(password: value)))),
                        DhTextButton(
                            text: Localization.of(context).bundle.forgotPasswordQuestion,
                            onTap: () => Get.to(SandboxPage())),
                        DhButton(
                          onPressed: () => bloc.add(FormSubmitted(
                              isValid: key.currentState.validate(), form: bloc.state.form)),
                          text: Localization.of(context).bundle.logIn,
                          backgroundColor: themeConfig.colors.primary1,
                        ),
                        Text(Localization.of(context).bundle.or,
                            style: themeConfig.textStyles.secondaryTitle),
                        DhButton(
                          onPressed: () {},
                          text: Localization.of(context).bundle.logInWithFacebook,
                          backgroundColor: themeConfig.colors.facebookColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          backgroundColor: themeConfig.colors.primary1,
          child: Container(
            child: Icon(
              Icons.add,
              size: 40.0,
            ),
          ),
          elevation: 4.0,
        ),
      ),
    );
  }
}
