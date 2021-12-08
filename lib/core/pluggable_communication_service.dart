import 'package:flutter_ume/core/plugin_manager.dart';
import 'package:flutter_ume/util/exception_factory.dart';

import 'ui/global.dart';

abstract class Communicable {
  void handleParams(dynamic params);
}

class PluggableCommunicationService {
  static final PluggableCommunicationService _instance =
      PluggableCommunicationService._internal();
  factory PluggableCommunicationService() {
    return _instance;
  }
  PluggableCommunicationService._internal();

  void callWithKey(String pluggableKey, dynamic params) {
    if (!PluginManager.instance.pluginsMap.containsKey(pluggableKey)) {
      throw ExceptionFactory.pluggableCommunicationNonexistKeyException;
    }
    if (!(PluginManager.instance.pluginsMap[pluggableKey] is Communicable)) {
      throw ExceptionFactory.pluggableCommunicationNotCommunicableException;
    }
    umeEventBus.fire(PluggableChangedEvent(pluggableKey, params: params));
  }
}

class PluggableChangedEvent {
  String pluggableKey;
  Object? params;
  PluggableChangedEvent(this.pluggableKey, {this.params});
}
