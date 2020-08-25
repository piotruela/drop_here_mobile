import 'dart:async';

import 'package:uuid/uuid.dart';

class SubscriptionManager {
  final Map<String, StreamSubscription<dynamic>> _subscriptions = {};

  int get count => _subscriptions.length;

  String add(StreamSubscription<dynamic> subscription, {String id}) {
    id ??= _randomId();
    _subscriptions[id] = subscription;
    return id;
  }

  void remove(String id) {
    _subscriptions.remove(id);
  }

  StreamSubscription<dynamic> get(String id) => _subscriptions[id];

  void clear() {
    _subscriptions.values.forEach((subscription) => subscription.cancel());
    _subscriptions.clear();
  }

  String _randomId() {
    return Uuid().v4();
  }
}
