import 'package:drop_here_mobile/accounts/bloc/edit_spot_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditSpotPage extends BlocWidget<EditSpotBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  EditSpotBloc bloc() => EditSpotBloc();

  @override
  Widget build(BuildContext context, EditSpotBloc editSpotBloc, _) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<EditSpotBloc, EditSpotFormState>(builder: (context, state) {
      return ListView();}
      ),
    );
  }
}
