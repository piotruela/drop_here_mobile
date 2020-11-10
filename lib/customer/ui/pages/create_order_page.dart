import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/customer/bloc/create_order_bloc.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreateOrderPage extends BlocWidget<CreateOrderBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  bloc() => CreateOrderBloc();

  @override
  Widget build(BuildContext context, CreateOrderBloc createOrderBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) => _buildPageContent()),
    );
  }

  SafeArea _buildPageContent() => SafeArea(
          child: Column(
        children: [],
      ));
}
