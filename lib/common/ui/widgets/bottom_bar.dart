import 'package:drop_here_mobile/common/config/bottom_bar_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/model/bottom_bar_item.dart';
import 'package:drop_here_mobile/common/navigation/app_navigation_observer.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<BottomBarItem> items = locator<BottomBarConfig>().tabBarItems;

//  int _currentIndex = 0;

  int get _selectedIndex {
//    return _currentIndex;
    final notifier = AppInheritedNavigationNotifier.of(context).notifier;

    return notifier.value.activeBottomBarItemIndex;
  }

  void _onItemTapped(int index) {
    final item = items.elementAt(index);
//    setState(() {
//      _currentIndex = index;
//    });
    item.navigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => _onItemTapped(index),
      type: BottomNavigationBarType.fixed,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: item.icon,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(item.text(context)),
          ),
        );
      }).toList(),
      key: Key("mainBottomBar"),
    );
  }
}
