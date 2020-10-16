import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_new_item_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends BlocWidget<DhListBloc> {
  @override
  DhListBloc bloc() => DhListBloc();
  @override
  Widget build(BuildContext context, DhListBloc bloc, _) {
    PanelController pc1 = PanelController();
    PanelController pc2 = PanelController();
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: Marker(),
            initialPosition: GeoCoord(54.397498, 18.589627),
          ),
          SlidingUpPanel(
            controller: pc2,
            panel: Column(
              children: [
                panelHeader(context, pc2),
                DhSearchBar(DhListBloc()),
                //TODO: Add List
              ],
            ),
            minHeight: 120,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          SlidingUpPanel(
            controller: pc1,
            panel: CreateNewItemPage(),
            minHeight: 10,
            maxHeight: 630,
            header: panelHeader(context, pc1),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: DHBottomBar(
                selectedIndex: 2,
                controller: pc1,
              ))
        ],
      ),
    );
  }

  Widget panelHeader(BuildContext context, PanelController panelController) {
    ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: SizedBox(
              height: 30,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  child: RaisedButton(onPressed: () => panelController.close()),
                  decoration: BoxDecoration(
                      color: themeConfig.colors.textFieldHint,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ))),
        //DHBottomBar(controller: panelController)
      ],
    );
  }
}
