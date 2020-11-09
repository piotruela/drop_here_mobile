import 'package:drop_here_mobile/accounts/bloc/client_details_management_bloc/client_details_management_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ClientDetailsManagementPage extends BlocWidget<ClientDetailsManagementBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  ClientDetailsManagementPage();
  @override
  ClientDetailsManagementBloc bloc() => ClientDetailsManagementBloc();

  @override
  Widget build(BuildContext context, ClientDetailsManagementBloc bloc, _) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<ClientDetailsManagementBloc, ClientDetailsManagementState>(
                builder: (context, state) => Column(
                      children: [Text(bloc.state.customerResponse.firstName)],
                    )),
          ],
        ),
      ),
    );
  }
}
