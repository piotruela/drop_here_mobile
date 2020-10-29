import 'package:drop_here_mobile/accounts/bloc/company_register_details_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/map_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CompanyDetailsRegistrationPage extends BlocWidget<CompanyRegisterDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  CompanyRegisterDetailsBloc bloc() => CompanyRegisterDetailsBloc()..add(FormInitialized());

  @override
  Widget build(BuildContext context, CompanyRegisterDetailsBloc bloc, _) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return MainLayout(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<CompanyRegisterDetailsBloc, CompanyRegistrationDetailsFormState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state is ErrorState) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content:
                          Text(localeBundle.registrationError + localeBundle.unexpectedError)));
                }
                if (state is SuccessState) {
                  Get.to(MapPage());
                } else {}
              },
              child: pageBody(bloc, context),
            )));
  }

  Widget pageBody(CompanyRegisterDetailsBloc bloc, BuildContext context) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return Center(
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
                  onChanged: (value) =>
                      bloc.add(FormChanged(form: bloc.state.form.copyWith(companyName: value)))),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40.0),
                child: BlocBuilder<CompanyRegisterDetailsBloc, CompanyRegistrationDetailsFormState>(
                  buildWhen: (previous, current) =>
                      previous.countries != current.countries || previous.form != current.form,
                  builder: (context, state) {
                    if (state?.countries?.isNotEmpty ?? false) {
                      return DropdownButton<String>(
                        hint: Text("Country"),
                        value: state.form.countryName,
                        isExpanded: true,
                        items: List<DropdownMenuItem<String>>.generate(
                          bloc.state?.countries?.length,
                          (int index) => DropdownMenuItem<String>(
                            value: bloc.state.countries.elementAt(index).name,
                            child: Text(bloc.state.countries.elementAt(index).name),
                          ),
                        ),
                        onChanged: (String chosenCountry) => bloc.add(FormChanged(
                            form: bloc.state.form.copyWith(countryName: chosenCountry))),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
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
    );
  }
}
