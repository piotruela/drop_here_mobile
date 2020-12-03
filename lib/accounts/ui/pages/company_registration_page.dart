import 'package:drop_here_mobile/accounts/bloc/registration_bloc/registration_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/pages/registration_page.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
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
      DhBackButton(
        padding: EdgeInsets.zero,
      ),
      titleText("Create company account", context),
      mailField(bloc, localeBundle),
      passwordField(bloc, localeBundle),
      repeatPasswordField(bloc, localeBundle),
      signUpButton(bloc, localeBundle),
    ];
  }

  @override
  String formTitle(BuildContext context) => "Create company account";

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
