import 'package:drop_here_mobile/accounts/bloc/company_register_details_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

List<DropdownMenuItem> countries = [
  DropdownMenuItem(child: Text('Italy'), value: 'Italy'),
  DropdownMenuItem(child: Text('United States'), value: 'United States'),
  DropdownMenuItem(child: Text('Poland'), value: 'Poland')
];

class CompanyDetailsRegistrationPage extends BlocWidget<CompanyRegisterDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  CompanyRegisterDetailsBloc bloc() => CompanyRegisterDetailsBloc();

  @override
  Widget build(BuildContext context, CompanyRegisterDetailsBloc bloc, _) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 144.0, bottom: 22.0),
                    child: Text(localeBundle.addDetailsAboutCompanyHeader,
                        style: themeConfig.textStyles.secondaryTitle),
                  ),
                  DhTextFormField(
                      labelText: localeBundle.companyName,
                      padding: EdgeInsets.only(left: 40, right: 40.0, top: 26.0, bottom: 9.0),
                      onChanged: (value) => bloc
                          .add(FormChanged(form: bloc.state.form.copyWith(companyName: value)))),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40.0),
                    child: SizedBox(
                      height: 70,
                      child: SearchableDropdown.single(
                          style: themeConfig.textStyles.filledTextField,
                          hint: Text(localeBundle.pickACountry,
                              style: themeConfig.textStyles.textFieldHint),
                          isExpanded: true,
                          items: countries,
                          onChanged: (value) => bloc.add(
                              FormChanged(form: bloc.state.form.copyWith(countryName: value)))),
                    ),
                  ),
                  DhButton(
                    onPressed: () => bloc.add(FormSubmitted(form: bloc.state.form)),
                    text: Localization.of(context).bundle.continueText,
                    backgroundColor: themeConfig.colors.primary1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
