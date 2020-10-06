import 'package:drop_here_mobile/accounts/bloc/create_new_item_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewItemPage extends BlocWidget<CreateNewItemBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  // ignore: close_sinks
  final CreateNewItemBloc createNewItemBloc = CreateNewItemBloc();

  @override
  bloc() => createNewItemBloc;

  @override
  Widget build(BuildContext context, CreateNewItemBloc bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                locale.addNew,
                style: themeConfig.textStyles.primaryTitle,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.0 / 8.0,
                crossAxisCount: 2,
              ),
              children: [
                cardButton(() {
                  bloc.add(CreateNewProduct());
                }, locale.product, Icons.shopping_basket),
                cardButton(() {
                  bloc.add(CreateNewSpot());
                }, locale.spot, Icons.store),
              ],
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.0 / 8.0,
                crossAxisCount: 2,
              ),
              children: [
                cardButton(() {
                  bloc.add(CreateNewRoute());
                }, locale.route, Icons.map),
                cardButton(() {
                  bloc.add(CreateNewProfile());
                }, locale.profile, Icons.person),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardButton(Function onTap, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 100.0,
                color: themeConfig.colors.primary1,
              ),
              Text(
                text,
                style: themeConfig.textStyles.secondaryTitle,
              )
            ],
          ),
        )),
      ),
    );
  }
}
