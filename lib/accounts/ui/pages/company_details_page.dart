import 'dart:io';

import 'package:drop_here_mobile/accounts/bloc/company_management_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/pages/edit_company_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/login_page.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompanyDetailsPage extends BlocWidget<CompanyManagementBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  @override
  CompanyManagementBloc bloc() => CompanyManagementBloc()..add(FetchCompanyDetails());

  @override
  Widget build(BuildContext context, CompanyManagementBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 54.0),
              child: BlocBuilder<CompanyManagementBloc, CompanyManagementState>(
                buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                builder: (context, state) {
                  if (state is CompanyDetailsFetchingInProgress) {
                    return CircularProgressIndicator();
                  }
                  if (state is CompanyDetailsFetched) {
                    return SizedBox(width: 150, height: 150, child: ClipOval(child: state.image));
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )),
          BlocBuilder<CompanyManagementBloc, CompanyManagementState>(
            builder: (context, state) {
              if (state is CompanyManagementInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CompanyDetailsFetchingInProgress) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CompanyManagementFetchingError) {
                return Container();
              } else if (state is CompanyDetailsFetched) {
                return buildColumnWithData(locale, state, context, bloc);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget buildColumnWithData(LocaleBundle locale, CompanyDetailsFetched state, BuildContext context,
      CompanyManagementBloc companyManagementBloc) {
    return Column(
      children: [
        Center(
          child: Row(
            children: <Widget>[
              const Expanded(child: SizedBox()),
              Text(
                state.company.name,
                style: themeConfig.textStyles.primaryTitle,
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                  ),
                  shape: CircleBorder(),
                  onPressed: () => Get.to(
                      EditCompanyDetailsPage(company: state.company, companyImage: state.image)),
                ),
              )),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        companyInfoTile(state, locale.country, state.company.country),
        companyInfoTile(
            state,
            locale.visibilityStatus,
            state.company.visibilityStatus == VisibilityStatus.VISIBLE
                ? locale.visible
                : locale.hidden),
        companyInfoTile(
            state, locale.registered, state.company.registered ? locale.yes : locale.no),
        companyInfoTile(state, locale.numberOfSellers, state.company.profilesCount.toString()),
        ChoosableButton(
          text: "Log out",
          isChosen: false,
          chooseAction: () => Get.offAll(LoginPage()),
        )
      ],
    );
  }

  Padding companyInfoTile(CompanyDetailsFetched state, String leading, String trailing) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leading,
                style: themeConfig.textStyles.managementListTile,
              ),
              Text(
                trailing,
                style: themeConfig.textStyles.filledTextField,
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: themeConfig.colors.white, style: BorderStyle.solid))),
      ),
    );
  }

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }
}
