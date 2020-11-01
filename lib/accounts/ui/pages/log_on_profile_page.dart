import 'dart:io';

import 'package:drop_here_mobile/accounts/bloc/login_profile_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/ui/pages/spots_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LogOnProfilePage extends BlocWidget<LoginProfileBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  final picker = ImagePicker();
  final ProfileInfoResponse profile;

  LogOnProfilePage({this.profile});

  @override
  bloc() => LoginProfileBloc(profileUid: profile.profileUid);

  @override
  Widget build(BuildContext context, LoginProfileBloc bloc, _) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: themeConfig.colors.background,
        body: BlocConsumer<LoginProfileBloc, LoginProfileState>(
            listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
            listener: (context, state) {
              if (state is LoginSucceeded) {
                Get.offAll(CompanyMapPage());
              }
              if (state is LoginFailure) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Login error")));
              }
            },
            buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
            builder: (context, state) {
              if (state is LoginLoadingState || state is LoginSucceeded) {
                return Center(child: CircularProgressIndicator());
              } else
                return _profileLoginForm(context, bloc, key);
            }));
  }

  Widget _profileLoginForm(BuildContext context, LoginProfileBloc bloc, GlobalKey<FormState> key) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return Form(
      key: key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text(
                  profile.isAdmin()
                      ? localeBundle.loginToAdminProfile
                      : localeBundle.loginToYourProfile,
                  style: themeConfig.textStyles.primaryTitle),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 68.0, bottom: 20.0),
              child: Text("${profile.firstName} ${profile.lastName}",
                  overflow: TextOverflow.clip, style: themeConfig.textStyles.primaryTitle),
            ),
            DhTextFormField(
                initialValue: bloc.state.form.password,
                labelText: Localization.of(context).bundle.password,
                onChanged: (value) =>
                    bloc.add(FormChanged(form: bloc.state.form.copyWith(password: value)))),
            DhButton(
              onPressed: () => bloc
                  .add(FormSubmitted(isValid: key.currentState.validate(), form: bloc.state.form)),
              text: Localization.of(context).bundle.logIn,
              backgroundColor: themeConfig.colors.primary1,
            ),
          ],
        ),
      ),
    );
  }

  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    return File(pickedFile.path);
  }
}
