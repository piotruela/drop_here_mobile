import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/filters_flat_button.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DhSearchBar(dhListBloc),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FiltersFlatButton(
                themeConfig: themeConfig,
                locale: locale,
                bloc: dhListBloc,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: FlatButton(
                onPressed: () {},
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  decoration: BoxDecoration(
                      color: themeConfig.colors.white,
                      boxShadow: [
                        dhShadow(),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Text(
                    'Add seller+',
                    style: themeConfig.textStyles.coloredFlatButton,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
