import 'package:drop_here_mobile/accounts/model/profile.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseProfilePage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>(); //TODO: Fetch profiles
  final List<Profile> profiles = [
    Profile.withName(firstName: "Jan", lastName: "Kowalski", profileType: ProfileType.MAIN),
    Profile.withName(firstName: "Adam", lastName: "Kowalski"),
    Profile.withName(firstName: "Jakub", lastName: "Kowalski"),
    Profile.withName(firstName: "Piotr", lastName: "Kowalski"),
    Profile.withName(firstName: "Jan", lastName: "Kowalski"),
    Profile.withName(firstName: "Adam", lastName: "Kowalski"),
    Profile.withName(firstName: "Jakub", lastName: "Kowalski"),
    Profile.withName(firstName: "Piotr", lastName: "Kowalski"),
    Profile.withName(firstName: "Jan", lastName: "Kowalski"),
    Profile.withName(firstName: "Adam", lastName: "Kowalski"),
    Profile.withName(firstName: "Jakub", lastName: "Kowalski"),
    Profile.withName(firstName: "Piotr", lastName: "Kowalski")
  ];

  ChooseProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeConfig.colors.background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text("Choose your profile", style: themeConfig.textStyles.primaryTitle),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: profiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.4),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: ProfileTile(
                      isAdmin: profiles.elementAt(index).profileType == ProfileType.MAIN,
                      profile: profiles.elementAt(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class ProfileTile extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final bool isAdmin;
  final Profile profile;

  ProfileTile({this.isAdmin = false, @required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 100,
      child: GestureDetector(
        onTap: () => {}, //TODO: Get to loginToProfilePage
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
