import 'package:drop_here_mobile/accounts/bloc/registration_bloc/registration_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/client_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/thresholds.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

abstract class RegistrationPage extends BlocWidget<RegistrationBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  RegistrationBloc bloc() => RegistrationBloc(accountType: accountType);

  @override
  Widget build(BuildContext context, RegistrationBloc bloc, _) {
    return MainLayout(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<RegistrationBloc, RegisterState>(
        listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        listener: (context, state) {
          if (state is SuccessState) {
            Widget page;
            if (state.accountType == AccountType.CUSTOMER) {
              page = state.registrationType == RegistrationType.FORM
                  ? ClientDetailsRegistrationPage()
                  : CustomerMapPage();
            } else {
              page = CreateAdminProfilePage();
            }
            Get.to(page);
          }
          if (state is ErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Register error")));
          }
        },
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is RegisterLoadingState || state is SuccessState) {
            return Center(child: CircularProgressIndicator());
          } else {
            return registrationForm(bloc, context);
          }
        },
      ),
    ));
  }

  Widget registrationForm(RegistrationBloc bloc, BuildContext context);

  AccountType get accountType;

  String formTitle(BuildContext context);

  List<Widget> formElements(RegistrationBloc bloc, BuildContext context);

  bool get validate;

  Widget titleText(String text, BuildContext context) {
    return Center(
      child: Padding(
        padding: MediaQuery.of(context).size.width > Thresholds.width
            ? const EdgeInsets.only(top: 70.0, bottom: 10.0)
            : const EdgeInsets.only(top: 0.0, bottom: 6.0),
        child: Text(text, style: themeConfig.textStyles.secondaryTitle),
      ),
    );
  }

  Widget mailField(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhTextFormField(
        labelText: localeBundle.email,
        initialValue: bloc.state.form.mail,
        onChanged: (val) => bloc.add(FormChanged(form: bloc.state.form.copyWith(mail: val))),
        validator: (mail) => mailValidator(mail, localeBundle));
  }

  Widget passwordField(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhTextFormField(
        obscureText: true,
        labelText: localeBundle.password,
        initialValue: bloc.state.form.password,
        onChanged: (val) => bloc.add(FormChanged(form: bloc.state.form.copyWith(password: val))),
        validator: (password) => passwordValidator(password, localeBundle));
  }

  Widget repeatPasswordField(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhTextFormField(
        obscureText: true,
        labelText: localeBundle.repeatPassword,
        initialValue: bloc.state.form.password,
        validator: (repeatedPassword) =>
            repeatPasswordValidator(bloc.state.form.password, repeatedPassword, localeBundle));
  }

  Widget signUpButton(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhButton(
        onPressed: () => bloc.add(FormSubmitted(isValid: validate, form: bloc.state.form)),
        text: localeBundle.signUp,
        backgroundColor: themeConfig.colors.primary1);
  }

  Widget orText(LocaleBundle localeBundle) =>
      Text(localeBundle.or, style: themeConfig.textStyles.secondaryTitle);

  Widget signUpWithFBButton(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhButton(
        onPressed: () => bloc.add(FacebookSigningSubmitted()),
        text: localeBundle.signUpWithFacebook,
        backgroundColor: themeConfig.colors.facebookColor);
  }

  String mailValidator(String mail, LocaleBundle localeBundle) {
    if (mail.isEmpty) return localeBundle.email + localeBundle.isRequired;
    if (!EmailValidator.validate(mail)) return localeBundle.email + localeBundle.invalidMail;
    return null;
  }

  String passwordValidator(String password, LocaleBundle localeBundle) {
    if (password.isEmpty) return localeBundle.password + localeBundle.isRequired;
    if (password.length < 8) return localeBundle.password + localeBundle.toShort;
    return null;
  }

  String repeatPasswordValidator(
      String password, String repeatedPassword, LocaleBundle localeBundle) {
    if (password != repeatedPassword)
      return localeBundle.repeatPassword + localeBundle.isNotTheSame;
    return null;
  }
}
