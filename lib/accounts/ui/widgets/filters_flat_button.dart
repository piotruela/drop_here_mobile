import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:flutter/material.dart';

class FiltersFlatButton extends StatelessWidget {
  final ThemeConfig themeConfig;
  final LocaleBundle locale;
  final DhListBloc bloc;

  const FiltersFlatButton({
    @required this.themeConfig,
    @required this.locale,
    @required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: GestureDetector(
        onTap: () => {bloc.add(FilterClients())},
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          decoration: BoxDecoration(
              border: Border.all(color: themeConfig.colors.addSthHere),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.filter_list),
              Text(
                locale.filters,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
