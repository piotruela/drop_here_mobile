import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellersListPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final DhListBloc dhListBloc;

  SellersListPage({this.dhListBloc});

  @override
  DhListBloc bloc() => dhListBloc;

  @override
  Widget build(BuildContext context, DhListBloc dhListBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Container();
  }
}
