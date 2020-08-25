import 'package:flutter/material.dart';

typedef TabBuilder<T> = Tab Function(T model);
typedef TabViewBuilder<T> = Widget Function(T model);

/// Widget budujący ekrany zbudowane na komponencie TabBarView. Znacznie upraszcza ich konstrukcję izolując powtarzalną część kodu.
class TabPageLayout<T> extends StatefulWidget {
  final TabController tabController;

  final Widget additionalAppBarWidget;
  final List<T> tabModels;

  final TabBuilder<T> tabBuilder;
  final TabViewBuilder<T> tabViewBuilder;
  final bool isScrollable;
  final int initialIndex;
  final String userActivityKey;

  /// Konstruktor ekranu z zakładkami
  /// Argumenty:

  /// - [tabModels] lista modeli
  /// - [tabBuilder] builder zwracający obiekt Tab na podstawie modelu zakładek ekranu
  /// - [tabViewBuilder] builder zwracający wnętrze zakładki na podstawie modelu
  /// - [tabController] obiekt typu TabController sterujący widokiem
  /// - [additionalAppBarWidget] opcjonalna lista dodatkowych pasków umieszczonych pod paskiem głównym ekranu
  /// - [isScrollable] opcjonalny parametr decydujący czy TabBar jest przesuwany
  /// - [initialIndex] opcjonalny parametr definiujący domyślnie wyświetlany widget
  TabPageLayout(
      {@required this.tabModels,
        @required this.tabBuilder,
        @required this.tabViewBuilder,
        this.tabController,
        this.additionalAppBarWidget,
        this.isScrollable = true,
        this.initialIndex = 0,
        this.userActivityKey});

  @override
  State<StatefulWidget> createState() => _TabPageLayoutState<T>();
}

class _TabPageLayoutState<T> extends State<TabPageLayout<T>> with SingleTickerProviderStateMixin {
  TabController tabController;
  bool _tabControllerWasPassedFromParent;

  @override
  void initState() {
    super.initState();
    _tabControllerWasPassedFromParent = widget.tabController != null;
    tabController = widget.tabController ??
        TabController(vsync: this, length: widget.tabModels.length, initialIndex: widget.initialIndex);
    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    _clearAnyFocusNode();
  }

  @override
  void dispose() {
    tabController.removeListener(_onTabChanged);
    if (!_tabControllerWasPassedFromParent) {
      tabController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        child: Column(
          children: [
            if (widget.additionalAppBarWidget != null) widget.additionalAppBarWidget,
            Expanded(child: _tabView(context)),
          ],
        ));
  }

  Widget _tabView(BuildContext context) {
    final themeData = Theme.of(context);
    final selectedLabelStyle = themeData.primaryTextTheme.button;
    final unSelectedLabelStyle = themeData.textTheme.button;
    final tabs = widget.tabModels.map((model) => widget.tabBuilder(model)).toList();
    final tabViews = widget.tabModels.map((model) => widget.tabViewBuilder(model)).toList();
//    final AppColors colors = locator.get<ThemeConfig>().colors;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TabBar(
        isScrollable: widget.isScrollable,
        controller: tabController,
        tabs: tabs,
        indicatorSize: TabBarIndicatorSize.tab,
        //the below seems redundant, but without the Colors set up they get overriden
        labelStyle: selectedLabelStyle,
        labelColor: selectedLabelStyle.color,
        unselectedLabelStyle: unSelectedLabelStyle,
        unselectedLabelColor: unSelectedLabelStyle.color,
        indicatorWeight: 1.0,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.indigo, width: 2.0),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            transform: Matrix4.translationValues(0.0, -0.5, 0.0),
            child: Divider(height: 0.0),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }

  void _clearAnyFocusNode() {
    if (!tabController.indexIsChanging) {
      return;
    }
    final focusNode = WidgetsBinding.instance.focusManager.primaryFocus;
    if (focusNode != null && focusNode.enclosingScope != null) {
      focusNode.unfocus();
    }
  }
}
