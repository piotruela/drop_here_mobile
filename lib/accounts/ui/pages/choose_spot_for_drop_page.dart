import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChooseSpotForDropPage extends BlocWidget<DhListBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  @override
  DhListBloc bloc() => DhListBloc()..add(FetchSpotsForDrop());

  @override
  Widget build(BuildContext context, DhListBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Text(
                locale.chooseSpotForDrop,
                style: themeConfig.textStyles.primaryTitle,
              ),
            ),
            DhSearchBar(bloc),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FiltersFlatButton(
                themeConfig: themeConfig,
                locale: locale,
                bloc: bloc,
              ),
            ),
            BlocBuilder<DhListBloc, DhListState>(
              builder: (context, state) {
                if (state is DhListInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ListLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchingError) {
                  return Container(
                      child: Column(
                    children: [
                      Text(state.error),
                      RaisedButton(onPressed: () => bloc.add(FetchSpotsForDrop()))
                    ],
                  ));
                } else if (state is SpotsForDropFetched) {
                  return buildColumnWithData(locale, state, context, bloc);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  SafeArea buildColumnWithData(
      LocaleBundle locale, SpotsForDropFetched state, BuildContext context, DhListBloc bloc) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.spots.length,
              itemBuilder: (BuildContext context, int index) {
                return DhCard1(
                  title: state.spots[index].name,
                  isActive: true,
                  dropsNumber: 1,
                  popupOptions: [locale.block],
                  state: bloc.state,
                  bloc: bloc,
                );
              }),
        ],
      ),
    );
  }
}

class DhCard1 extends StatelessWidget {
  final String title;
  final bool isActive;
  final int dropsNumber;
  final SpotsForDropFetched state;
  final DhListBloc bloc;
  final List<String> popupOptions;
  static int lastValue = 0;
  const DhCard1(
      {this.title, this.isActive, this.dropsNumber, this.state, this.bloc, this.popupOptions});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
          ),
          title: Text(
            title,
            style: themeConfig.textStyles.secondaryTitle,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              statusText(locale, themeConfig, isActive),
              Text(
                dropsNumber != null
                    ? locale.memberOf + ' ' + dropsNumber.toString() + ' ' + locale.spots
                    : '',
                style: themeConfig.textStyles.cardSubtitle,
              )
            ],
          ),
          // trailing: Radio(
          //   groupValue: state.radioValue,
          //   value: lastValue++,
          //   onChanged: (_) {
          //     bloc.add(ChangeGroupValue(state.radioValue));
          //   },
          // ),
        ),
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
      ),
    );
  }

  Row statusText(LocaleBundle locale, ThemeConfig themeConfig, bool isActive) {
    if (isActive) {
      return Row(
        children: [
          Text(
            locale.active,
            style: themeConfig.textStyles.active,
          ),
          Icon(
            Icons.check,
            color: themeConfig.colors.active,
          ),
        ],
      );
    }
    return Row(
      children: [
        Text(
          locale.blocked,
          style: themeConfig.textStyles.blocked,
        ),
        Icon(
          Icons.clear,
          color: themeConfig.colors.blocked,
        ),
      ],
    );
  }
}
