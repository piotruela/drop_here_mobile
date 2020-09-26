import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/accounts/services/registration_service.dart';
import 'package:drop_here_mobile/accounts/ui/pages/registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/seller_details_registration_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/accounts/bloc/registration_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


class SellerRegistrationPage extends RegistrationPage {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget registrationForm(RegistrationBloc bloc, BuildContext context, LocaleBundle localeBundle) {
    return Form(
      key: key,
      child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top:100.0, bottom: 10.0),
              child: Text(Localization.of(context).bundle.createASellerAccountHeader,
                  style: themeConfig.textStyles.secondaryTitle),
            ),
          ),
          mailField(bloc, localeBundle),
          passwordField(bloc, localeBundle),
          repeatPasswordField(bloc, localeBundle),
          DhButton(onPressed: () => bloc
              .add(RegistrationFormSubmitted(isValid: key.currentState.validate(),
              accountType: AccountType.COMPANY)), text: localeBundle.signUp, backgroundColor:
          themeConfig.colors.primary1),
        ],
      ),
    );
  }

  @override
  bool get validation => key.currentState.validate();

  @override
  AccountType get accountType => AccountType.COMPANY;
}