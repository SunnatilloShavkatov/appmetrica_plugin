// ignore_for_file: avoid_annotating_with_dynamic

import "package:appmetrica_plugin/appmetrica_plugin.dart";
import "package:appmetrica_plugin/src/appmetrica_api_pigeon.dart";

class ActivationConfigHolder {
  ActivationConfigHolder._();

  static bool _isActivated = false;

  static bool get activated => _isActivated;

  static AppMetricaConfig? _lastActivationConfig;

  static AppMetricaConfig? get lastActivationConfig => _lastActivationConfig;

  static set lastActivationConfig(AppMetricaConfig? value) {
    if (!_isActivated) {
      _isActivated = true;
    }
    activationListener?.call(value);
    _lastActivationConfig = value;
  }

  static Function(AppMetricaConfig?)? activationListener;
}

class ActivationCompleter {
  ActivationCompleter(this.config);

  final AppMetricaConfig config;

  Future<dynamic> complete(dynamic value) {
    _startFirstAutoTrackedSession(config.sessionsAutoTrackingEnabled);
    _reportAutoTrackedAppOpen(config.appOpenTrackingEnabled);
    ActivationConfigHolder.lastActivationConfig = config;
    return Future.value(value);
  }

  void onError(Object? error, StackTrace stackTrace) {
    ActivationConfigHolder.lastActivationConfig = null;
    if (error != null) {
      throw error;
    }
  }

  Future<void> _startFirstAutoTrackedSession(bool? sessionsAutoTracking) {
    if (ActivationConfigHolder.activated || false == sessionsAutoTracking) {
      return Future.value();
    } else {
      return AppMetricaPigeon().handlePluginInitFinished();
    }
  }

  Future<void> _reportAutoTrackedAppOpen(bool? appOpenTrackingEnabled) {
    if (ActivationConfigHolder.activated || false == appOpenTrackingEnabled) {
      return Future.value();
    } else {
      return InitialDeepLinkHolderPigeon()
          .getInitialDeeplink()
          .then((String? value) {
        if (value != null) {
          AppMetricaPigeon().reportAppOpen(value);
        }
      });
    }
  }
}
