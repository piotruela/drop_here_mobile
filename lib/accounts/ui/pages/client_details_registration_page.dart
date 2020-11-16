import 'package:drop_here_mobile/accounts/bloc/client_details_registration_bloc/client_details_registration_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ClientDetailsRegistrationPage extends BlocWidget<ClientDetailsRegistrationBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  ClientDetailsRegistrationBloc bloc() => ClientDetailsRegistrationBloc();

  @override
  Widget build(
      BuildContext context, ClientDetailsRegistrationBloc bloc, BlocWidgetState widgetState) {
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
                    child: Text(Localization.of(context).bundle.addDetailsAboutBuyerHeader,
                        style: themeConfig.textStyles.secondaryTitle),
                  ),
                  BlocBuilder<ClientDetailsRegistrationBloc, ClientDetailRegistrationState>(
                      buildWhen: (previous, current) => previous.photo != current.photo,
                      builder: (context, state) {
                        if (state.type == ClientDetailRegistrationStateType.form_changed ||
                            state.type == ClientDetailRegistrationStateType.initial) {
                          return _buildColumn(bloc.state, bloc);
                        }
                        return Container();
                      }),
                  // _buildColumn(),
                  BlocBuilder<ClientDetailsRegistrationBloc, ClientDetailRegistrationState>(
                      buildWhen: (previous, current) => previous.firstName != current.firstName,
                      builder: (context, state) {
                        return DhTextFormField(
                            onChanged: (firstName) {
                              bloc.add(ChangeForm(firstName, state.lastName));
                            },
                            labelText: Localization.of(context).bundle.firstName,
                            padding:
                                EdgeInsets.only(left: 40, right: 40.0, top: 26.0, bottom: 9.0));
                      }),

                  BlocBuilder<ClientDetailsRegistrationBloc, ClientDetailRegistrationState>(
                      buildWhen: (previous, current) => previous.lastName != current.lastName,
                      builder: (context, state) {
                        return DhTextFormField(
                            onChanged: (lastName) {
                              bloc.add(ChangeForm(state.firstName, lastName));
                            },
                            labelText: Localization.of(context).bundle.lastName,
                            padding:
                                EdgeInsets.only(left: 40, right: 40.0, top: 13.0, bottom: 20.0));
                      }),

                  DhButton(
                    onPressed: () {
                      bloc.add(SubmitForm());
                    },
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

  Widget _buildColumn(ClientDetailRegistrationState state, ClientDetailsRegistrationBloc bloc) {
    return Stack(
      children: [
        Container(
          width: 110.0,
          height: 110.0,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(blurRadius: 4, color: Colors.grey.withOpacity(0.25), spreadRadius: 5)
            ],
          ),
          child: CircleAvatar(
            radius: 50.0,
            child: ClipOval(
              child: (state.photo != null)
                  ? Image.file(state.photo)
                  : CircleAvatar(
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
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: InkWell(
            onTap: () {
              bloc.add(AddPhoto());
            },
            child: CircleAvatar(
              radius: 20.0,
              backgroundColor: themeConfig.colors.secondary,
              child: CircleAvatar(
                backgroundColor: themeConfig.colors.primary1,
                radius: 18.0,
                child: Icon(
                  Icons.edit,
                  color: themeConfig.colors.background,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
