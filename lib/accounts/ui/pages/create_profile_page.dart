import 'package:drop_here_mobile/accounts/bloc/create_profile_bloc/create_profile_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/thresholds.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/management/ui/pages/management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

abstract class CreateProfilePage extends BlocWidget<CreateProfileBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  CreateProfileBloc bloc() => CreateProfileBloc();

  @override
  Widget build(BuildContext context, CreateProfileBloc bloc, _) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return MainLayout(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocConsumer<CreateProfileBloc, CreateProfileState>(
              listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
              listener: (context, state) {
                if (state is SuccessState) {
                  Get.offAll(getNextPage());
                } else if (state is ErrorState) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(localeBundle.registrationError + localeBundle.fillAllData)));
                }
              },
              buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
              builder: (context, state) {
                if (state is LoadingState || state is SuccessState) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return _pageBody(context, bloc);
                }
              },
            )));
  }

  Widget _pageBody(BuildContext context, CreateProfileBloc bloc) {
    final double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: ListView(
        children: [
          DhBackButton(),
          Column(
            children: [
              Padding(
                padding: width > Thresholds.width
                    ? const EdgeInsets.only(top: 144.0, bottom: 22.0)
                    : const EdgeInsets.only(top: 40.0, bottom: 22.0),
                child: Text(getTitleText(context), style: themeConfig.textStyles.secondaryTitle),
              ),
              DhTextFormField(
                  onChanged: (value) =>
                      bloc.add(FormChanged(form: bloc.state.form.copyWith(firstName: value))),
                  labelText: Localization.of(context).bundle.firstName,
                  padding: EdgeInsets.only(left: 40, right: 40.0)),
              DhTextFormField(
                  onChanged: (value) =>
                      bloc.add(FormChanged(form: bloc.state.form.copyWith(lastName: value))),
                  labelText: Localization.of(context).bundle.lastName,
                  padding: EdgeInsets.only(left: 40, right: 40.0)),
              DhTextFormField(
                  obscureText: true,
                  onChanged: (value) =>
                      bloc.add(FormChanged(form: bloc.state.form.copyWith(password: value))),
                  labelText: Localization.of(context).bundle.password,
                  padding: EdgeInsets.only(left: 40, right: 40.0, bottom: 20.0)),
              DhButton(
                onPressed: () =>
                    bloc.add(FormSubmitted(form: bloc.state.form, profileRole: profileRole)),
                text: "Create",
                backgroundColor: themeConfig.colors.primary1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getTitleText(BuildContext context);

  Widget getNextPage();

  ProfileRole get profileRole;
}

class CreateAdminProfilePage extends CreateProfilePage {
  @override
  String getTitleText(BuildContext context) => Localization.of(context).bundle.createAdminProfile;

  @override
  Widget getNextPage() => CompanyDetailsRegistrationPage();

  @override
  ProfileRole get profileRole => ProfileRole.ADMIN;
}

class CreateRegularProfilePage extends CreateProfilePage {
  @override
  String getTitleText(BuildContext context) => Localization.of(context).bundle.createProfile;

  @override
  Widget getNextPage() => ManagementPage();

  @override
  ProfileRole get profileRole => ProfileRole.BASIC;
}
