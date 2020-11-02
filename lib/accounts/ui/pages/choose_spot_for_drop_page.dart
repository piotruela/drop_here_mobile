import 'package:drop_here_mobile/accounts/bloc/choose_spot_for_drop_bloc.dart';
import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/get_address_from_coordinates.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChooseSpotForDropPage extends BlocWidget<ChooseSpotForDropBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final Function addSpot;

  ChooseSpotForDropPage({this.addSpot});
  @override
  ChooseSpotForDropBloc bloc() => ChooseSpotForDropBloc()..add(FetchSpotsForDrop());

  @override
  Widget build(BuildContext context, ChooseSpotForDropBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      floatingActionButton: SubmitFormButton(
        isActive: true,
        text: locale.submit,
        onTap: () {
          addSpot(bloc.state.spots[bloc.state.radioValue]);
          Get.back();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            BlocBuilder<ChooseSpotForDropBloc, ChooseSpotForDropState>(
              builder: (context, state) {
                if (state is ChooseSpotForDropInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchingError) {
                  return Container(
                      child: Column(
                    children: [
                      Text('try again'),
                      RaisedButton(onPressed: () => bloc.add(FetchSpotsForDrop()))
                    ],
                  ));
                } else if (state is SpotsForDropFetched) {
                  return buildColumnWithData(locale, context, bloc);
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
      LocaleBundle locale, BuildContext context, ChooseSpotForDropBloc bloc) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: bloc.state.spots.length,
              itemBuilder: (BuildContext context, int index) {
                return SpotRadioCard(
                  bloc: bloc,
                  index: index,
                );
              }),
        ],
      ),
    );
  }
}

class SpotRadioCard extends StatelessWidget {
  final ChooseSpotForDropBloc bloc;
  final int index;
  const SpotRadioCard({this.bloc, this.index});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: GestureDetector(
        onTap: () {
          bloc.add(ChangeGroupValue(index, bloc.state.spots));
        },
        child: Container(
          child: ListTile(
            leading: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.store,
            ),
            title: Text(
              bloc.state.spots[index].name,
              style: themeConfig.textStyles.secondaryTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bloc.state.spots[index].description ?? '',
                  style: themeConfig.textStyles.cardSubtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                FutureBuilder(
                    future: getAddressFromCoordinates(bloc.state.spots[index].xcoordinate,
                            bloc.state.spots[index].ycoordinate) ??
                        '',
                    initialData: "Loading location...",
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return Text(
                        snapshot.data ?? "",
                        style: themeConfig.textStyles.cardSubtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }),
              ],
            ),
            trailing: Radio(
              groupValue: bloc.state.radioValue,
              value: index,
              //onChanged: (_) {},
              // onChanged: (_) {
              //   bloc.add(ChangeGroupValue(index, bloc.state.spots));
              // },
            ),
          ),
          decoration: BoxDecoration(
            color: themeConfig.colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              dhShadow(),
            ],
          ),
        ),
      ),
    );
  }
}
