import 'package:drop_here_mobile/accounts/bloc/registration_bloc.dart';
import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/accounts/services/registration_service.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/buyer_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_admin_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
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
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return MainLayout(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<RegistrationBloc, RegistrationFormState>(
              bloc: bloc,
              listenWhen: (previous, current) => previous.result != current.result,
              listener: (context, state) {
                if (state.result == RegistrationResult.account_created) {
                  Widget page = bloc.state.accountType == AccountType.CUSTOMER
                      ? BuyerDetailsRegistrationPage()
                      : CreateAdminProfilePage();
                  Get.to(page);
                } else if (state.result == RegistrationResult.account_exists ||
                    state.result == RegistrationResult.bad_credentials) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: themeConfig.colors.primary1,
                      content: Text(localeBundle.registrationError +
                          (state.result == RegistrationResult.account_exists
                              ? localeBundle.accountAlreadyExists
                              : localeBundle.badCredentials))));
                } else if (state.result == RegistrationResult.error) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content:
                          Text(localeBundle.registrationError + localeBundle.unexpectedError)));
                }
              },
              child: registrationForm(bloc, context, localeBundle),
            )));
  }

  Widget registrationForm(RegistrationBloc bloc, BuildContext context, LocaleBundle localeBundle);

  AccountType get accountType;

  String formTitle(BuildContext context);

  List<Widget> formElements(RegistrationBloc bloc, LocaleBundle localeBundle);

  bool get validate;

  Widget titleText(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, bottom: 10.0),
        child: Text(text, style: themeConfig.textStyles.secondaryTitle),
      ),
    );
  }

  Widget mailField(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhTextFormField(
        labelText: localeBundle.email,
        onChanged: (val) => bloc.add(MailChanged(mail: val)),
        validator: (mail) => mailValidator(mail, localeBundle));
  }

  Widget passwordField(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhTextFormField(
        labelText: localeBundle.password,
        onChanged: (val) => bloc.add(PasswordChanged(password: val)),
        validator: (password) => passwordValidator(password, localeBundle));
  }

  Widget repeatPasswordField(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhTextFormField(
        labelText: localeBundle.repeatPassword,
        onChanged: (val) => bloc.add(PasswordRepeatChanged(passwordRepeat: val)),
        validator: (repeatedPassword) =>
            repeatPasswordValidator(bloc.state.password, repeatedPassword, localeBundle));
  }

  Widget signUpButton(RegistrationBloc bloc, LocaleBundle localeBundle) {
    return DhButton(
        onPressed: () =>
            bloc.add(RegistrationFormSubmitted(isValid: validate, accountType: accountType)),
        text: localeBundle.signUp,
        backgroundColor: themeConfig.colors.primary1);
  }

  Widget orText(LocaleBundle localeBundle) =>
      Text(localeBundle.or, style: themeConfig.textStyles.secondaryTitle);

  Widget signUpWithFBButton(LocaleBundle localeBundle) => DhButton(
      onPressed: () {},
      text: localeBundle.signUpWithFacebook,
      backgroundColor: themeConfig.colors.facebookColor);

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
