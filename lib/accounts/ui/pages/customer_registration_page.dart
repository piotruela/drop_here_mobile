import 'package:drop_here_mobile/accounts/bloc/registration_bloc.dart';
import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/accounts/ui/pages/registration_page.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class CustomerRegistrationPage extends RegistrationPage {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  AccountType get accountType => AccountType.CUSTOMER;

  @override
  List<Widget> formElements(RegistrationBloc bloc, LocaleBundle localeBundle) => [
        titleText(localeBundle.createABuyerAccount),
        mailField(bloc, localeBundle),
        passwordField(bloc, localeBundle),
        repeatPasswordField(bloc, localeBundle),
        signUpButton(bloc, localeBundle),
        orText(localeBundle),
        signUpWithFBButton(localeBundle)
      ];

  @override
  String formTitle(BuildContext context) =>
      Localization.of(context).bundle.createASellerAccountHeader;

  @override
  Widget registrationForm(RegistrationBloc bloc, BuildContext context, LocaleBundle localeBundle) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Column(
            children: formElements(bloc, localeBundle),
          ),
        ],
      ),
    );
  }

  @override
  bool get validate => formKey.currentState.validate();
}
