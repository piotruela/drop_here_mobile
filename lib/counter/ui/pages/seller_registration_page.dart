import 'package:bloc/src/bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/counter/bloc/registration_bloc.dart';
import 'package:drop_here_mobile/counter/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_text_button.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class SellerRegistrationPage extends BlocWidget<RegistrationBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();


  @override
  RegistrationBloc bloc() => RegistrationBloc();

  @override
  Widget build(BuildContext context, RegistrationBloc bloc, _) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:
        Form(
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
              DhTextFormField(labelText: localeBundle.email, onChanged: (val) => bloc.add(MailChanged(mail: val))),
              DhTextFormField(labelText: localeBundle.password,
                  onChanged: (val) => bloc.add(PasswordChanged(password: val))),
              DhTextFormField(labelText: localeBundle.repeatPassword,
                  onChanged: (val) => bloc.add(PasswordRepeatChanged(passwordRepeat: val)),
                  validator: (value) => value.isEmpty ?
                  localeBundle.repeatPassword + " is required"
                  : bloc.state.password != value
                  ? localeBundle.repeatPassword + " is not the same"
                  : null),
              DhButton(onPressed: () => bloc.add(RegistrationFormSubmitted(isValid: key.currentState.validate(), accountType: AccountType.COMPANY)), text: localeBundle.signUp, backgroundColor:
              themeConfig.colors.primary1),
            ],
          ),
        )
      ),
    );
  }
}