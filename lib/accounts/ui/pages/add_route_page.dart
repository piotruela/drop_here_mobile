import 'package:drop_here_mobile/accounts/ui/widgets/colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/bloc/add_route_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class AddRoutePage extends BlocWidget<AddRouteBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  @override
  bloc() => AddRouteBloc();

  @override
  Widget build(BuildContext context, AddRouteBloc addRouteBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              Localization.of(context).bundle.planRoute,
              style: themeConfig.textStyles.primaryTitle,
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  secondaryTitle(locale.nameMandatory),
                  DhPlainTextFormField(
                    hintText: locale.routeNameExample,
                    onChanged: (String name) {
                      // addProductBloc.add(FormChanged(
                      //     productManagementRequest: addProductBloc.state.productManagementRequest
                      //         .copyWith(name: name, productCustomizationWrappers: [])));
                    },
                  ),
                  secondaryTitle(locale.dateMandatory),
                  BlocBuilder<AddRouteBloc, AddRouteFormState>(
                      buildWhen: (previous, current) =>
                          previous.routeRequest.date != current.routeRequest.date,
                      builder: (context, state) => Conditional.single(
                            context: context,
                            conditionBuilder: (_) => state.routeRequest.date == null,
                            widgetBuilder: (_) =>
                                _buildDatePickerButton(locale, context, addRouteBloc),
                            fallbackBuilder: (_) => Text('a'),
                          )),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  ColoredRoundedFlatButton _buildDatePickerButton(
      LocaleBundle locale, BuildContext context, AddRouteBloc bloc) {
    return ColoredRoundedFlatButton(
      text: locale.pickADate,
      onTap: () async {
        var a = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 10, 1, 1));
        print(a);
        bloc.add(AddDate(pickedDate: a));
      },
    );
  }

  Text secondaryTitle(String text) {
    return Text(
      text,
      style: themeConfig.textStyles.secondaryTitle,
    );
  }
}
