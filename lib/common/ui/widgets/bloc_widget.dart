import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/common/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class BlocWidget<T extends Bloc> extends StatefulWidget {
  final SubscriptionManager subscriptionManager = SubscriptionManager();

  BlocWidget();

  T bloc();

  Widget build(BuildContext context, T bloc, BlocWidgetState<T> widgetState);

  void dispose(T bloc) {}

  @protected
  void init(BuildContext context, T bloc, SubscriptionManager subscriptionManager) {}

  @protected
  void didUpdateWidget(BlocWidget oldWidget, T bloc) {}

  @override
  BlocWidgetState<T> createState() => BlocWidgetState<T>(Lazy(bloc));
}

class BlocWidgetState<T extends Bloc> extends State<BlocWidget<T>> with TickerProviderStateMixin {
  BlocWidgetState(this.bloc);

  @protected
  final Lazy<T> bloc;

  @override
  void initState() {
    super.initState();
    widget.init(context, bloc.value, widget.subscriptionManager);
  }

  @override
  void didUpdateWidget(BlocWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.didUpdateWidget(oldWidget, bloc.value);
  }

  @override
  void dispose() {
    widget.dispose(bloc.value);
    widget.subscriptionManager.clear();
    bloc.value.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildForChildrenWithMixins(context);
  }

  /// This build method was created to distinguish build methods in the case of using both
  /// extension and mixin. When needed call this method directly instead of using normal build method.
  ///
  Widget buildForChildrenWithMixins(BuildContext context) {
    return BlocProvider<T>(
      create: (context) => bloc.value,
      child: widget.build(context, bloc.value, this),
    );
  }
}

typedef Factory<T> = T Function();

class Lazy<T> {
  T _value;
  Factory<T> factory;

  Lazy(this.factory);

  T get value {
    _value ??= factory.call();
    return _value;
  }

  Lazy<T> forceRefresh() {
    return _LazyRefresh(this);
  }
}

class _LazyRefresh<T> extends Lazy<T> {
  _LazyRefresh(Lazy lazy) : super(lazy.factory);

/*@override
  T get value {
    return factory.call();
  }*/
}
