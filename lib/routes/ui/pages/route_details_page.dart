import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/routes/bloc/route_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteDetailsPage extends BlocWidget<RouteDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  bloc() => RouteDetailsBloc();
  @override
  Widget build(BuildContext context, bloc, _) {
    LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
      body: Container(),
    );
  }
}
