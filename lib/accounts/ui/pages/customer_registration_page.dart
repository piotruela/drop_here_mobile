import 'package:drop_here_mobile/accounts/bloc/registration_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/pages/registration_page.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class CustomerRegistrationPage extends RegistrationPage {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  AccountType get accountType => AccountType.CUSTOMER;

  @override
  List<Widget> formElements(RegistrationBloc bloc, BuildContext context) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return [
      titleText(localeBundle.createABuyerAccount),
      mailField(bloc, localeBundle),
      passwordField(bloc, localeBundle),
      repeatPasswordField(bloc, localeBundle),
      signUpButton(bloc, localeBundle),
      orText(localeBundle),
      signUpWithFBButton(bloc,localeBundle)
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
