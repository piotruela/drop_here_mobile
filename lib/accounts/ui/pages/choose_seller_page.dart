import 'package:drop_here_mobile/accounts/bloc/choose_seller_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
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

class ChooseSellerPage extends BlocWidget<ChooseSellerBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final Function addSeller;

  ChooseSellerPage({this.addSeller});
  @override
  ChooseSellerBloc bloc() => ChooseSellerBloc()..add(FetchSellers());

  @override
  Widget build(BuildContext context, ChooseSellerBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      floatingActionButton: SubmitFormButton(
        isActive: true,
        text: locale.submit,
        onTap: () {
          if (bloc.state is SellersFetched) {
            SellersFetched state = bloc.state;
            addSeller(
                state.sellers[state.radioValue].profileUid,
                state.sellers[state.radioValue].firstName,
                state.sellers[state.radioValue].lastName);
          }
          //TODO add action
          //addSeller(bloc.state.spots[bloc.state.radioValue]);

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
                locale.chooseSeller,
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
            BlocBuilder<ChooseSellerBloc, ChooseSellerState>(
              builder: (context, state) {
                if (state is ChooseSellerInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SellersFetchingError) {
                  return Container(
                      child: Column(
                    children: [
                      Text('try again'),
                      RaisedButton(onPressed: () => bloc.add(FetchSellers()))
                    ],
                  ));
                } else if (state is SellersFetched) {
                  return buildColumnWithData(locale, context, bloc, state);
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
      LocaleBundle locale, BuildContext context, ChooseSellerBloc bloc, SellersFetched state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: state.sellers.length,
                itemBuilder: (BuildContext context, int index) {
                  return SellerCard(
                    state: state,
                    bloc: bloc,
                    index: index,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class SellerCard extends StatelessWidget {
  final ChooseSellerBloc bloc;
  final int index;
  final SellersFetched state;
  const SellerCard({this.bloc, this.index, this.state});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
          ),
          title: Text(
            state.sellers[index].firstName + ' ' + state.sellers[index].lastName,
            style: themeConfig.textStyles.secondaryTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
          trailing: Radio(
            groupValue: state.radioValue,
            value: index,
            onChanged: (_) {
              bloc.add(ChangeGroupValue(index, state.sellers));
            },
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
    );
  }
}
