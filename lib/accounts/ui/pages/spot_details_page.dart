import 'package:drop_here_mobile/accounts/bloc/spot_details_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SpotDetailsPage extends BlocWidget<SpotDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final SpotDetailsBloc spotDetailsBloc;

  SpotDetailsPage({this.spotDetailsBloc});

  @override
  SpotDetailsBloc bloc() => spotDetailsBloc..add(FetchSpotDetails());

  @override
  Widget build(BuildContext context, SpotDetailsBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return (Scaffold(
      body: SafeArea(
        child: BlocBuilder<SpotDetailsBloc, SpotDetailsState>(
          builder: (context, state) {
            if (state is SpotDetailsInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SpotDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SpotDetailsFetchingError) {
              return Container(child: Text(state.error));
            } else if (state is SpotDetailsFetched) {
              return buildColumnWithData(locale, state);
            }
            return Container();
          },
        ),
      ),
    ));
  }

  Widget buildColumnWithData(LocaleBundle locale, SpotDetailsFetched state) {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0),
      child: ListView(
        children: [
          Text(
            state.spot.name,
            style: themeConfig.textStyles.primaryTitle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Icon(
                Icons.pin_drop,
                color: themeConfig.colors.black,
              ),
              Text(
                //TODO change to name of localization
                'x: ' +
                    state.spot.xcoordinate.toString() +
                    ', y: ' +
                    state.spot.ycoordinate.toString(),
                style: themeConfig.textStyles.filledTextField,
              )
            ],
          ),
          textAndFlatButton(
              locale.passwordRequired, state.spot.requiredPassword ? locale.yes : locale.no),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    locale.password,
                    style: themeConfig.textStyles.dataAnnotation,
                  ),
                  Icon(Icons.more_horiz),
                ],
              ),
              Text('ab')
            ],
          ),
        ],
      ),
    );
  }

  Padding textAndFlatButton(String text, String flatButtonText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: themeConfig.textStyles.dataAnnotation,
          ),
          RoundedFlatButton(
            text: flatButtonText,
          ),
        ],
      ),
    );
  }
}
