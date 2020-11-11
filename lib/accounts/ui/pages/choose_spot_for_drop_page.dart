import 'package:drop_here_mobile/accounts/bloc/choose_spot_for_drop_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/ui/widgets/spot_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChooseSpotForDropPage extends BlocWidget<ChooseSpotForDropBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final SpotCompanyResponse selectedSpot;

  ChooseSpotForDropPage({this.selectedSpot});
  @override
  ChooseSpotForDropBloc bloc() => ChooseSpotForDropBloc()..add(AddSpotToDropPageEntered(selectedSpot: selectedSpot));

  @override
  Widget build(BuildContext context, ChooseSpotForDropBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                child: Text(
                  localeBundle.chooseSpotForDrop,
                  style: themeConfig.textStyles.primaryTitle,
                ),
              ),
              BlocBuilder<ChooseSpotForDropBloc, ChooseSpotForDropState>(
                builder: (context, state) {
                  if (state.type == ChooseSpotForDropStateType.loading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return buildColumnWithData(localeBundle, context, bloc);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea buildColumnWithData(LocaleBundle locale, BuildContext context, ChooseSpotForDropBloc bloc) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (SpotCompanyResponse spot in bloc.state.spots ?? [])
              CompanyDropSpotCard(spot: spot, onTap: () => Get.back(result: spot))
          ],
        ),
      ),
    );
  }
}
