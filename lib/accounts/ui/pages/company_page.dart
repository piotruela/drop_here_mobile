import 'package:drop_here_mobile/accounts/bloc/company_management_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CompanyPage extends BlocWidget<CompanyManagementBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final CompanyManagementBloc companyManagementBloc; // = CompanyManagementBloc();

  CompanyPage({this.companyManagementBloc});

  @override
  CompanyManagementBloc bloc() => companyManagementBloc..add(FetchCompanyDetails());

  @override
  Widget build(BuildContext context, CompanyManagementBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 54.0),
          child: CircleAvatar(
            radius: 50.0,
            child: ClipOval(
              child:
                  // (_image != null)
                  //     ? Image.file(_image):
                  CircleAvatar(
                backgroundColor: themeConfig.colors.primary1,
                radius: 50.0,
                child: Icon(
                  Icons.person,
                  color: themeConfig.colors.background,
                  size: 60.0,
                ),
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
        BlocBuilder<CompanyManagementBloc, CompanyManagementState>(
          builder: (context, state) {
            if (state is CompanyManagementInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CompanyManagementLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CompanyManagementFetchingError) {
              return Container(child: Text(state.error));
            } else if (state is CompanyManagementFetched) {
              return buildColumnWithData(locale, state, context, companyManagementBloc);
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget buildColumnWithData(LocaleBundle locale, CompanyManagementFetched state,
      BuildContext context, CompanyManagementBloc companyManagementBloc) {
    return Column(
      children: [
        Center(
          child: Text(
            state.company.name,
            style: themeConfig.textStyles.primaryTitle,
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
        //TODO change number of sellers
        companyInfoTile(state, locale.numberOfSellers, '1'),
      ],
    );
  }

  Padding companyInfoTile(CompanyManagementFetched state, String leading, String trailing) {
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
}
