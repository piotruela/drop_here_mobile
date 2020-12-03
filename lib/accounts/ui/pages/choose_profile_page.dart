import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:drop_here_mobile/accounts/bloc/choose_profile_bloc/choose_profile_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/pages/log_on_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/login_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/snackbar.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChooseProfilePage extends BlocWidget<ChooseProfileBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  ChooseProfilePage();

  @override
  ChooseProfileBloc bloc() => ChooseProfileBloc()..add(FetchProfiles());

  @override
  Widget build(BuildContext context, ChooseProfileBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        backgroundColor: themeConfig.colors.background,
        body: DoubleBackToCloseApp(
            snackBar: dhSnackBar(locale.tapBackButtonAgainHint),
            child: BlocBuilder<ChooseProfileBloc, ChooseProfileState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state is LoadingState || state is ChooseProfileInitial) {
                    return CircularProgressIndicator();
                  } else if (state is ProfilesFetched) {
                    return _profilesList(state.profiles);
                  } else
                    return SizedBox.shrink();
                })));
  }
}

Widget _profilesList(List<ProfileInfoResponse> profiles) {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: Text("Choose your profile", style: themeConfig.textStyles.primaryTitle),
      ),
      RaisedButton(
          color: themeConfig.colors.primary1,
          child: Text("LOGOUT"),
          onPressed: () => Get.to(LoginPage())),
      Expanded(
        child: GridView.builder(
          itemCount: profiles.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.4),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: ProfileTile(
                isAdmin: profiles?.elementAt(index)?.profileType == ProfileType.MAIN,
                profile: profiles?.elementAt(index),
              ),
            );
          },
        ),
      ),
    ],
  );
}

class ProfileTile extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final bool isAdmin;
  final ProfileInfoResponse profile;

  ProfileTile({this.isAdmin = false, @required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 100,
      child: GestureDetector(
        onTap: () => Get.to(LogOnProfilePage(profile: profile)),
        child: Container(
            decoration: BoxDecoration(
              border: isAdmin ? Border.all(color: themeConfig.colors.primary1, width: 3) : null,
              color: themeConfig.colors.white,
              boxShadow: [
                BoxShadow(
                    color: themeConfig.colors.black.withOpacity(0.25),
                    blurRadius: 15.0,
                    offset: Offset(0.0, 4.0))
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                isAdmin ? Icon(Icons.star, color: themeConfig.colors.primary1) : SizedBox.shrink(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        profile.firstName,
                        style: themeConfig.textStyles.primaryTitle.copyWith(fontSize: 18.0),
                      ),
                      Text(
                        profile.lastName,
                        style: themeConfig.textStyles.primaryTitle.copyWith(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
