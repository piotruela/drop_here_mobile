import 'package:drop_here_mobile/accounts/bloc/registration_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/pages/registration_page.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class CompanyRegistrationPage extends RegistrationPage {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  AccountType get accountType => AccountType.COMPANY;

  @override
  List<Widget> formElements(RegistrationBloc bloc, BuildContext context) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return [
      titleText(localeBundle.createASellerAccountHeader),
      mailField(bloc, localeBundle),
      passwordField(bloc, localeBundle),
      repeatPasswordField(bloc, localeBundle),
      signUpButton(bloc, localeBundle),
    ];
  }

  @override
  String formTitle(BuildContext context) =>
      Localization.of(context).bundle.createASellerAccountHeader;

  @override
  Widget registrationForm(RegistrationBloc bloc, BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Column(
            children: formElements(bloc, context),
          ),
        ],
      ),
    );
  }

  @override
  bool get validate => formKey.currentState.validate();
}
