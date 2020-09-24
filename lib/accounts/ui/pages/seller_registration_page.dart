import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/accounts/services/registration_service.dart';
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


class SellerRegistrationPage extends BlocWidget<RegistrationBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();


  @override
  RegistrationBloc bloc() => RegistrationBloc(accountType: AccountType.COMPANY);

  @override
  Widget build(BuildContext context, RegistrationBloc bloc, _) {
    return MainLayout(
    child: Scaffold(
    backgroundColor: Colors.transparent,
        body:BlocConsumer<RegistrationBloc, RegistrationFormState>(
            bloc: bloc,
            listenWhen: (previous, current) => previous.result != current.result,
            listener: (context, state) {
              if(state.result == RegistrationResult.account_created){
                Get.to(SellerDetailsRegistrationPage());
              } else if( state.result == RegistrationResult.account_exists || state.result == RegistrationResult.bad_credentials) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.result == RegistrationResult.account_exists ? "Account already exists" : "Bad credentials")));
              }
            },
            buildWhen: (previous, current) => previous.result != current.result,
            builder: (context, state) {
              if(state.result == RegistrationResult.in_progress){
                return Center(child: CircularProgressIndicator());
              }
              else{
                return _registrationForm(bloc, context);
              }
            }
    )));

  }

  Widget _registrationForm(RegistrationBloc bloc, BuildContext context){
    LocaleBundle localeBundle = Localization.of(context).bundle;
    final GlobalKey<FormState> key = GlobalKey<FormState>();
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
          DhTextFormField(labelText: localeBundle.email, onChanged: (val) => bloc.add(MailChanged(mail: val)),
              /*validator: (mail) => mailValidator(mail, localeBundle)*/),
          DhTextFormField(labelText: localeBundle.password,
              onChanged: (val) => bloc.add(PasswordChanged(password: val)),
              /*validator: (password) => passwordValidator(password, localeBundle)*/),
          DhTextFormField(labelText: localeBundle.repeatPassword,
              onChanged: (val) => bloc.add(PasswordRepeatChanged(passwordRepeat: val)),
              /*validator: (repeatedPassword) =>
                  repeatPasswordValidator(bloc.state.password, repeatedPassword, localeBundle)*/),
          DhButton(onPressed: () => bloc
              .add(RegistrationFormSubmitted(isValid: key.currentState.validate(),
              accountType: AccountType.COMPANY)), text: localeBundle.signUp, backgroundColor:
          themeConfig.colors.primary1),
        ],
      ),
    );
  }

  String mailValidator(String mail, LocaleBundle localeBundle){
    if(mail.isEmpty) return localeBundle.email + " is required";
    if(!EmailValidator.validate(mail)) return localeBundle.email + " is not valid mail";
    return null;
}

  String passwordValidator(String password, LocaleBundle localeBundle){
    if(password.isEmpty) return localeBundle.password + " is required";
    if(password.length<8) return localeBundle.password + " is to short";
    return null;
  }
  String repeatPasswordValidator(String password,String repeatedPassword, LocaleBundle localeBundle){
    if(password != repeatedPassword) return localeBundle.password + " is not the same";
    return null;
  }



}