import 'package:drop_here_mobile/accounts/bloc/edit_spot_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/row_text_and_slider.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditSpotPage extends BlocWidget<EditSpotBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  EditSpotBloc bloc() => EditSpotBloc();

  @override
  Widget build(BuildContext context, EditSpotBloc editSpotBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<EditSpotBloc, EditSpotFormState>(builder: (context, state) {
          return Padding(
              padding: EdgeInsets.only(left: 23.0),
              child: ListView(
                children: [
                  Text(
                    locale.editSpot,
                    style: themeConfig.textStyles.primaryTitle,
                  ),
                  Text(
                    locale.nameMandatory,
                    style: themeConfig.textStyles.secondaryTitle,
                  ),
                  DhPlainTextFormField(
                    onChanged: (String name) {
                      editSpotBloc
                          .add(FormChanged(spot: state.spotManagementRequest.copyWith(name: name)));
                    },
                  ),
                  rowTextAndSlider(text: locale.passwordRequired),
                ],
              ));
        }),
      ),
    );
  }
}
